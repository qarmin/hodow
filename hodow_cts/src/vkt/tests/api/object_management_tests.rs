// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiObjectManagementTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream expresses each object kind as a struct with `Parameters`, `Resources` and a
// static `create`, and each test variant as a template over that struct. Rust has no
// equivalent of a template parameterised by a type with those three members, so the
// same three things become an enum of parameters, one `Resources::new` and one
// `create_object`, both dispatching on it. The per-object bodies are otherwise a
// line-by-line transcription and stay in upstream's order.
//
// Not ported here: the `private_data` and `alloc_callback_fail*` variants. The former
// needs a device built with a chosen private-data slot count, the latter an allocator
// that fails the Nth call and a `create` that reports VK_ERROR_OUT_OF_HOST_MEMORY as
// something other than a test failure.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{Handle as VkHandle, InstanceV1_1};

use crate::tcu::{self, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::alloc_callback_util::AllocationCallbackRecorder;
use crate::vk::programs::{BinaryCollection, create_shader_module};
// Re-exported so the generated shader module, which imports this one wholesale, can
// name the type its manifest entries are declared with.
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};
use crate::vkt::{Context, TestCase, TestInstance};

/// `Environment`
struct Environment<'a> {
    /// `Environment::vkp` - needed only by the object kinds that build their own
    /// instance.
    entry: &'a vulkanalia::Entry,
    /// `Environment::apiVersion`
    api_version: u32,
    device: &'a Device,
    queue_family_index: u32,
    programs: BinaryCollection,
    /// `Environment::allocationCallbacks` - only the memory-usage measurement behind
    /// `getMaxConcurrent` supplies one; everything else creates with the default.
    allocation_callbacks: Option<&'a vk::AllocationCallbacks>,
    /// Maximum number of objects using the same `Resources` concurrently. Only the
    /// descriptor-set pool sizing reads it.
    max_resource_consumers: u32,
}

impl<'a> Environment<'a> {
    fn new(context: &'a Context<'a>, max_resource_consumers: u32) -> Self {
        Self {
            entry: &context.get_platform().entry,
            api_version: context.get_platform().api_version,
            device: context.get_device(),
            queue_family_index: context.get_universal_queue_family_index(),
            programs: crate::generated::shaders::api_object_management::OBJECT_MANAGEMENT.programs,
            allocation_callbacks: None,
            max_resource_consumers,
        }
    }

    fn with_callbacks(context: &'a Context<'a>, max_resource_consumers: u32, allocation_callbacks: &'a vk::AllocationCallbacks) -> Self {
        Self {
            allocation_callbacks: Some(allocation_callbacks),
            ..Self::new(context, max_resource_consumers)
        }
    }
}

// SAFETY: both are built before the worker threads start, read only while they run and
// dropped after they join. The Vulkan handles they carry may be used from several
// threads at once - creating objects on one device concurrently is what the
// `multithreaded_*` cases are for - and the only member that is not `Sync` by
// derivation is the allocation-callbacks pointer, which those cases never set.
unsafe impl Sync for Environment<'_> {}
unsafe impl Sync for Resources<'_> {}

// ---------------------------------------------------------------------------------
// Parameters
// ---------------------------------------------------------------------------------

/// `DeviceMemory::Parameters`
#[derive(Clone, Copy)]
struct DeviceMemoryParams {
    size: vk::DeviceSize,
    memory_type_index: u32,
}

/// `Buffer::Parameters`
#[derive(Clone, Copy)]
struct BufferParams {
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
}

/// `BufferView::Parameters`
#[derive(Clone, Copy)]
struct BufferViewParams {
    buffer: BufferParams,
    format: vk::Format,
    offset: vk::DeviceSize,
    range: vk::DeviceSize,
}

/// `Image::Parameters`
#[derive(Clone, Copy)]
struct ImageParams {
    flags: vk::ImageCreateFlags,
    image_type: vk::ImageType,
    format: vk::Format,
    extent: vk::Extent3D,
    mip_levels: u32,
    array_size: u32,
    samples: vk::SampleCountFlags,
    tiling: vk::ImageTiling,
    usage: vk::ImageUsageFlags,
    initial_layout: vk::ImageLayout,
}

/// `ImageView::Parameters`
#[derive(Clone, Copy)]
struct ImageViewParams {
    image: ImageParams,
    view_type: vk::ImageViewType,
    format: vk::Format,
    subresource_range: vk::ImageSubresourceRange,
}

/// `DescriptorSetLayout::Parameters::Binding`
#[derive(Clone, Copy)]
struct Binding {
    binding: u32,
    descriptor_type: vk::DescriptorType,
    descriptor_count: u32,
    stage_flags: vk::ShaderStageFlags,
    use_immutable_sampler: bool,
}

impl Binding {
    fn new(binding: u32, descriptor_type: vk::DescriptorType, descriptor_count: u32, stage_flags: vk::ShaderStageFlags, use_immutable_sampler: bool) -> Self {
        Self {
            binding,
            descriptor_type,
            descriptor_count,
            stage_flags,
            use_immutable_sampler,
        }
    }
}

/// `DescriptorSetLayout::Parameters`
#[derive(Clone)]
struct DescriptorSetLayoutParams {
    bindings: Vec<Binding>,
}

impl DescriptorSetLayoutParams {
    fn empty() -> Self {
        Self { bindings: Vec::new() }
    }

    fn single(binding: u32, descriptor_type: vk::DescriptorType, descriptor_count: u32, stage_flags: vk::ShaderStageFlags, use_immutable_sampler: bool) -> Self {
        Self {
            bindings: vec![Binding::new(binding, descriptor_type, descriptor_count, stage_flags, use_immutable_sampler)],
        }
    }
}

/// `PipelineLayout::Parameters`
#[derive(Clone)]
struct PipelineLayoutParams {
    descriptor_set_layouts: Vec<DescriptorSetLayoutParams>,
}

/// `DescriptorPool::Parameters`
#[derive(Clone)]
struct DescriptorPoolParams {
    flags: vk::DescriptorPoolCreateFlags,
    max_sets: u32,
    pool_sizes: Vec<vk::DescriptorPoolSize>,
}

/// `QueryPool::Parameters`
#[derive(Clone, Copy)]
struct QueryPoolParams {
    query_type: vk::QueryType,
    entry_count: u32,
    pipeline_statistics: vk::QueryPipelineStatisticFlags,
}

/// `CommandBuffer::Parameters`
#[derive(Clone, Copy)]
struct CommandBufferParams {
    command_pool_flags: vk::CommandPoolCreateFlags,
    level: vk::CommandBufferLevel,
}

/// `Device::Parameters` / `DeviceGroup::Parameters`
#[derive(Clone, Copy)]
struct DeviceParams {
    /// `deviceGroupIndex`, only read by the device-group case.
    device_group_index: usize,
    device_index: usize,
    queue_flags: vk::QueueFlags,
}

/// The object kinds this file creates, each carrying its upstream `Parameters`.
#[derive(Clone)]
enum ObjectParams {
    Instance,
    Device(DeviceParams),
    DeviceGroup(DeviceParams),
    DeviceMemory(DeviceMemoryParams),
    Buffer(BufferParams),
    BufferView(BufferViewParams),
    Image(ImageParams),
    ImageView(ImageViewParams),
    Semaphore,
    Fence(vk::FenceCreateFlags),
    Event,
    QueryPool(QueryPoolParams),
    ShaderModule { binary_name: &'static str },
    PipelineCache { extern_sync: bool },
    MergedPipelineCache { src_extern_sync: bool, dst_extern_sync: bool },
    Sampler,
    DescriptorSetLayout(DescriptorSetLayoutParams),
    PipelineLayout(PipelineLayoutParams),
    RenderPass,
    GraphicsPipeline,
    ComputePipeline,
    DescriptorPool(DescriptorPoolParams),
    DescriptorSet(DescriptorSetLayoutParams),
    Framebuffer,
    CommandPool(vk::CommandPoolCreateFlags),
    CommandBuffer(CommandBufferParams),
}

// ---------------------------------------------------------------------------------
// Object handles
// ---------------------------------------------------------------------------------

/// `InstanceWrapper` - vulkanalia's instance is a value with its own dispatch table,
/// so the RAII wrapper owns the value rather than a bare handle.
struct UniqueInstance<'a> {
    instance: vulkanalia::Instance,
    allocator: Option<&'a vk::AllocationCallbacks>,
}

impl Drop for UniqueInstance<'_> {
    fn drop(&mut self) {
        unsafe { self.instance.destroy_instance(self.allocator) };
    }
}

/// `DeviceWrapper`
struct UniqueDevice<'a> {
    device: vulkanalia::Device,
    allocator: Option<&'a vk::AllocationCallbacks>,
}

impl Drop for UniqueDevice<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_device(self.allocator) };
    }
}

