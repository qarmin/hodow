// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiMemoryRequirementInvarianceTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiBufferAndImageAllocationUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Shader-free: every case creates buffers and images and compares what the driver says
// about their memory requirements.
//
// `IObjectAllocator`'s `de::MovePtr<IObjectAllocator> objs[testCycles]` is a `Vec` of boxed
// trait objects here, and `IBufferAllocator`/`IImageAllocator` (suballocation versus dedicated
// allocation) are the `dedicated` flag of the one struct that uses them.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, DeviceV1_3, KhrMaintenance4ExtensionDeviceCommands};

use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::mem_util::{Allocation, MemoryRequirement};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `testCycles`
const TEST_CYCLES: usize = 1000;

/// `legalMemoryTypeCount`
const LEGAL_MEMORY_TYPE_COUNT: usize = 11;

/// `legalMemoryTypes` - all legal memory combinations (spec chapter 10.2: Device Memory).
fn legal_memory_types() -> [MemoryRequirement; LEGAL_MEMORY_TYPE_COUNT] {
    [
        MemoryRequirement::ANY,
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED,
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED | MemoryRequirement::COHERENT,
        MemoryRequirement::LOCAL,
        MemoryRequirement::LOCAL | MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        MemoryRequirement::LOCAL | MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED,
        MemoryRequirement::LOCAL
            | MemoryRequirement::HOST_VISIBLE
            | MemoryRequirement::CACHED
            | MemoryRequirement::COHERENT,
        MemoryRequirement::LOCAL | MemoryRequirement::LAZILY_ALLOCATED,
        MemoryRequirement::PROTECTED,
        MemoryRequirement::PROTECTED | MemoryRequirement::LOCAL,
    ]
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    BasicInvariance,
    RequirementsMatching,
    DedicatedRequirements,
}

/// `formats::allFormats`, in upstream's order: the core formats, with the two
/// VK_KHR_maintenance5 ones slotted in after `A1R5G5B5_UNORM_PACK16`, then the YCbCr formats,
/// the ASTC HDR formats, the YCbCr 2-plane 444 formats and the 4444 formats.
pub fn all_formats() -> Vec<vk::Format> {
    let mut formats = Vec::new();
    formats.extend((1..=8).map(vk::Format::from_raw));
    formats.push(vk::Format::A1B5G5R5_UNORM_PACK16);
    formats.push(vk::Format::A8_UNORM);
    formats.extend((9..=184).map(vk::Format::from_raw));
    formats.extend((1000156000..=1000156033).map(vk::Format::from_raw));
    formats.extend((1000066000..=1000066013).map(vk::Format::from_raw));
    formats.extend((1000330000..=1000330003).map(vk::Format::from_raw));
    formats.extend((1000340000..=1000340001).map(vk::Format::from_raw));
    formats
}

const YCBCR_FIRST: i32 = 1000156000;
const YCBCR_LAST: i32 = 1000156033;

/// `vk::isYCbCrFormat` (`ycbcrFormats` plus `ycbcrCompatibileFormats`, which lie in the same range)
pub fn is_ycbcr_format(format: vk::Format) -> bool {
    (YCBCR_FIRST..=YCBCR_LAST).contains(&format.as_raw())
}

/// `vk::isYCbCrExtensionFormat`
fn is_ycbcr_extension_format(format: vk::Format) -> bool {
    (1000330000..=1000330003).contains(&format.as_raw())
}

/// `vk::isYCbCr420Format`
fn is_ycbcr_420_format(format: vk::Format) -> bool {
    let raw = format.as_raw();
    [2, 3, 12, 13, 22, 23, 29, 30]
        .iter()
        .any(|offset| raw == YCBCR_FIRST + offset)
}

/// `vk::isYCbCr422Format`
fn is_ycbcr_422_format(format: vk::Format) -> bool {
    let raw = format.as_raw();
    [0, 1, 4, 5, 10, 11, 14, 15, 20, 21, 24, 25, 27, 28, 31, 32]
        .iter()
        .any(|offset| raw == YCBCR_FIRST + offset)
}

