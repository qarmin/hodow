//! Vulkan compute: the shared [`Plan`] as storage buffers, one pipeline per launch.
//!
//! Copy keeps every buffer device-local and moves data through host-visible staging buffers
//! with `vkCmdCopyBuffer`; map puts the input and output straight in host-visible memory
//! (cached where the device offers it, since reading uncached memory is what made OpenCL's
//! readback slow) and copies with `memcpy`. Zero-copy needs VK_EXT_external_memory_host.

use std::time::Instant;

use ash::vk;

use super::shaders::{self, Plan, Refusal};
use super::spec::{RowStatus, Strategy, Task, Variant};
use super::{Bench, FrameTimes};

const BINDINGS: u32 = 5;

fn failed(what: &str) -> impl Fn(vk::Result) -> String + '_ {
    move |e| format!("{what}: {e}")
}

pub struct Session {
    _entry: ash::Entry,
    instance: ash::Instance,
    device: ash::Device,
    queue: vk::Queue,
    memory: vk::PhysicalDeviceMemoryProperties,
    pool: vk::CommandPool,
    fence: vk::Fence,
    set_layout: vk::DescriptorSetLayout,
    layout: vk::PipelineLayout,
    /// Nanoseconds per timestamp tick, when the compute queue has timestamps at all.
    tick_ns: Option<f64>,
    pub label: String,
    pub host_import: bool,
}

impl Drop for Session {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_pipeline_layout(self.layout, None);
            self.device.destroy_descriptor_set_layout(self.set_layout, None);
            self.device.destroy_fence(self.fence, None);
            self.device.destroy_command_pool(self.pool, None);
            self.device.destroy_device(None);
            self.instance.destroy_instance(None);
        }
    }
}

impl Session {
    pub fn open() -> Result<Self, String> {
        unsafe {
            let entry = ash::Entry::load().map_err(|e| format!("no Vulkan loader: {e}"))?;
            let app = vk::ApplicationInfo::default()
                .application_name(c"hodow bench")
                .api_version(vk::make_api_version(0, 1, 1, 0));
            let instance = entry
                .create_instance(&vk::InstanceCreateInfo::default().application_info(&app), None)
                .map_err(failed("vkCreateInstance"))?;
            match Self::with_instance(entry, instance.clone()) {
                Ok(s) => Ok(s),
                Err(e) => {
                    instance.destroy_instance(None);
                    Err(e)
                }
            }
        }
    }

    unsafe fn with_instance(entry: ash::Entry, instance: ash::Instance) -> Result<Self, String> {
        unsafe {
            let devices = instance
                .enumerate_physical_devices()
                .map_err(failed("vkEnumeratePhysicalDevices"))?;
            let pd = devices
                .iter()
                .copied()
                .find(|&pd| instance.get_physical_device_properties(pd).device_type != vk::PhysicalDeviceType::CPU)
                .or_else(|| devices.first().copied())
                .ok_or("no Vulkan device")?;
            let props = instance.get_physical_device_properties(pd);
            let families = instance.get_physical_device_queue_family_properties(pd);
            let family = families
                .iter()
                .position(|q| q.queue_flags.contains(vk::QueueFlags::COMPUTE))
                .ok_or("no compute queue")? as u32;
            let tick_ns = (families[family as usize].timestamp_valid_bits > 0 && props.limits.timestamp_period > 0.0)
                .then_some(f64::from(props.limits.timestamp_period));
            let host_import = instance
                .enumerate_device_extension_properties(pd)
                .unwrap_or_default()
                .iter()
                .any(|e| {
                    e.extension_name_as_c_str()
                        .is_ok_and(|n| n == c"VK_EXT_external_memory_host")
                });
            let priorities = [1.0f32];
            let queues = [vk::DeviceQueueCreateInfo::default()
                .queue_family_index(family)
                .queue_priorities(&priorities)];
            let device = instance
                .create_device(pd, &vk::DeviceCreateInfo::default().queue_create_infos(&queues), None)
                .map_err(failed("vkCreateDevice"))?;
            let pool = device
                .create_command_pool(
                    &vk::CommandPoolCreateInfo::default()
                        .queue_family_index(family)
                        .flags(vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER),
                    None,
                )
                .map_err(failed("vkCreateCommandPool"))?;
            let fence = device
                .create_fence(&vk::FenceCreateInfo::default(), None)
                .map_err(failed("vkCreateFence"))?;
            let bindings: Vec<_> = (0..BINDINGS)
                .map(|b| {
                    vk::DescriptorSetLayoutBinding::default()
                        .binding(b)
                        .descriptor_type(if b == 0 {
                            vk::DescriptorType::UNIFORM_BUFFER
                        } else {
                            vk::DescriptorType::STORAGE_BUFFER
                        })
                        .descriptor_count(1)
                        .stage_flags(vk::ShaderStageFlags::COMPUTE)
                })
                .collect();
            let set_layout = device
                .create_descriptor_set_layout(&vk::DescriptorSetLayoutCreateInfo::default().bindings(&bindings), None)
                .map_err(failed("vkCreateDescriptorSetLayout"))?;
            let set_layouts = [set_layout];
            let layout = device
                .create_pipeline_layout(&vk::PipelineLayoutCreateInfo::default().set_layouts(&set_layouts), None)
                .map_err(failed("vkCreatePipelineLayout"))?;
            let v = props.api_version;
            let name = props
                .device_name_as_c_str()
                .map_or_default(|s| s.to_string_lossy().into_owned());
            Ok(Self {
                queue: device.get_device_queue(family, 0),
                memory: instance.get_physical_device_memory_properties(pd),
                label: format!(
                    "{name}, Vulkan {}.{}.{}, driver {:#x}",
                    vk::api_version_major(v),
                    vk::api_version_minor(v),
                    vk::api_version_patch(v),
                    props.driver_version
                ),
                _entry: entry,
                instance,
                device,
                pool,
                fence,
                set_layout,
                layout,
                tick_ns,
                host_import,
            })
        }
    }