/// A created object, owning its handle. Upstream's `Dependency<Case>` holds one of
/// these per dependency and destroys them in reverse declaration order.
///
/// Several arms are only ever the object under test, never a dependency, so their
/// handle is never read back out - the value is here to be dropped.
#[expect(dead_code, reason = "the wrapped handle is the RAII guard, not a value to read")]
enum Owned<'a> {
    // Boxed: vulkanalia's instance and device carry their whole dispatch table, so
    // an unboxed arm would make every `Owned` kilobytes wide, and `max_concurrent`
    // holds thousands of them.
    Instance(Box<UniqueInstance<'a>>),
    Device(Box<UniqueDevice<'a>>),
    Buffer(Unique<'a, vk::Buffer>),
    BufferView(Unique<'a, vk::BufferView>),
    CommandBuffer(UniqueCommandBuffer<'a>),
    CommandPool(Unique<'a, vk::CommandPool>),
    DescriptorPool(Unique<'a, vk::DescriptorPool>),
    DescriptorSet(UniqueDescriptorSet<'a>),
    DescriptorSetLayout(Unique<'a, vk::DescriptorSetLayout>),
    DeviceMemory(Unique<'a, vk::DeviceMemory>),
    Event(Unique<'a, vk::Event>),
    Fence(Unique<'a, vk::Fence>),
    Framebuffer(Unique<'a, vk::Framebuffer>),
    Image(Unique<'a, vk::Image>),
    ImageView(Unique<'a, vk::ImageView>),
    Pipeline(Unique<'a, vk::Pipeline>),
    PipelineCache(Unique<'a, vk::PipelineCache>),
    PipelineLayout(Unique<'a, vk::PipelineLayout>),
    QueryPool(Unique<'a, vk::QueryPool>),
    RenderPass(Unique<'a, vk::RenderPass>),
    Sampler(Unique<'a, vk::Sampler>),
    Semaphore(Unique<'a, vk::Semaphore>),
    ShaderModule(Unique<'a, vk::ShaderModule>),
}

/// The bare handle of an `Owned`, for the dependency that needs to name it.
///
/// Vulkan's instance and device are value types in vulkanalia - a handle plus its own
/// dispatch table - so what travels here is a clone of that value, not a raw handle.
/// Cloning does not duplicate the Vulkan object; the `Owned` still destroys it once.
#[derive(Clone)]
enum Handle {
    Instance(Box<vulkanalia::Instance>),
    Buffer(vk::Buffer),
    CommandPool(vk::CommandPool),
    DescriptorPool(vk::DescriptorPool),
    DescriptorSetLayout(vk::DescriptorSetLayout),
    DeviceMemory(vk::DeviceMemory),
    Image(vk::Image),
    ImageView(vk::ImageView),
    PipelineCache(vk::PipelineCache),
    PipelineLayout(vk::PipelineLayout),
    RenderPass(vk::RenderPass),
    Sampler(vk::Sampler),
    ShaderModule(vk::ShaderModule),
    /// Every other kind - nothing in this file depends on one.
    Other,
}

impl Owned<'_> {
    fn handle(&self) -> Handle {
        match self {
            Owned::Instance(h) => Handle::Instance(Box::new(h.instance.clone())),
            Owned::Buffer(h) => Handle::Buffer(h.get()),
            Owned::CommandPool(h) => Handle::CommandPool(h.get()),
            Owned::DescriptorPool(h) => Handle::DescriptorPool(h.get()),
            Owned::DescriptorSetLayout(h) => Handle::DescriptorSetLayout(h.get()),
            Owned::DeviceMemory(h) => Handle::DeviceMemory(h.get()),
            Owned::Image(h) => Handle::Image(h.get()),
            Owned::ImageView(h) => Handle::ImageView(h.get()),
            Owned::PipelineCache(h) => Handle::PipelineCache(h.get()),
            Owned::PipelineLayout(h) => Handle::PipelineLayout(h.get()),
            Owned::RenderPass(h) => Handle::RenderPass(h.get()),
            Owned::Sampler(h) => Handle::Sampler(h.get()),
            Owned::ShaderModule(h) => Handle::ShaderModule(h.get()),
            _ => Handle::Other,
        }
    }
}

macro_rules! expect_handle {
    ($expr:expr, $variant:ident) => {
        match $expr {
            Handle::$variant(handle) => handle,
            _ => unreachable!("dependency returned the wrong handle kind"),
        }
    };
}

// ---------------------------------------------------------------------------------
// Resources
// ---------------------------------------------------------------------------------

/// `Object::Resources` - everything an object needs created before it.
///
/// One struct for all object kinds, because Rust cannot dispatch on an associated
/// type the way the C++ template does. `owned` is drained from the back, which
/// destroys in reverse creation order - the same order the C++ member destructors
/// give, and the only one that is always legal.
struct Resources<'a> {
    owned: Vec<Owned<'a>>,
    buffer: vk::Buffer,
    image: vk::Image,
    /// Framebuffer's colour and depth/stencil views, in that order.
    image_views: Vec<vk::ImageView>,
    /// GraphicsPipeline's vertex and fragment modules, or ComputePipeline's one.
    shader_modules: Vec<vk::ShaderModule>,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    pipeline_cache: vk::PipelineCache,
    /// `MergedPipelineCache::Resources::srcPipelineCaches`
    src_pipeline_cache: vk::PipelineCache,
    descriptor_pool: vk::DescriptorPool,
    descriptor_set_layout: vk::DescriptorSetLayout,
    set_layouts: Vec<vk::DescriptorSetLayout>,
    command_pool: vk::CommandPool,
    /// Lives here so the bindings built in `create_object` can point at it.
    immutable_samplers: Vec<vk::Sampler>,
    bindings: Vec<Binding>,
    /// The SPIR-V a shader module is built from, as `ShaderModule::Resources::binary`.
    binary: &'static [u32],
    /// `Device::Resources::instance` - a clone of the instance the device is made on.
    instance: Option<vulkanalia::Instance>,
    /// `DeviceGroup::Resources::physicalDevices`; the plain device case keeps the one
    /// it picked here too.
    physical_devices: Vec<vk::PhysicalDevice>,
    /// `Device::Resources::queueFamilyIndex`
    device_queue_family_index: u32,
}

impl Drop for Resources<'_> {
    fn drop(&mut self) {
        while self.owned.pop().is_some() {}
    }
}

impl<'a> Resources<'a> {
    fn empty() -> Self {
        Self {
            owned: Vec::new(),
            buffer: vk::Buffer::null(),
            image: vk::Image::null(),
            image_views: Vec::new(),
            shader_modules: Vec::new(),
            pipeline_layout: vk::PipelineLayout::null(),
            render_pass: vk::RenderPass::null(),
            pipeline_cache: vk::PipelineCache::null(),
            src_pipeline_cache: vk::PipelineCache::null(),
            descriptor_pool: vk::DescriptorPool::null(),
            descriptor_set_layout: vk::DescriptorSetLayout::null(),
            set_layouts: Vec::new(),
            command_pool: vk::CommandPool::null(),
            immutable_samplers: Vec::new(),
            bindings: Vec::new(),
            binary: &[],
            instance: None,
            physical_devices: Vec::new(),
            device_queue_family_index: u32::MAX,
        }
    }

    fn take_owned(&mut self) -> Vec<Owned<'a>> {
        std::mem::take(&mut self.owned)
    }

    /// `Dependency<Case>` - creates the dependency's own resources, then the object,
    /// and keeps both alive for as long as this `Resources` lives.
    fn add(&mut self, env: &Environment<'a>, params: &ObjectParams) -> Result<Handle, TestError> {
        let mut sub = Resources::new(env, params)?;
        let object = create_object(env, &sub, params)?;
        let handle = object.handle();
        self.owned.extend(sub.take_owned());
        self.owned.push(object);
        Ok(handle)
    }

    /// `getDeviceMemoryParameters` - the whole requirement, in the lowest memory type
    /// the requirements allow.
    fn memory_params(requirements: vk::MemoryRequirements) -> DeviceMemoryParams {
        DeviceMemoryParams {
            size: requirements.size,
            memory_type_index: requirements.memory_type_bits.trailing_zeros(),
        }
    }

    /// `Object::Resources::Resources`
    fn new(env: &Environment<'a>, params: &ObjectParams) -> Result<Self, TestError> {
        let device = env.device;
        let mut res = Resources::empty();

        match params {
            // `Device::Resources` - a private instance, then the physical device and
            // a queue family that has every requested capability.
            ObjectParams::Device(p) => {
                let Handle::Instance(instance) = res.add(env, &ObjectParams::Instance)? else {
                    unreachable!("instance dependency")
                };
                let physical_devices = unsafe { instance.enumerate_physical_devices() }.vk_check("vkEnumeratePhysicalDevices")?;
                if physical_devices.len() <= p.device_index {
                    return Err(TestError::NotSupported("Device not found".to_string()));
                }
                res.physical_devices = vec![physical_devices[p.device_index]];
                res.device_queue_family_index = find_queue_family(&instance, res.physical_devices[0], p.queue_flags)?;
                res.instance = Some(*instance);
            }
            ObjectParams::DeviceGroup(p) => {
                let Handle::Instance(instance) = res.add(env, &ObjectParams::Instance)? else {
                    unreachable!("instance dependency")
                };
                let groups = unsafe { instance.enumerate_physical_device_groups() }.vk_check("vkEnumeratePhysicalDeviceGroups")?;
                if groups.len() <= p.device_group_index {
                    return Err(TestError::NotSupported("Device Group not found".to_string()));
                }
                let group = groups[p.device_group_index];
                res.physical_devices = group.physical_devices[..group.physical_device_count as usize].to_vec();
                if res.physical_devices.len() <= p.device_index {
                    return Err(TestError::NotSupported("Device not found".to_string()));
                }
                res.device_queue_family_index = find_queue_family(&instance, res.physical_devices[p.device_index], p.queue_flags)?;
                res.instance = Some(*instance);
            }
            ObjectParams::BufferView(p) => {
                res.buffer = expect_handle!(res.add(env, &ObjectParams::Buffer(p.buffer))?, Buffer);
                let memory_params = Self::memory_params(unsafe { device.get_buffer_memory_requirements(res.buffer) });
                let memory = expect_handle!(res.add(env, &ObjectParams::DeviceMemory(memory_params))?, DeviceMemory);
                unsafe { device.bind_buffer_memory(res.buffer, memory, 0) }.vk_check("vkBindBufferMemory")?;
            }
            ObjectParams::ImageView(p) => {
                res.image = expect_handle!(res.add(env, &ObjectParams::Image(p.image))?, Image);
                let memory_params = Self::memory_params(unsafe { device.get_image_memory_requirements(res.image) });
                let memory = expect_handle!(res.add(env, &ObjectParams::DeviceMemory(memory_params))?, DeviceMemory);
                unsafe { device.bind_image_memory(res.image, memory, 0) }.vk_check("vkBindImageMemory")?;
            }
            ObjectParams::ShaderModule { binary_name } => {
                res.binary = env.programs.get(binary_name)?.spirv;
            }
            ObjectParams::MergedPipelineCache { src_extern_sync, .. } => {
                res.src_pipeline_cache = expect_handle!(res.add(env, &ObjectParams::PipelineCache { extern_sync: *src_extern_sync })?, PipelineCache);
            }
            ObjectParams::DescriptorSetLayout(p) => {
                // One immutable sampler, shared by every binding that asks for one.
                if let Some(first) = p.bindings.iter().find(|b| b.use_immutable_sampler) {
                    let sampler = expect_handle!(res.add(env, &ObjectParams::Sampler)?, Sampler);
                    res.immutable_samplers = vec![sampler; first.descriptor_count as usize];
                }
                res.bindings = p.bindings.clone();
            }
            ObjectParams::PipelineLayout(p) => {
                for layout_params in &p.descriptor_set_layouts {
                    let layout = expect_handle!(res.add(env, &ObjectParams::DescriptorSetLayout(layout_params.clone()))?, DescriptorSetLayout);
                    res.set_layouts.push(layout);
                }
            }
            ObjectParams::GraphicsPipeline => {
                for name in ["vert", "frag"] {
                    let module = expect_handle!(res.add(env, &ObjectParams::ShaderModule { binary_name: name })?, ShaderModule);
                    res.shader_modules.push(module);
                }
                res.pipeline_layout = expect_handle!(
                    res.add(
                        env,
                        &ObjectParams::PipelineLayout(PipelineLayoutParams {
                            descriptor_set_layouts: vec![DescriptorSetLayoutParams::single(
                                0,
                                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                                1,
                                vk::ShaderStageFlags::FRAGMENT,
                                true
                            )],
                        }),
                    )?,
                    PipelineLayout
                );
                res.render_pass = expect_handle!(res.add(env, &ObjectParams::RenderPass)?, RenderPass);
                res.pipeline_cache = expect_handle!(res.add(env, &ObjectParams::PipelineCache { extern_sync: false })?, PipelineCache);
            }
            ObjectParams::ComputePipeline => {
                let module = expect_handle!(res.add(env, &ObjectParams::ShaderModule { binary_name: "comp" })?, ShaderModule);
                res.shader_modules.push(module);
                res.pipeline_layout = expect_handle!(
                    res.add(
                        env,
                        &ObjectParams::PipelineLayout(PipelineLayoutParams {
                            descriptor_set_layouts: vec![compute_descriptor_set_layout()],
                        }),
                    )?,
                    PipelineLayout
                );
                res.pipeline_cache = expect_handle!(res.add(env, &ObjectParams::PipelineCache { extern_sync: false })?, PipelineCache);
            }
            ObjectParams::DescriptorSet(layout_params) => {
                res.descriptor_pool = expect_handle!(
                    res.add(
                        env,
                        &ObjectParams::DescriptorPool(DescriptorPoolParams {
                            flags: vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                            max_sets: env.max_resource_consumers,
                            pool_sizes: compute_pool_sizes(layout_params, env.max_resource_consumers),
                        }),
                    )?,
                    DescriptorPool
                );
                res.descriptor_set_layout = expect_handle!(res.add(env, &ObjectParams::DescriptorSetLayout(layout_params.clone()))?, DescriptorSetLayout);
            }
            ObjectParams::Framebuffer => {
                for (format, usage, aspect) in [
                    (vk::Format::R8G8B8A8_UNORM, vk::ImageUsageFlags::COLOR_ATTACHMENT, vk::ImageAspectFlags::COLOR),
                    (vk::Format::D16_UNORM, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT, vk::ImageAspectFlags::DEPTH),
                ] {
                    let image = ImageParams {
                        flags: vk::ImageCreateFlags::empty(),
                        image_type: vk::ImageType::_2D,
                        format,
                        extent: make_extent_3d(256, 256, 1),
                        mip_levels: 1,
                        array_size: 1,
                        samples: vk::SampleCountFlags::_1,
                        tiling: vk::ImageTiling::OPTIMAL,
                        usage,
                        initial_layout: vk::ImageLayout::UNDEFINED,
                    };
                    let view = expect_handle!(
                        res.add(
                            env,
                            &ObjectParams::ImageView(ImageViewParams {
                                image,
                                view_type: vk::ImageViewType::_2D,
                                format,
                                subresource_range: make_subresource_range(aspect, 0, 1, 0, 1),
                            }),
                        )?,
                        ImageView
                    );
                    res.image_views.push(view);
                }
                res.render_pass = expect_handle!(res.add(env, &ObjectParams::RenderPass)?, RenderPass);
            }
            ObjectParams::CommandBuffer(p) => {
                res.command_pool = expect_handle!(res.add(env, &ObjectParams::CommandPool(p.command_pool_flags))?, CommandPool);
            }
            _ => {}
        }
        Ok(res)
    }
}

/// `ComputePipeline::Resources::getDescriptorSetLayout`
fn compute_descriptor_set_layout() -> DescriptorSetLayoutParams {
    DescriptorSetLayoutParams {
        bindings: vec![
            Binding::new(0, vk::DescriptorType::STORAGE_BUFFER, 1, vk::ShaderStageFlags::COMPUTE, false),
            Binding::new(1, vk::DescriptorType::STORAGE_BUFFER, 1, vk::ShaderStageFlags::COMPUTE, false),
        ],
    }
}

/// `DescriptorSet::Resources::computePoolSizes`
fn compute_pool_sizes(layout: &DescriptorSetLayoutParams, max_sets: u32) -> Vec<vk::DescriptorPoolSize> {
    let mut sizes: Vec<vk::DescriptorPoolSize> = Vec::new();
    for binding in &layout.bindings {
        let count = binding.descriptor_count * max_sets;
        match sizes.iter_mut().find(|s| s.type_ == binding.descriptor_type) {
            Some(existing) => existing.descriptor_count += count,
            None => sizes.push(vk::DescriptorPoolSize {
                type_: binding.descriptor_type,
                descriptor_count: count,
            }),
        }
    }
    sizes
}

fn make_extent_3d(width: u32, height: u32, depth: u32) -> vk::Extent3D {
    vk::Extent3D { width, height, depth }
}

fn make_subresource_range(aspect_mask: vk::ImageAspectFlags, base_mip_level: u32, level_count: u32, base_array_layer: u32, layer_count: u32) -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask,
        base_mip_level,
        level_count,
        base_array_layer,
        layer_count,
    }
}

/// `makeComponentMappingRGBA`
const COMPONENT_MAPPING_RGBA: vk::ComponentMapping = vk::ComponentMapping {
    r: vk::ComponentSwizzle::R,
    g: vk::ComponentSwizzle::G,
    b: vk::ComponentSwizzle::B,
    a: vk::ComponentSwizzle::A,
};

// ---------------------------------------------------------------------------------
// create
// ---------------------------------------------------------------------------------

/// `Object::create`
fn create_object<'a>(env: &Environment<'a>, res: &Resources<'a>, params: &ObjectParams) -> Result<Owned<'a>, TestError> {
    let device = env.device;
    let allocator = env.allocation_callbacks;
    let queue_families = [env.queue_family_index];

    Ok(match params {
        ObjectParams::Instance => {
            // Both extension names upstream ever asks for here - device-group creation
            // and physical-device-properties2 - are core from 1.1, and the instance is
            // never older than that, so `isCoreInstanceExtension` drops both and the
            // list is always empty.
            let app_info = vk::ApplicationInfo::builder().api_version(env.api_version);
            let info = vk::InstanceCreateInfo::builder().application_info(&app_info);
            let instance = unsafe { env.entry.create_instance(&info, allocator) }.vk_check("vkCreateInstance")?;
            Owned::Instance(Box::new(UniqueInstance { instance, allocator }))
        }
        ObjectParams::Device(_) => {
            let instance = res.instance.as_ref().expect("device resources create an instance");
            let physical_device = res.physical_devices[0];
            Owned::Device(Box::new(create_test_device(
                env,
                instance,
                physical_device,
                res.device_queue_family_index,
                None,
                allocator,
            )?))
        }
        ObjectParams::DeviceGroup(p) => {
            let instance = res.instance.as_ref().expect("device-group resources create an instance");
            let physical_device = res.physical_devices[p.device_index];
            Owned::Device(Box::new(create_test_device(
                env,
                instance,
                physical_device,
                res.device_queue_family_index,
                Some(&res.physical_devices),
                allocator,
            )?))
        }
        ObjectParams::DeviceMemory(p) => {
            let info = vk::MemoryAllocateInfo::builder().allocation_size(p.size).memory_type_index(p.memory_type_index);
            Owned::DeviceMemory(Unique::with_allocator(
                device,
                unsafe { device.allocate_memory(&info, allocator) }.vk_check("vkAllocateMemory")?,
                allocator,
            ))
        }
        ObjectParams::Buffer(p) => {
            let info = vk::BufferCreateInfo::builder()
                .size(p.size)
                .usage(p.usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .queue_family_indices(&queue_families);
            Owned::Buffer(Unique::with_allocator(
                device,
                unsafe { device.create_buffer(&info, allocator) }.vk_check("vkCreateBuffer")?,
                allocator,
            ))
        }
        ObjectParams::BufferView(p) => {
            let info = vk::BufferViewCreateInfo::builder().buffer(res.buffer).format(p.format).offset(p.offset).range(p.range);
            Owned::BufferView(Unique::with_allocator(
                device,
                unsafe { device.create_buffer_view(&info, allocator) }.vk_check("vkCreateBufferView")?,
                allocator,
            ))
        }
        ObjectParams::Image(p) => {
            let info = vk::ImageCreateInfo::builder()
                .flags(p.flags)
                .image_type(p.image_type)
                .format(p.format)
                .extent(p.extent)
                .mip_levels(p.mip_levels)
                .array_layers(p.array_size)
                .samples(p.samples)
                .tiling(p.tiling)
                .usage(p.usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .queue_family_indices(&queue_families)
                .initial_layout(p.initial_layout);
            Owned::Image(Unique::with_allocator(
                device,
                unsafe { device.create_image(&info, allocator) }.vk_check("vkCreateImage")?,
                allocator,
            ))
        }
        ObjectParams::ImageView(p) => {
            let info = vk::ImageViewCreateInfo::builder()
                .image(res.image)
                .view_type(p.view_type)
                .format(p.format)
                .components(COMPONENT_MAPPING_RGBA)
                .subresource_range(p.subresource_range);
            Owned::ImageView(Unique::with_allocator(
                device,
                unsafe { device.create_image_view(&info, allocator) }.vk_check("vkCreateImageView")?,
                allocator,
            ))
        }
        ObjectParams::Semaphore => {
            let info = vk::SemaphoreCreateInfo::builder();
            Owned::Semaphore(Unique::with_allocator(
                device,
                unsafe { device.create_semaphore(&info, allocator) }.vk_check("vkCreateSemaphore")?,
                allocator,
            ))
        }
        ObjectParams::Fence(flags) => {
            let info = vk::FenceCreateInfo::builder().flags(*flags);
            Owned::Fence(Unique::with_allocator(
                device,
                unsafe { device.create_fence(&info, allocator) }.vk_check("vkCreateFence")?,
                allocator,
            ))
        }
        ObjectParams::Event => {
            let info = vk::EventCreateInfo::builder();
            Owned::Event(Unique::with_allocator(
                device,
                unsafe { device.create_event(&info, allocator) }.vk_check("vkCreateEvent")?,
                allocator,
            ))
        }
        ObjectParams::QueryPool(p) => {
            let info = vk::QueryPoolCreateInfo::builder()
                .query_type(p.query_type)
                .query_count(p.entry_count)
                .pipeline_statistics(p.pipeline_statistics);
            Owned::QueryPool(Unique::with_allocator(
                device,
                unsafe { device.create_query_pool(&info, allocator) }.vk_check("vkCreateQueryPool")?,
                allocator,
            ))
        }
        ObjectParams::ShaderModule { .. } => {
            let info = vk::ShaderModuleCreateInfo::builder().code_size(std::mem::size_of_val(res.binary)).code(res.binary);
            Owned::ShaderModule(Unique::with_allocator(
                device,
                unsafe { device.create_shader_module(&info, allocator) }.vk_check("vkCreateShaderModule")?,
                allocator,
            ))
        }
        ObjectParams::PipelineCache { extern_sync } => {
            let flags = if *extern_sync {
                vk::PipelineCacheCreateFlags::EXTERNALLY_SYNCHRONIZED
            } else {
                vk::PipelineCacheCreateFlags::empty()
            };
            let info = vk::PipelineCacheCreateInfo::builder().flags(flags);
            Owned::PipelineCache(Unique::with_allocator(
                device,
                unsafe { device.create_pipeline_cache(&info, allocator) }.vk_check("vkCreatePipelineCache")?,
                allocator,
            ))
        }
        ObjectParams::MergedPipelineCache { dst_extern_sync, .. } => {
            // A dummy compute pipeline first, so the source cache is not empty.
            create_dummy_compute_pipeline(env)?;

            let flags = if *dst_extern_sync {
                vk::PipelineCacheCreateFlags::EXTERNALLY_SYNCHRONIZED
            } else {
                vk::PipelineCacheCreateFlags::empty()
            };
            let info = vk::PipelineCacheCreateInfo::builder().flags(flags);
            let cache = unsafe { device.create_pipeline_cache(&info, allocator) }.vk_check("vkCreatePipelineCache")?;
            let cache = Unique::with_allocator(device, cache, allocator);
            unsafe { device.merge_pipeline_caches(cache.get(), &[res.src_pipeline_cache]) }.vk_check("vkMergePipelineCaches")?;
            Owned::PipelineCache(cache)
        }
        ObjectParams::Sampler => {
            let info = vk::SamplerCreateInfo::builder()
                .mag_filter(vk::Filter::NEAREST)
                .min_filter(vk::Filter::NEAREST)
                .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
                .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .mip_lod_bias(0.0)
                .anisotropy_enable(false)
                .max_anisotropy(1.0)
                .compare_enable(false)
                .compare_op(vk::CompareOp::ALWAYS)
                .min_lod(-1000.0)
                .max_lod(1000.0)
                .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
                .unnormalized_coordinates(false);
            Owned::Sampler(Unique::with_allocator(
                device,
                unsafe { device.create_sampler(&info, allocator) }.vk_check("vkCreateSampler")?,
                allocator,
            ))
        }
        ObjectParams::DescriptorSetLayout(_) => {
            let bindings: Vec<vk::DescriptorSetLayoutBinding> = res
                .bindings
                .iter()
                .map(|b| vk::DescriptorSetLayoutBinding {
                    binding: b.binding,
                    descriptor_type: b.descriptor_type,
                    descriptor_count: b.descriptor_count,
                    stage_flags: b.stage_flags,
                    immutable_samplers: if b.use_immutable_sampler { res.immutable_samplers.as_ptr() } else { std::ptr::null() },
                })
                .collect();
            let info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
            Owned::DescriptorSetLayout(Unique::with_allocator(
                device,
                unsafe { device.create_descriptor_set_layout(&info, allocator) }.vk_check("vkCreateDescriptorSetLayout")?,
                allocator,
            ))
        }
        ObjectParams::PipelineLayout(_) => {
            let info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&res.set_layouts);
            Owned::PipelineLayout(Unique::with_allocator(
                device,
                unsafe { device.create_pipeline_layout(&info, allocator) }.vk_check("vkCreatePipelineLayout")?,
                allocator,
            ))
        }
        ObjectParams::RenderPass => Owned::RenderPass(make_object_management_render_pass(device, allocator)?),
        ObjectParams::GraphicsPipeline => Owned::Pipeline(create_graphics_pipeline(env, res)?),
        ObjectParams::ComputePipeline => Owned::Pipeline(create_compute_pipeline(device, res.shader_modules[0], res.pipeline_layout, res.pipeline_cache, allocator)?),
        ObjectParams::DescriptorPool(p) => {
            let info = vk::DescriptorPoolCreateInfo::builder().flags(p.flags).max_sets(p.max_sets).pool_sizes(&p.pool_sizes);
            Owned::DescriptorPool(Unique::with_allocator(
                device,
                unsafe { device.create_descriptor_pool(&info, allocator) }.vk_check("vkCreateDescriptorPool")?,
                allocator,
            ))
        }
        ObjectParams::DescriptorSet(_) => {
            let layouts = [res.descriptor_set_layout];
            let info = vk::DescriptorSetAllocateInfo::builder().descriptor_pool(res.descriptor_pool).set_layouts(&layouts);
            let sets = unsafe { device.allocate_descriptor_sets(&info) }.vk_check("vkAllocateDescriptorSets")?;
            Owned::DescriptorSet(UniqueDescriptorSet::new(device, res.descriptor_pool, sets[0]))
        }
        ObjectParams::Framebuffer => {
            let info = vk::FramebufferCreateInfo::builder()
                .render_pass(res.render_pass)
                .attachments(&res.image_views)
                .width(256)
                .height(256)
                .layers(1);
            Owned::Framebuffer(Unique::with_allocator(
                device,
                unsafe { device.create_framebuffer(&info, allocator) }.vk_check("vkCreateFramebuffer")?,
                allocator,
            ))
        }
        ObjectParams::CommandPool(flags) => {
            let info = vk::CommandPoolCreateInfo::builder().flags(*flags).queue_family_index(env.queue_family_index);
            Owned::CommandPool(Unique::with_allocator(
                device,
                unsafe { device.create_command_pool(&info, allocator) }.vk_check("vkCreateCommandPool")?,
                allocator,
            ))
        }
        ObjectParams::CommandBuffer(p) => {
            let info = vk::CommandBufferAllocateInfo::builder()
                .command_pool(res.command_pool)
                .level(p.level)
                .command_buffer_count(1);
            let buffers = unsafe { device.allocate_command_buffers(&info) }.vk_check("vkAllocateCommandBuffers")?;
            Owned::CommandBuffer(UniqueCommandBuffer::new(device, res.command_pool, buffers[0]))
        }
    })
}

/// The last queue family with every requested capability - upstream keeps overwriting
/// as it scans, so the highest matching index wins.
fn find_queue_family(instance: &vulkanalia::Instance, physical_device: vk::PhysicalDevice, queue_flags: vk::QueueFlags) -> Result<u32, TestError> {
    let properties = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
    properties
        .iter()
        .enumerate()
        .rfind(|(_, family)| family.queue_flags.contains(queue_flags))
        .map(|(index, _)| index as u32)
        .ok_or_else(|| TestError::NotSupported("Matching queue not found".to_string()))
}

/// `Device::create` and `DeviceGroup::create` - the same device, with the group's
/// physical devices chained in for the latter.
fn create_test_device<'a>(
    env: &Environment<'a>,
    instance: &vulkanalia::Instance,
    physical_device: vk::PhysicalDevice,
    queue_family_index: u32,
    group: Option<&[vk::PhysicalDevice]>,
    allocator: Option<&'a vk::AllocationCallbacks>,
) -> Result<UniqueDevice<'a>, TestError> {
    let queue_priority = [1.0f32];
    let queues = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priority)
        .build()];

    if let Some(physical_devices) = group {
        // The group variant enables no extra features and takes pEnabledFeatures.
        let enabled_features = unsafe { instance.get_physical_device_features(physical_device) };
        let mut group_info = vk::DeviceGroupDeviceCreateInfo::builder().physical_devices(physical_devices).build();
        let info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queues)
            .enabled_features(&enabled_features)
            .push_next(&mut group_info);
        let device = unsafe { instance.create_device(physical_device, &info, allocator) }.vk_check("vkCreateDevice")?;
        return Ok(UniqueDevice { device, allocator });
    }

    // Everything the physical device supports is enabled, with pipeline-creation cache
    // control on top so the pipeline-cache cases have it - from 1.3 that lives in the
    // Vulkan 1.3 feature struct instead of its own extension.
    let mut extensions: Vec<*const i8> = Vec::new();
    let mut cache_control = vk::PhysicalDevicePipelineCreationCacheControlFeatures::default();
    let mut vulkan13 = vk::PhysicalDeviceVulkan13Features::default();
    let pre_1_3 = env.api_version < vk::make_version(1, 3, 0);
    if pre_1_3 {
        extensions.push(vk::EXT_PIPELINE_CREATION_CACHE_CONTROL_EXTENSION.name.as_ptr());
    }

    let mut enabled_features = vk::PhysicalDeviceFeatures2::default();
    if pre_1_3 {
        enabled_features.next = (&raw mut cache_control).cast();
    } else {
        enabled_features.next = (&raw mut vulkan13).cast();
    }
    unsafe { instance.get_physical_device_features2(physical_device, &mut enabled_features) };

    let info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queues)
        .enabled_extension_names(&extensions)
        .push_next(&mut enabled_features);
    let device = unsafe { instance.create_device(physical_device, &info, allocator) }.vk_check("vkCreateDevice")?;
    Ok(UniqueDevice { device, allocator })
}

/// `RenderPass::create` - `makeRenderPass` with a colour and a depth/stencil
/// attachment, both cleared on load.
fn make_object_management_render_pass<'a>(device: &'a Device, allocator: Option<&'a vk::AllocationCallbacks>) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let attachments = [
        vk::AttachmentDescription::builder()
            .format(vk::Format::R8G8B8A8_UNORM)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(vk::Format::D16_UNORM)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
            .stencil_store_op(vk::AttachmentStoreOp::STORE)
            .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build(),
    ];
    let color_ref = vk::AttachmentReference::builder().attachment(0).layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
    let color_refs = [color_ref];
    let depth_ref = vk::AttachmentReference::builder().attachment(1).layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL);
    let subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)
        .depth_stencil_attachment(&depth_ref);
    let subpasses = [subpass];
    let info = vk::RenderPassCreateInfo::builder().attachments(&attachments).subpasses(&subpasses);
    Ok(Unique::with_allocator(
        device,
        unsafe { device.create_render_pass(&info, allocator) }.vk_check("vkCreateRenderPass")?,
        allocator,
    ))
}

/// `GraphicsPipeline::createMultiple` with one pipeline.
fn create_graphics_pipeline<'a>(env: &Environment<'a>, res: &Resources<'a>) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let device = env.device;
    let entry = c"main";
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(res.shader_modules[0])
            .name(entry.to_bytes_with_nul())
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(res.shader_modules[1])
            .name(entry.to_bytes_with_nul())
            .build(),
    ];
    let bindings = [vk::VertexInputBindingDescription::builder()
        .binding(0)
        .stride(16)
        .input_rate(vk::VertexInputRate::VERTEX)
        .build()];
    let attributes = [vk::VertexInputAttributeDescription::builder()
        .location(0)
        .binding(0)
        .format(vk::Format::R32G32B32A32_SFLOAT)
        .offset(0)
        .build()];
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: 64.0,
        height: 64.0,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D { width: 64, height: 64 },
    }];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);
    let raster_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::BACK)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(1.0);
    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::ALWAYS)
        .build();
    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(true)
        .depth_write_enable(true)
        .depth_compare_op(vk::CompareOp::LESS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .src_color_blend_factor(vk::BlendFactor::ONE)
        .dst_color_blend_factor(vk::BlendFactor::ZERO)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ONE)
        .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::COPY)
        .attachments(&blend_attachments)
        .blend_constants([0.0; 4]);
    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&raster_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&color_blend_state)
        .layout(res.pipeline_layout)
        .render_pass(res.render_pass)
        .subpass(0);
    let pipelines = unsafe { device.create_graphics_pipelines(res.pipeline_cache, &[info], env.allocation_callbacks) }.vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::with_allocator(device, pipelines.0[0], env.allocation_callbacks))
}