/// `vk::isPvrtcFormat`
fn is_pvrtc_format(format: vk::Format) -> bool {
    (1000054000..=1000054007).contains(&format.as_raw())
}

/// `vk::isPvrtc1Format`
fn is_pvrtc1_format(format: vk::Format) -> bool {
    [0, 1, 4, 5].iter().any(|offset| format.as_raw() == 1000054000 + offset)
}

fn is_format_a8_or_a1b5g5r5(format: vk::Format) -> bool {
    format == vk::Format::A8_UNORM || format == vk::Format::A1B5G5R5_UNORM_PACK16
}

/// `IObjectAllocator`
trait ObjectAllocator<'a> {
    fn allocate(&mut self, context: &'a Context<'a>) -> Result<(), TestError>;
    fn deallocate(&mut self);
    fn get_size(&self, context: &Context<'_>) -> usize;
}

/// `BufferAllocator`
struct BufferAllocator<'a> {
    dedicated: bool,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
    memory_type: usize,
    // Declared buffer-first so a plain drop destroys the buffer before it frees its memory.
    buffer: Option<Unique<'a, vk::Buffer>>,
    buffer_alloc: Option<Allocation<'a>>,
}

impl BufferAllocator<'_> {
    fn new(random: &mut Random, dedicated: bool, memory_types: &[usize]) -> Self {
        // If dedicated allocation is supported, randomly pick it
        let dedicated = dedicated && random.get_bool();
        // Random buffer sizes to find potential issues caused by strange alignment
        let size = vk::DeviceSize::from(random.get_uint32() % 1024) + 7;
        // Pick a random usage from the 9 VkBufferUsageFlags.
        let usage = vk::BufferUsageFlags::from_bits_truncate(1 << (random.get_uint32() % 9));
        // Pick random memory type from the supported ones
        let memory_type = memory_types[random.get_uint32() as usize % memory_types.len()];

        BufferAllocator {
            dedicated,
            size,
            usage,
            memory_type,
            buffer: None,
            buffer_alloc: None,
        }
    }
}

impl<'a> ObjectAllocator<'a> for BufferAllocator<'a> {
    fn allocate(&mut self, context: &'a Context<'a>) -> Result<(), TestError> {
        let vk = context.get_device();
        let alloc = context.get_default_allocator();
        let requirement = legal_memory_types()[self.memory_type];

        let buffer_params = vk::BufferCreateInfo {
            s_type: vk::StructureType::BUFFER_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::BufferCreateFlags::empty(),
            size: self.size,
            usage: self.usage,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
        };

        let raw_buffer = unsafe { vk.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?;
        let buffer = Unique::new(vk, raw_buffer);

        let mem_reqs = unsafe { vk.get_buffer_memory_requirements(*buffer) };
        let memory = if self.dedicated {
            alloc.allocate_dedicated_buffer(vk, mem_reqs, requirement, *buffer)
        } else {
            alloc.allocate(vk, mem_reqs, requirement)
        };
        self.buffer = Some(buffer);
        let memory = memory?;

        unsafe { vk.bind_buffer_memory(raw_buffer, memory.get_memory(), memory.get_offset()) }
            .vk_check("vkBindBufferMemory")?;
        self.buffer_alloc = Some(memory);
        Ok(())
    }

    fn deallocate(&mut self) {
        self.buffer = None;
        self.buffer_alloc = None;
    }

    fn get_size(&self, context: &Context<'_>) -> usize {
        let vk = context.get_device();
        let buffer = self
            .buffer
            .as_ref()
            .expect("get_size on a buffer that was not allocated");
        let mem_req = unsafe { vk.get_buffer_memory_requirements(**buffer) };
        mem_req.size as usize
    }
}