    /// A memory type with all of `required`, preferring one that also has `preferred`.
    fn memory_type(
        &self,
        bits: u32,
        required: vk::MemoryPropertyFlags,
        preferred: vk::MemoryPropertyFlags,
    ) -> Option<(u32, vk::MemoryPropertyFlags)> {
        let types = &self.memory.memory_types[..self.memory.memory_type_count as usize];
        let fits = |want: vk::MemoryPropertyFlags| {
            types
                .iter()
                .enumerate()
                .find(|(i, t)| bits & (1 << i) != 0 && t.property_flags.contains(want))
                .map(|(i, t)| (i as u32, t.property_flags))
        };
        fits(required | preferred).or_else(|| fits(required))
    }

    unsafe fn submit(&self, cb: vk::CommandBuffer) -> Result<(), String> {
        unsafe {
            let cbs = [cb];
            self.device
                .queue_submit(
                    self.queue,
                    &[vk::SubmitInfo::default().command_buffers(&cbs)],
                    self.fence,
                )
                .map_err(failed("vkQueueSubmit"))?;
            self.device
                .wait_for_fences(&[self.fence], true, u64::MAX)
                .map_err(failed("vkWaitForFences"))?;
            self.device.reset_fences(&[self.fence]).map_err(failed("vkResetFences"))
        }
    }
}

struct Buf {
    buffer: vk::Buffer,
    memory: vk::DeviceMemory,
    size: u64,
    mapped: *mut u8,
}

pub struct VkBench<'s> {
    s: &'s Session,
    plan: Plan,
    strategy: Strategy,
    bufs: Vec<Buf>,
    params: Vec<Buf>,
    staging_in: Option<Buf>,
    staging_out: Option<Buf>,
    modules: Vec<vk::ShaderModule>,
    pipelines: Vec<vk::Pipeline>,
    descriptors: vk::DescriptorPool,
    queries: Option<vk::QueryPool>,
    cbs: Vec<vk::CommandBuffer>,
    cb_up: Option<vk::CommandBuffer>,
    cb_compute: Option<vk::CommandBuffer>,
    cb_down: Option<vk::CommandBuffer>,
    input: Vec<u8>,
    output: Vec<u8>,
    note: Option<String>,
}