/// `ComputePipeline::create`
fn create_compute_pipeline<'a>(
    device: &'a Device,
    module: vk::ShaderModule,
    layout: vk::PipelineLayout,
    cache: vk::PipelineCache,
    allocator: Option<&'a vk::AllocationCallbacks>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entry = c"main";
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(entry.to_bytes_with_nul())
        .build();
    let info = vk::ComputePipelineCreateInfo::builder().stage(stage).layout(layout);
    let pipelines = unsafe { device.create_compute_pipelines(cache, &[info], allocator) }.vk_check("vkCreateComputePipelines")?;
    Ok(Unique::with_allocator(device, pipelines.0[0], allocator))
}

/// The throwaway compute pipeline `MergedPipelineCache::create` builds so the source
/// cache has something in it to merge.
fn create_dummy_compute_pipeline(env: &Environment<'_>) -> Result<(), TestError> {
    let device = env.device;
    let module = create_shader_module(device, env.programs.get("comp")?)?;
    let bindings = [
        vk::DescriptorSetLayoutBinding {
            binding: 0,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            descriptor_count: 1,
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            immutable_samplers: std::ptr::null(),
        },
        vk::DescriptorSetLayoutBinding {
            binding: 1,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            descriptor_count: 1,
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            immutable_samplers: std::ptr::null(),
        },
    ];
    let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
    let set_layout = Unique::with_allocator(
        device,
        unsafe { device.create_descriptor_set_layout(&layout_info, env.allocation_callbacks) }.vk_check("vkCreateDescriptorSetLayout")?,
        env.allocation_callbacks,
    );
    let set_layouts = [set_layout.get()];
    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
    let pipeline_layout = Unique::with_allocator(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_info, env.allocation_callbacks) }.vk_check("vkCreatePipelineLayout")?,
        env.allocation_callbacks,
    );
    let _pipeline = create_compute_pipeline(device, *module, pipeline_layout.get(), vk::PipelineCache::null(), env.allocation_callbacks)?;
    Ok(())
}