/// `ImageAllocator`
struct ImageAllocator<'a> {
    dedicated: bool,
    linear: bool,
    size: (u32, u32),
    color_format: vk::Format,
    memory_type: usize,
    image: Option<Unique<'a, vk::Image>>,
    image_alloc: Option<Allocation<'a>>,
}

impl ImageAllocator<'_> {
    fn new(
        random: &mut Random,
        dedicated: bool,
        linear_formats: &[vk::Format],
        optimal_formats: &[vk::Format],
        memory_types: &[usize],
    ) -> Result<Self, TestError> {
        // If dedicated allocation is supported, pick it randomly
        let dedicated = dedicated && random.get_bool();
        // If linear formats are supported, pick it randomly
        let linear = !linear_formats.is_empty() && random.get_bool();

        let candidates = if linear { linear_formats } else { optimal_formats };
        if candidates.is_empty() {
            return Err(TestError::NotSupported("No image formats to pick from".to_string()));
        }
        let color_format = candidates[random.get_uint32() as usize % candidates.len()];

        let size = if is_pvrtc1_format(color_format) {
            // See VUID-VkImageCreateInfo-format-09583 and VUID-VkImageCreateInfo-format-09584
            // PVRTC1 textures have to have both a width and height that is a power of 2.
            let width = 1u32 << (random.get_uint32() % 4 + 1);
            let height = 1u32 << (random.get_uint32() % 4 + 1);
            (width, height)
        } else {
            let width_alignment = if is_ycbcr_420_format(color_format) || is_ycbcr_422_format(color_format) {
                2
            } else {
                1
            };
            let height_alignment = if is_ycbcr_420_format(color_format) { 2 } else { 1 };

            // Random small size for causing potential alignment issues
            let width = (random.get_uint32() % 16 + 3) & !(width_alignment - 1);
            let height = (random.get_uint32() % 16 + 3) & !(height_alignment - 1);
            (width, height)
        };

        // Pick random memory type from the supported set
        let memory_type = memory_types[random.get_uint32() as usize % memory_types.len()];

        Ok(ImageAllocator {
            dedicated,
            linear,
            size,
            color_format,
            memory_type,
            image: None,
            image_alloc: None,
        })
    }
}

impl<'a> ObjectAllocator<'a> for ImageAllocator<'a> {
    fn allocate(&mut self, context: &'a Context<'a>) -> Result<(), TestError> {
        let vk = context.get_device();
        let alloc = context.get_default_allocator();
        let requirement = legal_memory_types()[self.memory_type];
        let tiling = if self.linear {
            vk::ImageTiling::LINEAR
        } else {
            vk::ImageTiling::OPTIMAL
        };

        let color_image_params = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: self.color_format,
            extent: vk::Extent3D {
                width: self.size.0,
                height: self.size.1,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling,
            usage: if self.linear {
                vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST
            } else {
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC
            },
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };

        let raw_image = unsafe { vk.create_image(&color_image_params, None) }.vk_check("vkCreateImage")?;
        let image = Unique::new(vk, raw_image);

        let mem_reqs = unsafe { vk.get_image_memory_requirements(*image) };
        let memory = if self.dedicated {
            alloc.allocate_dedicated_image(vk, mem_reqs, requirement, *image)
        } else {
            alloc.allocate(vk, mem_reqs, requirement)
        };
        self.image = Some(image);
        let memory = memory?;

        unsafe { vk.bind_image_memory(raw_image, memory.get_memory(), memory.get_offset()) }
            .vk_check("vkBindImageMemory")?;
        self.image_alloc = Some(memory);
        Ok(())
    }

    fn deallocate(&mut self) {
        self.image = None;
        self.image_alloc = None;
    }

    fn get_size(&self, context: &Context<'_>) -> usize {
        let vk = context.get_device();
        let image = self
            .image
            .as_ref()
            .expect("get_size on an image that was not allocated");
        let mem_req = unsafe { vk.get_image_memory_requirements(**image) };
        mem_req.size as usize
    }
}