impl Drop for VkBench<'_> {
    fn drop(&mut self) {
        unsafe {
            let d = &self.s.device;
            let _ = d.device_wait_idle();
            if !self.cbs.is_empty() {
                d.free_command_buffers(self.s.pool, &self.cbs);
            }
            if let Some(q) = self.queries {
                d.destroy_query_pool(q, None);
            }
            d.destroy_descriptor_pool(self.descriptors, None);
            let mut pipelines = self.pipelines.clone();
            pipelines.sort_by_key(|p| vk::Handle::as_raw(*p));
            pipelines.dedup();
            for p in pipelines {
                d.destroy_pipeline(p, None);
            }
            for &m in &self.modules {
                d.destroy_shader_module(m, None);
            }
            for b in self
                .bufs
                .iter()
                .chain(&self.params)
                .chain(&self.staging_in)
                .chain(&self.staging_out)
            {
                d.destroy_buffer(b.buffer, None);
                d.free_memory(b.memory, None);
            }
        }
    }
}

const STORAGE: vk::BufferUsageFlags = vk::BufferUsageFlags::from_raw(
    vk::BufferUsageFlags::STORAGE_BUFFER.as_raw()
        | vk::BufferUsageFlags::TRANSFER_SRC.as_raw()
        | vk::BufferUsageFlags::TRANSFER_DST.as_raw(),
);

impl<'s> VkBench<'s> {
    pub fn new(s: &'s Session, task: Task, variant: Variant, strategy: Strategy) -> Result<Self, Refusal> {
        if strategy == Strategy::ZeroCopy {
            let why = if s.host_import {
                "zero-copy through VK_EXT_external_memory_host is not written yet"
            } else {
                "the driver has no VK_EXT_external_memory_host"
            };
            return Err((RowStatus::Unsupported, why.into()));
        }
        let plan = shaders::plan(task, variant)?;
        let mut bench = VkBench {
            s,
            input: plan.input.map_or_default(|i| plan.buffers[i].clone()),
            output: vec![0; plan.output_len],
            strategy,
            bufs: Vec::new(),
            params: Vec::new(),
            staging_in: None,
            staging_out: None,
            modules: Vec::new(),
            pipelines: Vec::new(),
            descriptors: vk::DescriptorPool::null(),
            queries: None,
            cbs: Vec::new(),
            cb_up: None,
            cb_compute: None,
            cb_down: None,
            note: None,
            plan,
        };
        unsafe { bench.build() }.map_err(|e| (RowStatus::Failed, e))?;
        Ok(bench)
    }

    unsafe fn buffer(
        &self,
        size: u64,
        usage: vk::BufferUsageFlags,
        required: vk::MemoryPropertyFlags,
        preferred: vk::MemoryPropertyFlags,
    ) -> Result<(Buf, vk::MemoryPropertyFlags), String> {
        unsafe {
            let d = &self.s.device;
            let buffer = d
                .create_buffer(&vk::BufferCreateInfo::default().size(size).usage(usage), None)
                .map_err(failed("vkCreateBuffer"))?;
            let req = d.get_buffer_memory_requirements(buffer);
            let Some((index, flags)) = self.s.memory_type(req.memory_type_bits, required, preferred) else {
                d.destroy_buffer(buffer, None);
                return Err(format!("no memory type with {required:?}"));
            };
            let memory = match d.allocate_memory(
                &vk::MemoryAllocateInfo::default()
                    .allocation_size(req.size)
                    .memory_type_index(index),
                None,
            ) {
                Ok(m) => m,
                Err(e) => {
                    d.destroy_buffer(buffer, None);
                    return Err(format!("vkAllocateMemory({size} bytes): {e}"));
                }
            };
            let buf = Buf {
                buffer,
                memory,
                size,
                mapped: std::ptr::null_mut(),
            };
            d.bind_buffer_memory(buffer, memory, 0)
                .map_err(failed("vkBindBufferMemory"))?;
            let mapped = if flags.contains(vk::MemoryPropertyFlags::HOST_VISIBLE) {
                d.map_memory(memory, 0, vk::WHOLE_SIZE, vk::MemoryMapFlags::empty())
                    .map_err(failed("vkMapMemory"))?
                    .cast()
            } else {
                std::ptr::null_mut()
            };
            Ok((Buf { mapped, ..buf }, flags))
        }
    }