// ---------------------------------------------------------------------------------
// Test cases
// ---------------------------------------------------------------------------------

/// The test variants ported here.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Variant {
    /// `createSingleTest`
    Single,
    /// `createMultipleUniqueResourcesTest`
    MultipleUniqueResources,
    /// `createMultipleSharedResourcesTest`
    MultipleSharedResources,
    /// `createMaxConcurrentTest`
    MaxConcurrent,
    /// `multithreadedCreateSharedResourcesTest`
    MultithreadedSharedResources,
    /// `multithreadedCreatePerThreadResourcesTest`
    MultithreadedPerThreadResources,
    /// `multithreadedCreatePerThreadDeviceTest`
    MultithreadedPerThreadDevice,
    /// `createSingleAllocCallbacksTest`
    SingleAllocCallbacks,
}

struct ObjectManagementCase {
    name: &'static str,
    params: ObjectParams,
    variant: Variant,
}

impl TestCase for ObjectManagementCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match &self.params {
            // `checkImageCubeArraySupport`
            ObjectParams::ImageView(p) if p.view_type == vk::ImageViewType::CUBE_ARRAY => {
                if context.get_device_features().image_cube_array == 0 {
                    return Err(TestError::NotSupported("imageCubeArray feature is not supported by this implementation".to_string()));
                }
            }
            // `checkDeviceGroupSupport` - the group has to exist before the case can
            // ask for a device in it.
            ObjectParams::DeviceGroup(p) => {
                let groups = unsafe { context.get_instance().enumerate_physical_device_groups() }.vk_check("vkEnumeratePhysicalDeviceGroups")?;
                if groups.len() <= p.device_group_index {
                    return Err(TestError::NotSupported("Device Group not found".to_string()));
                }
            }
            // `checkPipelineCacheControlSupport`
            ObjectParams::MergedPipelineCache { .. } if !context.is_device_functionality_supported("VK_EXT_pipeline_creation_cache_control") => {
                return Err(TestError::NotSupported("pipelineCreationCacheControl not supported by this implementation".to_string()));
            }
            _ => {}
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::api_object_management::OBJECT_MANAGEMENT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ObjectManagementInstance { context, params: self })
    }
}