/// `InvarianceInstance`
struct InvarianceInstance<'a> {
    context: &'a Context<'a>,
    random: Random,
}

impl<'a> TestInstance for InvarianceInstance<'a> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let is_dedicated_allocation_supported =
            context.is_device_functionality_supported("VK_KHR_dedicated_allocation");
        let is_ycbcr_supported = context.is_device_functionality_supported("VK_KHR_sampler_ycbcr_conversion");
        let is_ycbcr_extension_supported = context.is_device_functionality_supported("VK_EXT_ycbcr_2plane_444_formats");
        let is_pvrtc_supported = context.is_device_functionality_supported("VK_IMG_format_pvrtc");
        let is_maintenance5_supported = context.is_device_functionality_supported("VK_KHR_maintenance5");
        let mut optimal_formats: Vec<vk::Format> = Vec::new();
        let mut linear_formats: Vec<vk::Format> = Vec::new();
        let mut memory_types: Vec<usize> = Vec::new();
        let mut success = true;
        let mut all_unsupported = true;

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        // Find supported image formats
        for format in all_formats() {
            if is_ycbcr_format(format) && !is_ycbcr_supported {
                continue;
            }

            if is_ycbcr_extension_format(format) && !is_ycbcr_extension_supported {
                continue;
            }

            if is_pvrtc_format(format) && !is_pvrtc_supported {
                continue;
            }

            if !is_maintenance5_supported && is_format_a8_or_a1b5g5r5(format) {
                continue;
            }

            // Check for support in linear tiling mode
            let linear = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::LINEAR,
                    vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if linear.is_ok() {
                linear_formats.push(format);
            }

            // Check for support in optimal tiling mode
            let optimal = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if optimal.is_ok() {
                optimal_formats.push(format);
            }
        }

        // Check for supported heap types
        let mem_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
        let legal_types = legal_memory_types();

        for (j, requirement) in legal_types.iter().enumerate() {
            let found = (0..mem_properties.memory_type_count as usize)
                .any(|i| requirement.matches_heap(mem_properties.memory_types[i].property_flags));
            if found {
                memory_types.push(j);
            }
        }

        // Log the used image types and heap types
        log::info!(
            "Using linear formats: {}",
            linear_formats
                .iter()
                .map(|f| f.as_raw().to_string())
                .collect::<Vec<_>>()
                .join(" ")
        );
        log::info!(
            "Using optimal formats: {}",
            optimal_formats
                .iter()
                .map(|f| f.as_raw().to_string())
                .collect::<Vec<_>>()
                .join(" ")
        );
        log::info!(
            "Using memory types: {}",
            memory_types.iter().map(|t| t.to_string()).collect::<Vec<_>>().join(" ")
        );

        if memory_types.is_empty() {
            return Err(TestError::NotSupported(
                "No legal memory type combination is available".to_string(),
            ));
        }

        let mut objs: Vec<Box<dyn ObjectAllocator<'a> + 'a>> = Vec::with_capacity(TEST_CYCLES);
        let mut ref_sizes = vec![0usize; TEST_CYCLES];
        let mut order: Vec<usize> = (0..TEST_CYCLES).collect();
        let mut supported = vec![false; TEST_CYCLES];

        for _ in 0..TEST_CYCLES {
            if self.random.get_bool() {
                objs.push(Box::new(BufferAllocator::new(
                    &mut self.random,
                    is_dedicated_allocation_supported,
                    &memory_types,
                )));
            } else {
                objs.push(Box::new(ImageAllocator::new(
                    &mut self.random,
                    is_dedicated_allocation_supported,
                    &linear_formats,
                    &optimal_formats,
                    &memory_types,
                )?));
            }
        }

        // First get reference values for the object sizes
        for i in 0..TEST_CYCLES {
            match objs[i].allocate(context) {
                Ok(()) => {
                    ref_sizes[i] = objs[i].get_size(context);
                    objs[i].deallocate();
                    supported[i] = true;
                    all_unsupported = false;
                }
                Err(TestError::NotSupported(_)) => {
                    objs[i].deallocate();
                    supported[i] = false;
                }
                Err(e) => return Err(e),
            }
        }

        if all_unsupported {
            return Err(TestError::NotSupported("All allocations unsupported".to_string()));
        }

        // Shuffle order by swapping random pairs
        for _ in 0..TEST_CYCLES {
            let a = self.random.get_uint32() as usize % TEST_CYCLES;
            let b = self.random.get_uint32() as usize % TEST_CYCLES;
            order.swap(a, b);
        }

        // Allocate objects in shuffled order
        for i in 0..TEST_CYCLES {
            if supported[order[i]] {
                objs[order[i]].allocate(context)?;
            }
        }

        // Check for size mismatches
        for i in 0..TEST_CYCLES {
            if !supported[order[i]] {
                continue;
            }

            let val = objs[order[i]].get_size(context);

            if val != ref_sizes[order[i]] {
                success = false;
                log::info!("Object {} size mismatch ({} != {})", order[i], val, ref_sizes[order[i]]);
            }
        }

        // Clean up
        for i in 0..TEST_CYCLES {
            if supported[order[i]] {
                objs[order[i]].deallocate();
            }
        }

        if success {
            return Ok(TestStatus::pass("Pass"));
        }

        Ok(TestStatus::fail("One or more allocation is not invariant"))
    }
}