    unsafe fn one_shot(&self, record: impl FnOnce(vk::CommandBuffer)) -> Result<(), String> {
        unsafe {
            let d = &self.s.device;
            let cb = d
                .allocate_command_buffers(
                    &vk::CommandBufferAllocateInfo::default()
                        .command_pool(self.s.pool)
                        .command_buffer_count(1),
                )
                .map_err(failed("vkAllocateCommandBuffers"))?[0];
            let result = (|| {
                d.begin_command_buffer(
                    cb,
                    &vk::CommandBufferBeginInfo::default().flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT),
                )
                .map_err(failed("vkBeginCommandBuffer"))?;
                record(cb);
                d.end_command_buffer(cb).map_err(failed("vkEndCommandBuffer"))?;
                self.s.submit(cb)
            })();
            d.free_command_buffers(self.s.pool, &[cb]);
            result
        }
    }

    /// Contents of `bufs[index]` through a temporary staging buffer - outside any timing.
    unsafe fn read_back(&mut self, index: usize, len: usize) -> Result<Vec<u8>, String> {
        unsafe {
            let src = self.bufs[index].buffer;
            let (staging, _) = self.buffer(
                len.max(4) as u64,
                vk::BufferUsageFlags::TRANSFER_DST,
                vk::MemoryPropertyFlags::HOST_VISIBLE | vk::MemoryPropertyFlags::HOST_COHERENT,
                vk::MemoryPropertyFlags::empty(),
            )?;
            let dst = staging.buffer;
            let copied = self.one_shot(|cb| {
                self.s
                    .device
                    .cmd_copy_buffer(cb, src, dst, &[vk::BufferCopy::default().size(len.max(4) as u64)]);
            });
            let out = copied.map(|()| std::slice::from_raw_parts(staging.mapped, len).to_vec());
            self.s.device.destroy_buffer(staging.buffer, None);
            self.s.device.free_memory(staging.memory, None);
            out
        }
    }

    unsafe fn build(&mut self) -> Result<(), String> {
        unsafe {
            let host = vk::MemoryPropertyFlags::HOST_VISIBLE | vk::MemoryPropertyFlags::HOST_COHERENT;
            let device_local = vk::MemoryPropertyFlags::DEVICE_LOCAL;
            let mut placements = Vec::new();
            for i in 0..self.plan.buffers.len() {
                let size = self.plan.buffers[i].len() as u64;
                let endpoint = Some(i) == self.plan.input || Some(i) == self.plan.output;
                let (buf, flags) = if self.strategy == Strategy::Map && endpoint {
                    let preferred = if Some(i) == self.plan.output {
                        device_local | vk::MemoryPropertyFlags::HOST_CACHED
                    } else {
                        device_local
                    };
                    self.buffer(size, STORAGE, host, preferred)?
                } else {
                    self.buffer(size, STORAGE, device_local, vk::MemoryPropertyFlags::empty())?
                };
                if endpoint {
                    placements.push(format!(
                        "{} {flags:?}",
                        if Some(i) == self.plan.input { "input" } else { "output" }
                    ));
                }
                self.bufs.push(buf);
            }
            // Initial contents through one staging buffer, so device-local memory gets them too.
            for i in 0..self.plan.buffers.len() {
                let data = &self.plan.buffers[i];
                let (staging, _) = self.buffer(
                    data.len() as u64,
                    vk::BufferUsageFlags::TRANSFER_SRC,
                    host,
                    vk::MemoryPropertyFlags::empty(),
                )?;
                std::ptr::copy_nonoverlapping(data.as_ptr(), staging.mapped, data.len());
                let (src, dst, size) = (staging.buffer, self.bufs[i].buffer, data.len() as u64);
                let copied = self.one_shot(|cb| {
                    self.s
                        .device
                        .cmd_copy_buffer(cb, src, dst, &[vk::BufferCopy::default().size(size)]);
                });
                self.s.device.destroy_buffer(staging.buffer, None);
                self.s.device.free_memory(staging.memory, None);
                copied?;
            }
            if self.strategy == Strategy::Copy {
                if let Some(i) = self.plan.input {
                    self.staging_in = Some(
                        self.buffer(
                            self.bufs[i].size,
                            vk::BufferUsageFlags::TRANSFER_SRC,
                            host,
                            vk::MemoryPropertyFlags::empty(),
                        )?
                        .0,
                    );
                }
                if self.plan.output.is_some() {
                    let (buf, flags) = self.buffer(
                        self.plan.output_len.max(4) as u64,
                        vk::BufferUsageFlags::TRANSFER_DST,
                        host,
                        vk::MemoryPropertyFlags::HOST_CACHED,
                    )?;
                    placements.push(format!("download staging {flags:?}"));
                    self.staging_out = Some(buf);
                }
            }
            self.note = (!placements.is_empty()).then(|| format!("memory: {}", placements.join(", ")));

            let d = &self.s.device;
            let launches = self.plan.launches.len() as u32;
            if launches > 0 {
                let sizes = [
                    vk::DescriptorPoolSize::default()
                        .ty(vk::DescriptorType::UNIFORM_BUFFER)
                        .descriptor_count(launches),
                    vk::DescriptorPoolSize::default()
                        .ty(vk::DescriptorType::STORAGE_BUFFER)
                        .descriptor_count(launches * (BINDINGS - 1)),
                ];
                self.descriptors = d
                    .create_descriptor_pool(
                        &vk::DescriptorPoolCreateInfo::default()
                            .max_sets(launches)
                            .pool_sizes(&sizes),
                        None,
                    )
                    .map_err(failed("vkCreateDescriptorPool"))?;
            }
            let mut sets = Vec::new();
            let mut compiled: std::collections::HashMap<String, vk::Pipeline> = std::collections::HashMap::new();
            for l in 0..self.plan.launches.len() {
                let (params, _) = self.buffer(
                    16,
                    vk::BufferUsageFlags::UNIFORM_BUFFER,
                    host,
                    vk::MemoryPropertyFlags::empty(),
                )?;
                std::ptr::copy_nonoverlapping(self.plan.launches[l].params.as_ptr().cast::<u8>(), params.mapped, 16);
                self.params.push(params);
                let d = &self.s.device;
                let source = &self.plan.launches[l].source;
                let pipeline = match compiled.get(source) {
                    Some(&p) => p,
                    None => {
                        let code = shaders::spirv(source)?;
                        let module = d
                            .create_shader_module(&vk::ShaderModuleCreateInfo::default().code(&code), None)
                            .map_err(failed("vkCreateShaderModule"))?;
                        self.modules.push(module);
                        let stage = vk::PipelineShaderStageCreateInfo::default()
                            .stage(vk::ShaderStageFlags::COMPUTE)
                            .module(module)
                            .name(c"main");
                        let p = d
                            .create_compute_pipelines(
                                vk::PipelineCache::null(),
                                &[vk::ComputePipelineCreateInfo::default()
                                    .stage(stage)
                                    .layout(self.s.layout)],
                                None,
                            )
                            .map_err(|(_, e)| format!("vkCreateComputePipelines: {e}"))?[0];
                        compiled.insert(source.clone(), p);
                        p
                    }
                };
                self.pipelines.push(pipeline);
                let layouts = [self.s.set_layout];
                let set = d
                    .allocate_descriptor_sets(
                        &vk::DescriptorSetAllocateInfo::default()
                            .descriptor_pool(self.descriptors)
                            .set_layouts(&layouts),
                    )
                    .map_err(failed("vkAllocateDescriptorSets"))?[0];
                let launch = &self.plan.launches[l];
                let targets = [
                    self.params[l].buffer,
                    self.bufs[launch.src].buffer,
                    self.bufs[launch.dst].buffer,
                    self.bufs[1].buffer,
                    self.bufs[launch.aux].buffer,
                ];
                let infos: Vec<[vk::DescriptorBufferInfo; 1]> = targets
                    .iter()
                    .map(|&b| [vk::DescriptorBufferInfo::default().buffer(b).range(vk::WHOLE_SIZE)])
                    .collect();
                let writes: Vec<_> = (0..BINDINGS)
                    .map(|b| {
                        vk::WriteDescriptorSet::default()
                            .dst_set(set)
                            .dst_binding(b)
                            .descriptor_type(if b == 0 {
                                vk::DescriptorType::UNIFORM_BUFFER
                            } else {
                                vk::DescriptorType::STORAGE_BUFFER
                            })
                            .buffer_info(&infos[b as usize])
                    })
                    .collect();
                d.update_descriptor_sets(&writes, &[]);
                sets.push(set);
            }
            if self.s.tick_ns.is_some() && launches > 0 {
                self.queries = Some(
                    d.create_query_pool(
                        &vk::QueryPoolCreateInfo::default()
                            .query_type(vk::QueryType::TIMESTAMP)
                            .query_count(2),
                        None,
                    )
                    .map_err(failed("vkCreateQueryPool"))?,
                );
            }

            let d = &self.s.device;
            let cbs = d
                .allocate_command_buffers(
                    &vk::CommandBufferAllocateInfo::default()
                        .command_pool(self.s.pool)
                        .command_buffer_count(3),
                )
                .map_err(failed("vkAllocateCommandBuffers"))?;
            self.cbs = cbs.clone();
            // Simultaneous use: a stream submits the same buffers again before the last finished.
            let begin = |cb| {
                d.begin_command_buffer(
                    cb,
                    &vk::CommandBufferBeginInfo::default().flags(vk::CommandBufferUsageFlags::SIMULTANEOUS_USE),
                )
                .map_err(failed("vkBeginCommandBuffer"))
            };
            let barrier = |cb, src_stage, dst_stage, src_access, dst_access| {
                let b = [vk::MemoryBarrier::default()
                    .src_access_mask(src_access)
                    .dst_access_mask(dst_access)];
                d.cmd_pipeline_barrier(cb, src_stage, dst_stage, vk::DependencyFlags::empty(), &b, &[], &[]);
            };
            if let (Some(staging), Some(i)) = (&self.staging_in, self.plan.input) {
                begin(cbs[0])?;
                d.cmd_copy_buffer(
                    cbs[0],
                    staging.buffer,
                    self.bufs[i].buffer,
                    &[vk::BufferCopy::default().size(staging.size)],
                );
                barrier(
                    cbs[0],
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::SHADER_READ,
                );
                d.end_command_buffer(cbs[0]).map_err(failed("vkEndCommandBuffer"))?;
                self.cb_up = Some(cbs[0]);
            }
            if launches > 0 {
                let cb = cbs[1];
                begin(cb)?;
                if let Some(q) = self.queries {
                    d.cmd_reset_query_pool(cb, q, 0, 2);
                    d.cmd_write_timestamp(cb, vk::PipelineStageFlags::TOP_OF_PIPE, q, 0);
                }
                for (l, launch) in self.plan.launches.iter().enumerate() {
                    d.cmd_bind_pipeline(cb, vk::PipelineBindPoint::COMPUTE, self.pipelines[l]);
                    d.cmd_bind_descriptor_sets(cb, vk::PipelineBindPoint::COMPUTE, self.s.layout, 0, &[sets[l]], &[]);
                    d.cmd_dispatch(cb, launch.groups[0], launch.groups[1], launch.groups[2]);
                    barrier(
                        cb,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::COMPUTE_SHADER
                            | vk::PipelineStageFlags::TRANSFER
                            | vk::PipelineStageFlags::HOST,
                        vk::AccessFlags::SHADER_WRITE,
                        vk::AccessFlags::SHADER_READ
                            | vk::AccessFlags::SHADER_WRITE
                            | vk::AccessFlags::TRANSFER_READ
                            | vk::AccessFlags::HOST_READ,
                    );
                }
                if let Some(q) = self.queries {
                    d.cmd_write_timestamp(cb, vk::PipelineStageFlags::BOTTOM_OF_PIPE, q, 1);
                }
                d.end_command_buffer(cb).map_err(failed("vkEndCommandBuffer"))?;
                self.cb_compute = Some(cb);
            }
            if let (Some(staging), Some(o)) = (&self.staging_out, self.plan.output) {
                let cb = cbs[2];
                begin(cb)?;
                d.cmd_copy_buffer(
                    cb,
                    self.bufs[o].buffer,
                    staging.buffer,
                    &[vk::BufferCopy::default().size(staging.size)],
                );
                barrier(
                    cb,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                );
                d.end_command_buffer(cb).map_err(failed("vkEndCommandBuffer"))?;
                self.cb_down = Some(cb);
            }
            Ok(())
        }
    }

    fn gpu_ms(&self) -> Option<f64> {
        let (q, tick) = (self.queries?, self.s.tick_ns?);
        let mut stamps = [0u64; 2];
        unsafe {
            self.s.device.get_query_pool_results(
                q,
                0,
                &mut stamps,
                vk::QueryResultFlags::TYPE_64 | vk::QueryResultFlags::WAIT,
            )
        }
        .ok()?;
        Some(stamps[1].wrapping_sub(stamps[0]) as f64 * tick / 1e6)
    }
}