struct ObjectManagementInstance<'a> {
    context: &'a Context<'a>,
    params: &'a ObjectManagementCase,
}

impl TestInstance for ObjectManagementInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let case = self.params;
        match case.variant {
            Variant::Single => {
                let env = Environment::new(self.context, 1);
                let res = Resources::new(&env, &case.params)?;
                {
                    let _object = create_object(&env, &res, &case.params)?;
                }
            }
            Variant::MultipleUniqueResources => {
                let env = Environment::new(self.context, 1);
                let resources = [
                    Resources::new(&env, &case.params)?,
                    Resources::new(&env, &case.params)?,
                    Resources::new(&env, &case.params)?,
                    Resources::new(&env, &case.params)?,
                ];
                {
                    let mut objects = Vec::with_capacity(4);
                    for res in &resources {
                        objects.push(create_object(&env, res, &case.params)?);
                    }
                }
            }
            Variant::MaxConcurrent => {
                let num_objects = get_max_concurrent(self.context, &case.params)?;
                let env = Environment::new(self.context, num_objects);
                let res = Resources::new(&env, &case.params)?;
                {
                    let mut objects = Vec::with_capacity(num_objects as usize);
                    for _ in 0..num_objects {
                        objects.push(create_object(&env, &res, &case.params)?);
                    }
                }
            }
            Variant::MultithreadedSharedResources => {
                let num_threads = default_test_thread_count();
                let env = Environment::new(self.context, num_threads);
                let res = Resources::new(&env, &case.params)?;
                run_create_threads(num_threads, std::iter::repeat_n((&env, &res), num_threads as usize), &case.params)?;
            }
            Variant::MultithreadedPerThreadResources => {
                let num_threads = default_test_thread_count();
                let env = Environment::new(self.context, 1);
                let mut resources = Vec::with_capacity(num_threads as usize);
                for _ in 0..num_threads {
                    resources.push(Resources::new(&env, &case.params)?);
                }
                run_create_threads(num_threads, resources.iter().map(|res| (&env, res)), &case.params)?;
            }
            Variant::MultithreadedPerThreadDevice => {
                let num_threads = default_test_thread_count();
                let shared_env = Environment::new(self.context, num_threads);
                let mut per_thread_env = Vec::with_capacity(num_threads as usize);
                for _ in 0..num_threads {
                    per_thread_env.push(EnvClone::new(&shared_env, DEFAULT_DEVICE_PARAMS, 1)?);
                }
                let envs: Vec<Environment<'_>> = per_thread_env.iter().map(EnvClone::env).collect();
                let mut resources = Vec::with_capacity(num_threads as usize);
                for env in &envs {
                    resources.push(Resources::new(env, &case.params)?);
                }
                run_create_threads(num_threads, envs.iter().zip(resources.iter()), &case.params)?;
                // The objects have to go before the devices they were made on.
                drop(resources);
            }
            Variant::SingleAllocCallbacks => return self.single_alloc_callbacks(),
            Variant::MultipleSharedResources => {
                let env = Environment::new(self.context, 4);
                let res = Resources::new(&env, &case.params)?;
                {
                    let mut objects = Vec::with_capacity(4);
                    for _ in 0..4 {
                        objects.push(create_object(&env, &res, &case.params)?);
                    }
                }
            }
        }
        Ok(TestStatus::pass("Ok"))
    }
}