fn make_image<'a>(vk: &'a Device, create_info: &vk::ImageCreateInfo) -> Result<Unique<'a, vk::Image>, TestError> {
    let image = unsafe { vk.create_image(create_info, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(vk, image))
}

fn make_buffer<'a>(vk: &'a Device, create_info: &vk::BufferCreateInfo) -> Result<Unique<'a, vk::Buffer>, TestError> {
    let buffer = unsafe { vk.create_buffer(create_info, None) }.vk_check("vkCreateBuffer")?;
    Ok(Unique::new(vk, buffer))
}

/// `vkGetDeviceBufferMemoryRequirements`, from core 1.3 or from VK_KHR_maintenance4 as the device has it.
fn get_device_buffer_memory_requirements(
    context: &Context<'_>,
    info: &vk::DeviceBufferMemoryRequirements,
    requirements: &mut vk::MemoryRequirements2,
) {
    let vk = context.get_device();
    if context.api_version() >= (1, 3, 0) {
        unsafe { vk.get_device_buffer_memory_requirements(info, requirements) };
    } else {
        unsafe { vk.get_device_buffer_memory_requirements_khr(info, requirements) };
    }
}

/// `vkGetDeviceImageMemoryRequirements`, from core 1.3 or from VK_KHR_maintenance4 as the device has it.
fn get_device_image_memory_requirements(
    context: &Context<'_>,
    info: &vk::DeviceImageMemoryRequirements,
    requirements: &mut vk::MemoryRequirements2,
) {
    let vk = context.get_device();
    if context.api_version() >= (1, 3, 0) {
        unsafe { vk.get_device_image_memory_requirements(info, requirements) };
    } else {
        unsafe { vk.get_device_image_memory_requirements_khr(info, requirements) };
    }
}

fn are_requirements_the_same(a: &vk::MemoryRequirements2, b: &vk::MemoryRequirements2) -> bool {
    a.memory_requirements.size == b.memory_requirements.size
        && a.memory_requirements.alignment == b.memory_requirements.alignment
        && a.memory_requirements.memory_type_bits == b.memory_requirements.memory_type_bits
}

/// `AlignmentMatchingInstance`
struct AlignmentMatchingInstance<'a> {
    context: &'a Context<'a>,
    test_type: TestType,
}