impl Bench for VkBench<'_> {
    /// Every frame's command buffers submitted without a wait, one fence on the last; the
    /// host copies in and out alongside, as a camera loop would.
    fn stream(&mut self, frames: u32) -> Result<(), String> {
        let (up, down) = self.plan.transfers;
        let order: Vec<vk::CommandBuffer> = [
            self.cb_up.filter(|_| up),
            self.cb_compute,
            self.cb_down.filter(|_| down),
        ]
        .into_iter()
        .flatten()
        .collect();
        for frame in 0..frames {
            unsafe {
                if up && let Some(i) = self.plan.input {
                    let target = self.staging_in.as_ref().map_or(self.bufs[i].mapped, |s| s.mapped);
                    std::ptr::copy_nonoverlapping(self.input.as_ptr(), target, self.input.len());
                }
                let fence = if frame + 1 == frames {
                    self.s.fence
                } else {
                    vk::Fence::null()
                };
                self.s
                    .device
                    .queue_submit(
                        self.s.queue,
                        &[vk::SubmitInfo::default().command_buffers(&order)],
                        fence,
                    )
                    .map_err(failed("vkQueueSubmit"))?;
                if down && let Some(o) = self.plan.output {
                    let source = self.staging_out.as_ref().map_or(self.bufs[o].mapped, |s| s.mapped);
                    std::ptr::copy_nonoverlapping(source.cast_const(), self.output.as_mut_ptr(), self.output.len());
                }
            }
        }
        unsafe {
            self.s
                .device
                .wait_for_fences(&[self.s.fence], true, u64::MAX)
                .map_err(failed("vkWaitForFences"))?;
            self.s
                .device
                .reset_fences(&[self.s.fence])
                .map_err(failed("vkResetFences"))
        }
    }

    fn frame(&mut self) -> Result<FrameTimes, String> {
        let (up, down) = self.plan.transfers;
        let t0 = Instant::now();
        if up && let Some(i) = self.plan.input {
            match (&self.staging_in, self.cb_up) {
                (Some(staging), Some(cb)) => unsafe {
                    std::ptr::copy_nonoverlapping(self.input.as_ptr(), staging.mapped, self.input.len());
                    self.s.submit(cb)?;
                },
                _ => unsafe {
                    std::ptr::copy_nonoverlapping(self.input.as_ptr(), self.bufs[i].mapped, self.input.len());
                },
            }
        }
        let t1 = Instant::now();
        let gpu = if let Some(cb) = self.cb_compute {
            unsafe { self.s.submit(cb)? };
            self.gpu_ms()
        } else {
            None
        };
        let t2 = Instant::now();
        if down && let Some(o) = self.plan.output {
            match (&self.staging_out, self.cb_down) {
                (Some(staging), Some(cb)) => unsafe {
                    self.s.submit(cb)?;
                    std::ptr::copy_nonoverlapping(
                        staging.mapped.cast_const(),
                        self.output.as_mut_ptr(),
                        self.output.len(),
                    );
                },
                _ => unsafe {
                    std::ptr::copy_nonoverlapping(
                        self.bufs[o].mapped.cast_const(),
                        self.output.as_mut_ptr(),
                        self.output.len(),
                    );
                },
            }
        }
        let t3 = Instant::now();
        let ms = |a: Instant, b: Instant| (b - a).as_secs_f64() * 1e3;
        Ok(FrameTimes {
            upload: ms(t0, t1),
            compute: ms(t1, t2),
            download: ms(t2, t3),
            gpu,
        })
    }

    fn output(&mut self) -> Result<Vec<u8>, String> {
        match (self.plan.output, self.plan.input) {
            (Some(o), _) => unsafe { self.read_back(o, self.plan.output_len) },
            (None, Some(i)) => {
                let len = self.input.len();
                unsafe { self.read_back(i, len) }
            }
            (None, None) => Ok(Vec::new()),
        }
    }

    fn note(&self) -> Option<String> {
        self.note.clone()
    }
}