/// `getDefaulDeviceParameters` - the first device, on a queue family that does both
/// graphics and compute.
const DEFAULT_DEVICE_PARAMS: DeviceParams = DeviceParams {
    device_group_index: 0,
    device_index: 0,
    queue_flags: vk::QueueFlags::from_bits_truncate(vk::QueueFlags::GRAPHICS.bits() | vk::QueueFlags::COMPUTE.bits()),
};

/// `EnvClone` - a second environment whose device, and the instance under it, the case
/// creates for itself.
struct EnvClone<'a> {
    // Declaration order is destruction order in Rust, and the device has to go before
    // the instance its resources hold.
    device: Box<UniqueDevice<'a>>,
    /// Held only to be dropped after the device: it owns the instance the device
    /// was made on.
    #[expect(dead_code, reason = "the value is the RAII guard, not something to read")]
    device_resources: Resources<'a>,
    queue_family_index: u32,
    entry: &'a vulkanalia::Entry,
    api_version: u32,
    programs: BinaryCollection,
    allocation_callbacks: Option<&'a vk::AllocationCallbacks>,
    max_resource_consumers: u32,
}

impl<'a> EnvClone<'a> {
    fn new(parent: &Environment<'a>, params: DeviceParams, max_resource_consumers: u32) -> Result<Self, TestError> {
        let object_params = ObjectParams::Device(params);
        let device_resources = Resources::new(parent, &object_params)?;
        let Owned::Device(device) = create_object(parent, &device_resources, &object_params)? else {
            unreachable!("device object")
        };
        Ok(Self {
            device,
            queue_family_index: device_resources.device_queue_family_index,
            device_resources,
            entry: parent.entry,
            api_version: parent.api_version,
            programs: parent.programs,
            allocation_callbacks: parent.allocation_callbacks,
            max_resource_consumers,
        })
    }

    fn env(&self) -> Environment<'_> {
        Environment {
            entry: self.entry,
            api_version: self.api_version,
            device: &self.device.device,
            queue_family_index: self.queue_family_index,
            programs: self.programs,
            allocation_callbacks: self.allocation_callbacks,
            max_resource_consumers: self.max_resource_consumers,
        }
    }
}

/// `getDefaultTestThreadCount`
fn default_test_thread_count() -> u32 {
    std::thread::available_parallelism().map_or(2, |n| n.get() as u32).clamp(2, 8)
}

/// `getCreateCount` - how many objects each thread creates and destroys. Creating a
/// device or an instance takes far longer than anything else, so those get fewer.
fn create_count(params: &ObjectParams) -> u32 {
    match params {
        ObjectParams::Instance | ObjectParams::Device(_) | ObjectParams::DeviceGroup(_) => 20,
        _ => 100,
    }
}

/// `ThreadGroup::run` over one `CreateThread` per resource set.
///
/// Each thread creates and immediately destroys `CREATE_COUNT` objects, syncing every
/// fifth of the way so the threads are inside the driver at the same time.
fn run_create_threads<'a, 'e>(num_threads: u32, work: impl Iterator<Item = (&'e Environment<'a>, &'e Resources<'a>)>, params: &ObjectParams) -> Result<(), TestError>
where
    'a: 'e,
{
    let barrier = std::sync::Barrier::new(num_threads as usize);
    let create_count = create_count(params);
    let iters_between_syncs = create_count / 5;
    let work: Vec<(&Environment<'a>, &Resources<'a>)> = work.collect();

    std::thread::scope(|scope| {
        let handles: Vec<_> = work
            .iter()
            .map(|(env, res)| {
                let (env, res) = (*env, *res);
                let barrier = &barrier;
                scope.spawn(move || -> Result<(), TestError> {
                    for iter_ndx in 0..create_count {
                        if iter_ndx.is_multiple_of(iters_between_syncs) {
                            barrier.wait();
                        }
                        let _object = create_object(env, res, params)?;
                    }
                    Ok(())
                })
            })
            .collect();
        for handle in handles {
            handle.join().map_err(|_| TestError::InternalError("a creating thread panicked".to_string()))??;
        }
        Ok(())
    })
}

impl ObjectManagementInstance<'_> {
    /// `createSingleAllocCallbacksTest` - the resources and the object under test get
    /// a recorder each, and the object's must come back empty once it is destroyed.
    fn single_alloc_callbacks(&self) -> TestOutcome {
        let case = self.params;
        // Everything but a command-scope allocation may still be live while the object
        // exists; a command-scope one must not outlive the call that made it.
        let no_cmd_scope = (1u32 << vk::SystemAllocationScope::INSTANCE.as_raw())
            | (1u32 << vk::SystemAllocationScope::DEVICE.as_raw())
            | (1u32 << vk::SystemAllocationScope::CACHE.as_raw())
            | (1u32 << vk::SystemAllocationScope::OBJECT.as_raw());

        let res_callbacks = AllocationCallbackRecorder::new();
        // The root environment still uses the default instance and device; only what
        // the case builds itself goes through the callbacks.
        let root_env = Environment::with_callbacks(self.context, 1, res_callbacks.callbacks());
        {
            let res_env = EnvClone::new(&root_env, DEFAULT_DEVICE_PARAMS, 1)?;
            let env = res_env.env();
            let res = Resources::new(&env, &case.params)?;

            let obj_callbacks = AllocationCallbackRecorder::new();
            let obj_env = Environment {
                allocation_callbacks: Some(obj_callbacks.callbacks()),
                ..env
            };
            {
                let _object = create_object(&obj_env, &res, &case.params)?;
                if !obj_callbacks.validate(no_cmd_scope) {
                    return Ok(TestStatus::fail("Invalid allocation callback"));
                }
            }
            if !obj_callbacks.validate(0) {
                return Ok(TestStatus::fail("Invalid allocation callback"));
            }
        }
        if !res_callbacks.validate(0) {
            return Ok(TestStatus::fail("Invalid allocation callback"));
        }
        Ok(TestStatus::pass("Ok"))
    }
}