impl TestInstance for AlignmentMatchingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let vk = context.get_device();
        let objects_count = 5u32;
        let mut success = true;
        let base_extent = vk::Extent3D {
            width: 32,
            height: 31,
            depth: 1,
        };
        let base_size: vk::DeviceSize = 1023;

        let mut image_create_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: vk::Format::R8G8B8A8_UNORM,
            extent: base_extent,
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::TRANSFER_SRC,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };

        let mut buffer_create_info = vk::BufferCreateInfo {
            s_type: vk::StructureType::BUFFER_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::BufferCreateFlags::empty(),
            size: base_size,
            usage: vk::BufferUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
        };

        let base_image = make_image(vk, &image_create_info)?;
        let base_buffer = make_buffer(vk, &buffer_create_info)?;

        let base_image_requirements = unsafe { vk.get_image_memory_requirements(*base_image) };
        let base_buffer_requirements = unsafe { vk.get_buffer_memory_requirements(*base_buffer) };

        // Create a bunch of VkBuffer and VkImage objects with the same
        // create infos and make sure their alignments all match.
        {
            let mut images = Vec::new();
            let mut buffers = Vec::new();

            for _ in 0..objects_count {
                images.push(make_image(vk, &image_create_info)?);
                buffers.push(make_buffer(vk, &buffer_create_info)?);

                let image_requirements = unsafe { vk.get_image_memory_requirements(**images.last().unwrap()) };
                let buffers_requirements = unsafe { vk.get_buffer_memory_requirements(**buffers.last().unwrap()) };

                if base_image_requirements.alignment != image_requirements.alignment {
                    success = false;
                    log::info!("Alignments for all VkImage objects created with the same create infos should match");
                }
                if base_buffer_requirements.alignment != buffers_requirements.alignment {
                    success = false;
                    log::info!("Alignments for all VkBuffer objects created with the same create infos should match");
                }
            }
        }

        let get_memory_requirements2_supported = context.api_version() >= (1, 1, 0)
            || context.is_device_functionality_supported("VK_KHR_get_memory_requirements2");
        if get_memory_requirements2_supported {
            let buffer_memory_requirements_info = vk::BufferMemoryRequirementsInfo2 {
                s_type: vk::StructureType::BUFFER_MEMORY_REQUIREMENTS_INFO_2,
                next: std::ptr::null(),
                buffer: *base_buffer,
            };
            let image_memory_requirements_info = vk::ImageMemoryRequirementsInfo2 {
                s_type: vk::StructureType::IMAGE_MEMORY_REQUIREMENTS_INFO_2,
                next: std::ptr::null(),
                image: *base_image,
            };
            let count = if self.test_type == TestType::DedicatedRequirements {
                4
            } else {
                2
            };
            let mut requirements2: Vec<vk::MemoryRequirements2> =
                (0..count).map(|_| vk::MemoryRequirements2::default()).collect();

            // The memory requirements returned by vkGetBufferCreateInfoMemoryRequirementsKHR are identical to those that
            // would be returned by vkGetBufferMemoryRequirements2 if it were called with a VkBuffer created with the same
            // VkBufferCreateInfo values.
            unsafe { vk.get_buffer_memory_requirements2(&buffer_memory_requirements_info, &mut requirements2[0]) };
            let buffer_mem_info = vk::DeviceBufferMemoryRequirements {
                s_type: vk::StructureType::DEVICE_BUFFER_MEMORY_REQUIREMENTS,
                next: std::ptr::null(),
                create_info: &buffer_create_info,
            };
            get_device_buffer_memory_requirements(context, &buffer_mem_info, &mut requirements2[1]);

            if !are_requirements_the_same(&requirements2[0], &requirements2[1]) {
                success = false;
                log::info!(
                    "vkGetDeviceBufferMemoryRequirements and vkGetBufferMemoryRequirements2\nreport diferent memory requirements"
                );
            }

            let mut dedicated_requirements1 = vk::MemoryDedicatedRequirements::default();
            let mut dedicated_requirements2 = vk::MemoryDedicatedRequirements::default();
            if self.test_type == TestType::DedicatedRequirements {
                requirements2[2].next = (&raw mut dedicated_requirements1).cast();
                dedicated_requirements1.prefers_dedicated_allocation = 2;
                dedicated_requirements1.requires_dedicated_allocation = 2;
                unsafe { vk.get_buffer_memory_requirements2(&buffer_memory_requirements_info, &mut requirements2[2]) };

                if !are_requirements_the_same(&requirements2[0], &requirements2[2]) {
                    success = false;
                    log::info!(
                        "vkGetBufferMemoryRequirements2 and vkGetBufferMemoryRequirements2 with\nVkMemoryDedicatedRequirements report diferent memory requirements"
                    );
                }

                requirements2[3].next = (&raw mut dedicated_requirements2).cast();
                dedicated_requirements2.prefers_dedicated_allocation = 3;
                dedicated_requirements2.requires_dedicated_allocation = 3;
                get_device_buffer_memory_requirements(context, &buffer_mem_info, &mut requirements2[3]);

                if !are_requirements_the_same(&requirements2[0], &requirements2[3]) {
                    success = false;
                    log::info!(
                        "vkGetBufferMemoryRequirements2 with VkMemoryDedicatedRequirements\nand vkGetDeviceBufferMemoryRequirements with VkMemoryDedicatedRequirements\nreport diferent memory requirements"
                    );
                }
                if dedicated_requirements1.prefers_dedicated_allocation
                    != dedicated_requirements2.prefers_dedicated_allocation
                    || dedicated_requirements1.requires_dedicated_allocation
                        != dedicated_requirements2.requires_dedicated_allocation
                {
                    success = false;
                    log::info!(
                        "VkMemoryDedicatedRequirements with vkGetBufferMemoryRequirements2\n doesn't match VkMemoryDedicatedRequirements with vkGetDeviceBufferMemoryRequirements"
                    );
                }
            }

            // Similarly, vkGetImageCreateInfoMemoryRequirementsKHR will report the same memory requirements as
            // vkGetImageMemoryRequirements2 would if called with a VkImage created with the supplied VkImageCreateInfo
            unsafe { vk.get_image_memory_requirements2(&image_memory_requirements_info, &mut requirements2[0]) };
            let image_mem_info = vk::DeviceImageMemoryRequirements {
                s_type: vk::StructureType::DEVICE_IMAGE_MEMORY_REQUIREMENTS,
                next: std::ptr::null(),
                create_info: &image_create_info,
                plane_aspect: vk::ImageAspectFlags::empty(),
            };
            get_device_image_memory_requirements(context, &image_mem_info, &mut requirements2[1]);

            if !are_requirements_the_same(&requirements2[0], &requirements2[1]) {
                success = false;
                log::info!(
                    "vkGetDeviceImageMemoryRequirements and vkGetImageMemoryRequirements2\nreport diferent memory requirements"
                );
            }

            if self.test_type == TestType::DedicatedRequirements {
                dedicated_requirements1.prefers_dedicated_allocation = 2;
                dedicated_requirements1.requires_dedicated_allocation = 2;
                unsafe { vk.get_image_memory_requirements2(&image_memory_requirements_info, &mut requirements2[2]) };

                if !are_requirements_the_same(&requirements2[0], &requirements2[2]) {
                    success = false;
                    log::info!(
                        "vkGetImageMemoryRequirements2 and vkGetImageMemoryRequirements2 with\nVkMemoryDedicatedRequirements report diferent memory requirements"
                    );
                }

                dedicated_requirements2.prefers_dedicated_allocation = 3;
                dedicated_requirements2.requires_dedicated_allocation = 3;
                get_device_image_memory_requirements(context, &image_mem_info, &mut requirements2[3]);

                if !are_requirements_the_same(&requirements2[0], &requirements2[3]) {
                    success = false;
                    log::info!(
                        "vkGetImageMemoryRequirements2 with VkMemoryDedicatedRequirements\nand vkGetDeviceImageMemoryRequirements with VkMemoryDedicatedRequirements\nreport diferent memory requirements"
                    );
                }
                if dedicated_requirements1.prefers_dedicated_allocation
                    != dedicated_requirements2.prefers_dedicated_allocation
                    || dedicated_requirements1.requires_dedicated_allocation
                        != dedicated_requirements2.requires_dedicated_allocation
                {
                    success = false;
                    log::info!(
                        "VkMemoryDedicatedRequirements with vkGetImageMemoryRequirements2\n doesn't match VkMemoryDedicatedRequirements with vkGetDeviceImageMemoryRequirements"
                    );
                }
            }
        }

        // For a VkImage, the size memory requirement is never greater than that of another VkImage created with
        // a greater or equal extent dimension specified in VkImageCreateInfo, all other creation parameters being identical.
        // For a VkBuffer, the size memory requirement is never greater than that of another VkBuffer created with
        // a greater or equal size specified in VkBufferCreateInfo, all other creation parameters being identical.
        {
            let mut images = Vec::new();
            let mut buffers = Vec::new();

            for idx in 0..objects_count {
                image_create_info.extent = vk::Extent3D {
                    width: base_extent.width + (idx % 2) * idx,
                    height: base_extent.height + idx,
                    depth: 1,
                };
                buffer_create_info.size = base_size + vk::DeviceSize::from(idx);

                images.push(make_image(vk, &image_create_info)?);
                buffers.push(make_buffer(vk, &buffer_create_info)?);

                let image_requirements = unsafe { vk.get_image_memory_requirements(**images.last().unwrap()) };
                let buffers_requirements = unsafe { vk.get_buffer_memory_requirements(**buffers.last().unwrap()) };

                if base_image_requirements.size > image_requirements.size {
                    success = false;
                    log::info!(
                        "Size memory requiremen for VkImage should never be greater than that of another VkImage\ncreated with a greater or equal extent dimension specified in VkImageCreateInfo when all\nother creation parameters are identical"
                    );
                }
                if base_buffer_requirements.size > buffers_requirements.size {
                    success = false;
                    log::info!(
                        "Size memory requiremen for VkBuffer should never be greater than that of another VkBuffer\ncreated with a greater or size specified in VkImageCreateInfo when all\nother creation parameters are identical"
                    );
                }
            }
        }

        if success {
            return Ok(TestStatus::pass("Pass"));
        }

        Ok(TestStatus::fail("Fail"))
    }
}

/// `InvarianceCase`
struct InvarianceCase {
    name: &'static str,
    test_type: TestType,
}

impl TestCase for InvarianceCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.test_type == TestType::RequirementsMatching || self.test_type == TestType::DedicatedRequirements {
            context.require_device_functionality("VK_KHR_maintenance4")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        if self.test_type == TestType::RequirementsMatching || self.test_type == TestType::DedicatedRequirements {
            return Box::new(AlignmentMatchingInstance {
                context,
                test_type: self.test_type,
            });
        }

        Box::new(InvarianceInstance {
            context,
            random: Random::new(0x600613),
        })
    }
}

/// `createMemoryRequirementInvarianceTests`
pub fn create_memory_requirement_invariance_tests() -> TestCaseGroup {
    let mut invariance_tests = TestCaseGroup::new("invariance");

    for (name, test_type) in [
        ("random", TestType::BasicInvariance),
        ("memory_requirements_matching", TestType::RequirementsMatching),
        (
            "memory_dedicated_requirements_matching",
            TestType::DedicatedRequirements,
        ),
    ] {
        invariance_tests.add_child(Box::new(InvarianceCase { name, test_type }) as Box<dyn TestCase>);
    }

    invariance_tests
}