// ---------------------------------------------------------------------------------
// getMaxConcurrent
// ---------------------------------------------------------------------------------

/// `tcu::PlatformMemoryLimits`, at `tcu::Platform::getMemoryLimits`' defaults - the
/// Linux platform does not override them.
struct PlatformMemoryLimits;

impl PlatformMemoryLimits {
    const TOTAL_SYSTEM_MEMORY: u64 = 256 * 1024 * 1024;
    const TOTAL_DEVICE_LOCAL_MEMORY: u64 = 128 * 1024 * 1024;
    const DEVICE_MEMORY_ALLOCATION_GRANULARITY: u64 = 64 * 1024;
    const DEVICE_PAGE_SIZE: u64 = 4096;
    const DEVICE_PAGE_TABLE_ENTRY_SIZE: u64 = 8;
    const DEVICE_PAGE_TABLE_HIERARCHY_LEVELS: u32 = 3;
}

const MAX_CONCURRENT_INSTANCES: u32 = 32;
const MAX_CONCURRENT_DEVICES: u32 = 32;
const MAX_CONCURRENT_SYNC_PRIMITIVES: u32 = 100;
const MAX_CONCURRENT_PIPELINE_CACHES: u32 = 128;
const MAX_CONCURRENT_QUERY_POOLS: u32 = 8192;
const DEFAULT_MAX_CONCURRENT_OBJECTS: u32 = 16 * 1024;

fn align_to_power_of_two(value: u64, align: u64) -> u64 {
    (value + align - 1) & !(align - 1)
}

fn round_up_to_next_multiple(value: u64, multiple: u64) -> u64 {
    if value.is_multiple_of(multiple) { value } else { value + multiple - (value % multiple) }
}

/// `getPageTableSize` - what a page table covering `allocation_size` would itself cost.
fn get_page_table_size(allocation_size: u64) -> u64 {
    let mut total = 0u64;
    for level in 0..PlatformMemoryLimits::DEVICE_PAGE_TABLE_HIERARCHY_LEVELS {
        let covered = PlatformMemoryLimits::DEVICE_PAGE_SIZE << level;
        let pages_needed = align_to_power_of_two(allocation_size, covered) / covered;
        total += pages_needed * PlatformMemoryLimits::DEVICE_PAGE_TABLE_ENTRY_SIZE;
    }
    total
}

/// `getSafeObjectCount`
///
/// The branch structure is upstream's; rewriting the guards as `checked_div` would
/// lose the correspondence for no behavioural difference.
#[expect(clippy::manual_checked_ops, reason = "kept in upstream's branch shape")]
fn get_safe_object_count(object_system_memory_usage: u64, object_device_memory_usage: u64) -> u64 {
    let rounded_up_device_memory = round_up_to_next_multiple(object_device_memory_usage, PlatformMemoryLimits::DEVICE_MEMORY_ALLOCATION_GRANULARITY);

    if PlatformMemoryLimits::TOTAL_DEVICE_LOCAL_MEMORY > 0 && rounded_up_device_memory > 0 {
        if object_system_memory_usage > 0 {
            (PlatformMemoryLimits::TOTAL_SYSTEM_MEMORY / object_system_memory_usage).min(PlatformMemoryLimits::TOTAL_DEVICE_LOCAL_MEMORY / rounded_up_device_memory)
        } else {
            PlatformMemoryLimits::TOTAL_DEVICE_LOCAL_MEMORY / rounded_up_device_memory
        }
    } else if object_system_memory_usage + rounded_up_device_memory > 0 {
        PlatformMemoryLimits::TOTAL_SYSTEM_MEMORY / (object_system_memory_usage + rounded_up_device_memory)
    } else {
        // The driver has not implemented allocation callbacks; only the hard limit
        // bounds the count then, which is what upstream falls back to too.
        u64::MAX
    }
}

/// `computeSystemMemoryUsage` - how much host memory the driver spends on one object,
/// measured by creating it through a recording allocator.
fn compute_system_memory_usage(context: &Context<'_>, params: &ObjectParams) -> Result<u64, TestError> {
    let recorder = AllocationCallbackRecorder::new();
    let usage = {
        let env = Environment::with_callbacks(context, 1, recorder.callbacks());
        let res = Resources::new(&env, params)?;
        let resource_usage = recorder.current_system_memory_usage();
        let _object = create_object(&env, &res, params)?;
        recorder.current_system_memory_usage().saturating_sub(resource_usage)
    };
    if recorder.violations() > 0 {
        return Err(TestError::InternalError("allocation callbacks were misused by the driver".to_string()));
    }
    Ok(usage as u64)
}

/// `Object::getMaxConcurrent` - the per-object hard limit, cut down by what one object
/// costs in host and device memory.
fn get_max_concurrent(context: &Context<'_>, params: &ObjectParams) -> Result<u32, TestError> {
    let limits = context.get_device_properties().limits;
    let (hard_limit, device_memory_usage) = match params {
        ObjectParams::Instance => (MAX_CONCURRENT_INSTANCES, 0),
        ObjectParams::Device(_) => (MAX_CONCURRENT_DEVICES, 0),
        ObjectParams::DeviceGroup(p) => {
            let groups = unsafe { context.get_instance().enumerate_physical_device_groups() }.vk_check("vkEnumeratePhysicalDeviceGroups")?;
            (MAX_CONCURRENT_DEVICES / groups[p.device_group_index].physical_device_count, 0)
        }
        ObjectParams::DeviceMemory(p) => (limits.max_memory_allocation_count.min(DEFAULT_MAX_CONCURRENT_OBJECTS), p.size + get_page_table_size(p.size)),
        ObjectParams::Buffer(_) | ObjectParams::Image(_) => {
            // The object has to exist before its memory requirements can be asked for.
            let env = Environment::new(context, 1);
            let res = Resources::new(&env, params)?;
            let object = create_object(&env, &res, params)?;
            let requirements = match &object {
                Owned::Buffer(buffer) => unsafe { env.device.get_buffer_memory_requirements(buffer.get()) },
                Owned::Image(image) => unsafe { env.device.get_image_memory_requirements(image.get()) },
                _ => unreachable!("buffer or image"),
            };
            (DEFAULT_MAX_CONCURRENT_OBJECTS, get_page_table_size(requirements.size))
        }
        ObjectParams::Semaphore | ObjectParams::Fence(_) | ObjectParams::Event => (MAX_CONCURRENT_SYNC_PRIMITIVES, 0),
        ObjectParams::QueryPool(_) => (MAX_CONCURRENT_QUERY_POOLS, 0),
        ObjectParams::PipelineCache { .. } | ObjectParams::MergedPipelineCache { .. } => (MAX_CONCURRENT_PIPELINE_CACHES, 0),
        ObjectParams::Sampler => (limits.max_sampler_allocation_count.min(DEFAULT_MAX_CONCURRENT_OBJECTS), 0),
        _ => (DEFAULT_MAX_CONCURRENT_OBJECTS, 0),
    };

    let system_memory_usage = compute_system_memory_usage(context, params)?;
    let safe = get_safe_object_count(system_memory_usage, device_memory_usage);
    Ok(u64::from(hard_limit).min(safe) as u32)
}

// ---------------------------------------------------------------------------------
// Case registration
// ---------------------------------------------------------------------------------

fn image_params(flags: vk::ImageCreateFlags, image_type: vk::ImageType, extent: vk::Extent3D, array_size: u32, usage: vk::ImageUsageFlags) -> ImageParams {
    ImageParams {
        flags,
        image_type,
        format: vk::Format::R8G8B8A8_UNORM,
        extent,
        mip_levels: 1,
        array_size,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `createObjectManagementTests`' parameter tables, in upstream's order.
fn all_cases() -> Vec<(&'static str, ObjectParams)> {
    let img_1d = image_params(
        vk::ImageCreateFlags::empty(),
        vk::ImageType::_1D,
        make_extent_3d(256, 1, 1),
        4,
        vk::ImageUsageFlags::SAMPLED,
    );
    let img_2d = image_params(
        vk::ImageCreateFlags::empty(),
        vk::ImageType::_2D,
        make_extent_3d(64, 64, 1),
        12,
        vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::COLOR_ATTACHMENT,
    );
    let img_cube = image_params(
        vk::ImageCreateFlags::CUBE_COMPATIBLE,
        vk::ImageType::_2D,
        make_extent_3d(64, 64, 1),
        12,
        vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::COLOR_ATTACHMENT,
    );
    let img_3d = image_params(
        vk::ImageCreateFlags::empty(),
        vk::ImageType::_3D,
        make_extent_3d(64, 64, 4),
        1,
        vk::ImageUsageFlags::SAMPLED,
    );
    let image_view = |image: ImageParams, view_type: vk::ImageViewType, layer_count: u32| {
        ObjectParams::ImageView(ImageViewParams {
            image,
            view_type,
            format: image.format,
            subresource_range: make_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layer_count),
        })
    };
    let single_ubo_desc_layout = DescriptorSetLayoutParams::single(0, vk::DescriptorType::UNIFORM_BUFFER, 1, vk::ShaderStageFlags::VERTEX, false);

    // `deviceIndex` and `deviceGroupIndex` come from the command line upstream; this
    // port always runs on the first of each.
    let device_params = DeviceParams {
        device_group_index: 0,
        device_index: 0,
        queue_flags: vk::QueueFlags::GRAPHICS,
    };

    vec![
        ("instance", ObjectParams::Instance),
        ("device", ObjectParams::Device(device_params)),
        ("device_group", ObjectParams::DeviceGroup(device_params)),
        ("device_memory_small", ObjectParams::DeviceMemory(DeviceMemoryParams { size: 1024, memory_type_index: 0 })),
        (
            "buffer_uniform_small",
            ObjectParams::Buffer(BufferParams {
                size: 1024,
                usage: vk::BufferUsageFlags::UNIFORM_BUFFER,
            }),
        ),
        (
            "buffer_uniform_large",
            ObjectParams::Buffer(BufferParams {
                size: 1024 * 1024 * 16,
                usage: vk::BufferUsageFlags::UNIFORM_BUFFER,
            }),
        ),
        (
            "buffer_storage_small",
            ObjectParams::Buffer(BufferParams {
                size: 1024,
                usage: vk::BufferUsageFlags::STORAGE_BUFFER,
            }),
        ),
        (
            "buffer_storage_large",
            ObjectParams::Buffer(BufferParams {
                size: 1024 * 1024 * 16,
                usage: vk::BufferUsageFlags::STORAGE_BUFFER,
            }),
        ),
        (
            "buffer_view_uniform_r8g8b8a8_unorm",
            ObjectParams::BufferView(BufferViewParams {
                buffer: BufferParams {
                    size: 8192,
                    usage: vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER,
                },
                format: vk::Format::R8G8B8A8_UNORM,
                offset: 0,
                range: 4096,
            }),
        ),
        (
            "buffer_view_storage_r8g8b8a8_unorm",
            ObjectParams::BufferView(BufferViewParams {
                buffer: BufferParams {
                    size: 8192,
                    usage: vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER,
                },
                format: vk::Format::R8G8B8A8_UNORM,
                offset: 0,
                range: 4096,
            }),
        ),
        ("image_1d", ObjectParams::Image(img_1d)),
        ("image_2d", ObjectParams::Image(img_2d)),
        ("image_3d", ObjectParams::Image(img_3d)),
        ("image_view_1d", image_view(img_1d, vk::ImageViewType::_1D, 1)),
        ("image_view_1d_arr", image_view(img_1d, vk::ImageViewType::_1D_ARRAY, 4)),
        ("image_view_2d", image_view(img_2d, vk::ImageViewType::_2D, 1)),
        ("image_view_2d_arr", image_view(img_2d, vk::ImageViewType::_2D_ARRAY, 8)),
        ("image_view_cube", image_view(img_cube, vk::ImageViewType::CUBE, 6)),
        ("image_view_cube_arr", image_view(img_cube, vk::ImageViewType::CUBE_ARRAY, 12)),
        ("image_view_3d", image_view(img_3d, vk::ImageViewType::_3D, 1)),
        ("semaphore", ObjectParams::Semaphore),
        ("event", ObjectParams::Event),
        ("fence", ObjectParams::Fence(vk::FenceCreateFlags::empty())),
        ("fence_signaled", ObjectParams::Fence(vk::FenceCreateFlags::SIGNALED)),
        (
            "query_pool",
            ObjectParams::QueryPool(QueryPoolParams {
                query_type: vk::QueryType::OCCLUSION,
                entry_count: 1,
                pipeline_statistics: vk::QueryPipelineStatisticFlags::empty(),
            }),
        ),
        ("shader_module", ObjectParams::ShaderModule { binary_name: "test" }),
        ("pipeline_cache", ObjectParams::PipelineCache { extern_sync: false }),
        (
            "merged_pipeline_cache",
            ObjectParams::MergedPipelineCache {
                src_extern_sync: false,
                dst_extern_sync: false,
            },
        ),
        (
            "merged_pipeline_cache_src_sync",
            ObjectParams::MergedPipelineCache {
                src_extern_sync: true,
                dst_extern_sync: false,
            },
        ),
        (
            "merged_pipeline_cache_dst_sync",
            ObjectParams::MergedPipelineCache {
                src_extern_sync: false,
                dst_extern_sync: true,
            },
        ),
        (
            "merged_pipeline_cache_src_dst_sync",
            ObjectParams::MergedPipelineCache {
                src_extern_sync: true,
                dst_extern_sync: true,
            },
        ),
        (
            "pipeline_layout_empty",
            ObjectParams::PipelineLayout(PipelineLayoutParams {
                descriptor_set_layouts: Vec::new(),
            }),
        ),
        (
            "pipeline_layout_single",
            ObjectParams::PipelineLayout(PipelineLayoutParams {
                descriptor_set_layouts: vec![single_ubo_desc_layout.clone()],
            }),
        ),
        ("render_pass", ObjectParams::RenderPass),
        ("graphics_pipeline", ObjectParams::GraphicsPipeline),
        ("compute_pipeline", ObjectParams::ComputePipeline),
        ("descriptor_set_layout_empty", ObjectParams::DescriptorSetLayout(DescriptorSetLayoutParams::empty())),
        ("descriptor_set_layout_single", ObjectParams::DescriptorSetLayout(single_ubo_desc_layout.clone())),
        ("sampler", ObjectParams::Sampler),
        (
            "descriptor_pool",
            ObjectParams::DescriptorPool(DescriptorPoolParams {
                flags: vk::DescriptorPoolCreateFlags::empty(),
                max_sets: 4,
                pool_sizes: vec![vk::DescriptorPoolSize {
                    type_: vk::DescriptorType::UNIFORM_BUFFER,
                    descriptor_count: 3,
                }],
            }),
        ),
        (
            "descriptor_pool_free_descriptor_set",
            ObjectParams::DescriptorPool(DescriptorPoolParams {
                flags: vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                max_sets: 4,
                pool_sizes: vec![vk::DescriptorPoolSize {
                    type_: vk::DescriptorType::UNIFORM_BUFFER,
                    descriptor_count: 3,
                }],
            }),
        ),
        ("descriptor_set", ObjectParams::DescriptorSet(single_ubo_desc_layout)),
        ("framebuffer", ObjectParams::Framebuffer),
        ("command_pool", ObjectParams::CommandPool(vk::CommandPoolCreateFlags::empty())),
        ("command_pool_transient", ObjectParams::CommandPool(vk::CommandPoolCreateFlags::TRANSIENT)),
        (
            "command_buffer_primary",
            ObjectParams::CommandBuffer(CommandBufferParams {
                command_pool_flags: vk::CommandPoolCreateFlags::empty(),
                level: vk::CommandBufferLevel::PRIMARY,
            }),
        ),
        (
            "command_buffer_secondary",
            ObjectParams::CommandBuffer(CommandBufferParams {
                command_pool_flags: vk::CommandPoolCreateFlags::empty(),
                level: vk::CommandBufferLevel::SECONDARY,
            }),
        ),
    ]
}

/// `createObjectManagementTests`, minus the variants and object kinds not ported.
pub fn create_object_management_tests() -> tcu::TestCaseGroup {
    let mut tests = tcu::TestCaseGroup::new("object_management");
    for (group_name, variant) in [
        ("single", Variant::Single),
        ("multiple_unique_resources", Variant::MultipleUniqueResources),
        ("multiple_shared_resources", Variant::MultipleSharedResources),
        ("max_concurrent", Variant::MaxConcurrent),
        ("multithreaded_shared_resources", Variant::MultithreadedSharedResources),
        ("multithreaded_per_thread_resources", Variant::MultithreadedPerThreadResources),
        ("multithreaded_per_thread_device", Variant::MultithreadedPerThreadDevice),
        ("single_alloc_callbacks", Variant::SingleAllocCallbacks),
    ] {
        let mut group = tcu::TestCaseGroup::new(group_name);
        for (name, params) in all_cases() {
            // A command pool and a descriptor pool are externally synchronised, so
            // upstream leaves out the object kinds that would allocate from a shared
            // one on several threads at once.
            if variant == Variant::MultithreadedSharedResources && matches!(params, ObjectParams::CommandBuffer(_) | ObjectParams::DescriptorSet(_)) {
                continue;
            }
            // An instance has no resources to share, so the two shared-resource
            // variants have nothing to say about it and upstream leaves it out.
            if matches!(variant, Variant::MultipleSharedResources | Variant::MultithreadedSharedResources) && matches!(params, ObjectParams::Instance) {
                continue;
            }
            // The per-thread-device variant already makes an instance and a device per
            // thread, so those three object kinds have nothing left to test there.
            if variant == Variant::MultithreadedPerThreadDevice && matches!(params, ObjectParams::Instance | ObjectParams::Device(_) | ObjectParams::DeviceGroup(_)) {
                continue;
            }
            group.add_child(Box::new(ObjectManagementCase { name, params, variant }) as Box<dyn TestCase>);
        }
        tests.add_child(group);
    }
    tests
}
