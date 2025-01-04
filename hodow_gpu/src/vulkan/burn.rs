//! The Vulkan half of `hodow burn`: the same ALU round trip the OpenGL kernel runs, so
//! every word of the output must equal its own input.

use std::time::Instant;

use ash::vk;

use super::{c_str_to_string, find_memory_type};
use crate::burn::{ALU_K1, ALU_K1_INV, ALU_K2, ALU_ROUNDS, BurnError, BurnReport, until};

const WORDS: u32 = 1 << 20;
const LOCAL_SIZE: u32 = 64;
const NO_INJECT: u32 = u32::MAX;

fn kernel_wgsl() -> String {
    format!(
        r#"
struct Params {{ count: u32, seed: u32, rounds: u32, inject: u32 }}
@group(0) @binding(0) var<storage, read_write> data: array<u32>;
@group(0) @binding(1) var<storage, read> params: Params;

fn alu(v: u32) -> u32 {{
    var x = v;
    for (var r = 0u; r < params.rounds; r++) {{ x = x * {ALU_K1}u; x = x ^ (x >> 17u); x = x + {ALU_K2}u + r; x = (x << 5u) | (x >> 27u); }}
    for (var r = params.rounds; r > 0u; r--) {{ x = (x >> 5u) | (x << 27u); x = x - ({ALU_K2}u + r - 1u); x = x ^ (x >> 17u); x = x * {ALU_K1_INV}u; }}
    return x;
}}

@compute @workgroup_size({LOCAL_SIZE})
fn main(@builtin(global_invocation_id) gid: vec3<u32>) {{
    let i = gid.x;
    if (i >= params.count) {{ return; }}
    var x = alu(i ^ params.seed);
    if (i == params.inject) {{ x = x ^ 1u; }}
    data[i] = x;
}}
"#
    )
}

fn compile() -> Result<Vec<u32>, BurnError> {
    let fail = |e: String| BurnError::Failed(e);
    let module = naga::front::wgsl::parse_str(&kernel_wgsl()).map_err(|e| fail(format!("WGSL parse error: {e}")))?;
    let mut validator =
        naga::valid::Validator::new(naga::valid::ValidationFlags::all(), naga::valid::Capabilities::empty());
    let info = validator
        .validate(&module)
        .map_err(|e| fail(format!("WGSL validation error: {e}")))?;
    let options = naga::back::spv::Options {
        lang_version: (1, 3),
        ..Default::default()
    };
    naga::back::spv::write_vec(&module, &info, &options, None)
        .map_err(|e| fail(format!("SPIR-V generation error: {e}")))
}

/// Runs the ALU round trip on the first non-CPU device (a CPU one if that is all there is).
pub fn alu(deadline: Instant, inject: bool, beat: &mut dyn FnMut()) -> Result<BurnReport, BurnError> {
    let spirv = compile()?;
    let unsupported = |e: String| BurnError::Unsupported(e);
    unsafe {
        let entry = ash::Entry::load().map_err(|e| unsupported(format!("no Vulkan loader: {e}")))?;
        let app_info = vk::ApplicationInfo::default()
            .application_name(c"hodow burn")
            .api_version(vk::make_api_version(0, 1, 1, 0));
        let instance = entry
            .create_instance(&vk::InstanceCreateInfo::default().application_info(&app_info), None)
            .map_err(|e| unsupported(format!("vkCreateInstance failed: {e}")))?;
        let result = (|| {
            let devices = instance
                .enumerate_physical_devices()
                .map_err(|e| unsupported(format!("no Vulkan devices: {e}")))?;
            let pd = devices
                .iter()
                .copied()
                .find(|&pd| instance.get_physical_device_properties(pd).device_type != vk::PhysicalDeviceType::CPU)
                .or_else(|| devices.first().copied())
                .ok_or_else(|| unsupported("no Vulkan devices".into()))?;
            let name = c_str_to_string(&instance.get_physical_device_properties(pd).device_name);
            let mut report = run_on_device(&instance, pd, &spirv, deadline, inject, beat)?;
            report.detail = format!("{name}, {}", report.detail);
            Ok(report)
        })();
        instance.destroy_instance(None);
        result
    }
}

unsafe fn run_on_device(
    instance: &ash::Instance,
    pd: vk::PhysicalDevice,
    spirv: &[u32],
    deadline: Instant,
    inject: bool,
    beat: &mut dyn FnMut(),
) -> Result<BurnReport, BurnError> {
    let failed = |what: &str, e: vk::Result| BurnError::Failed(format!("{what}: {e}"));
    unsafe {
        let queue_family = instance
            .get_physical_device_queue_family_properties(pd)
            .iter()
            .position(|q| q.queue_flags.contains(vk::QueueFlags::COMPUTE))
            .ok_or_else(|| BurnError::Unsupported("no compute queue".into()))? as u32;
        let priorities = [1.0f32];
        let queue_infos = [vk::DeviceQueueCreateInfo::default()
            .queue_family_index(queue_family)
            .queue_priorities(&priorities)];
        let device = instance
            .create_device(
                pd,
                &vk::DeviceCreateInfo::default().queue_create_infos(&queue_infos),
                None,
            )
            .map_err(|e| failed("vkCreateDevice", e))?;
        let mem_props = instance.get_physical_device_memory_properties(pd);
        let mut objects = Objects::new(&device);
        let result = (|| {
            let queue = device.get_device_queue(queue_family, 0);
            let data = objects.host_buffer(&mem_props, WORDS as u64 * 4)?;
            let params = objects.host_buffer(&mem_props, 16)?;

            let module = device
                .create_shader_module(&vk::ShaderModuleCreateInfo::default().code(spirv), None)
                .map_err(|e| failed("vkCreateShaderModule", e))?;
            objects.modules.push(module);
            let bindings = [0, 1].map(|b| {
                vk::DescriptorSetLayoutBinding::default()
                    .binding(b)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .descriptor_count(1)
                    .stage_flags(vk::ShaderStageFlags::COMPUTE)
            });
            let dsl = device
                .create_descriptor_set_layout(&vk::DescriptorSetLayoutCreateInfo::default().bindings(&bindings), None)
                .map_err(|e| failed("vkCreateDescriptorSetLayout", e))?;
            objects.set_layouts.push(dsl);
            let set_layouts = [dsl];
            let layout = device
                .create_pipeline_layout(&vk::PipelineLayoutCreateInfo::default().set_layouts(&set_layouts), None)
                .map_err(|e| failed("vkCreatePipelineLayout", e))?;
            objects.pipeline_layouts.push(layout);
            let stage = vk::PipelineShaderStageCreateInfo::default()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(module)
                .name(c"main");
            let pipeline = device
                .create_compute_pipelines(
                    vk::PipelineCache::null(),
                    &[vk::ComputePipelineCreateInfo::default().stage(stage).layout(layout)],
                    None,
                )
                .map_err(|(_, e)| failed("vkCreateComputePipelines", e))?[0];
            objects.pipelines.push(pipeline);

            let pool_sizes = [vk::DescriptorPoolSize::default()
                .ty(vk::DescriptorType::STORAGE_BUFFER)
                .descriptor_count(2)];
            let pool = device
                .create_descriptor_pool(
                    &vk::DescriptorPoolCreateInfo::default()
                        .max_sets(1)
                        .pool_sizes(&pool_sizes),
                    None,
                )
                .map_err(|e| failed("vkCreateDescriptorPool", e))?;
            objects.descriptor_pools.push(pool);
            let set = device
                .allocate_descriptor_sets(
                    &vk::DescriptorSetAllocateInfo::default()
                        .descriptor_pool(pool)
                        .set_layouts(&set_layouts),
                )
                .map_err(|e| failed("vkAllocateDescriptorSets", e))?[0];
            let infos = [data, params].map(|b| {
                [vk::DescriptorBufferInfo::default()
                    .buffer(b.buffer)
                    .offset(0)
                    .range(vk::WHOLE_SIZE)]
            });
            let writes = [0, 1].map(|b| {
                vk::WriteDescriptorSet::default()
                    .dst_set(set)
                    .dst_binding(b)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&infos[b as usize])
            });
            device.update_descriptor_sets(&writes, &[]);

            let command_pool = device
                .create_command_pool(
                    &vk::CommandPoolCreateInfo::default().queue_family_index(queue_family),
                    None,
                )
                .map_err(|e| failed("vkCreateCommandPool", e))?;
            objects.command_pools.push(command_pool);
            let cb = device
                .allocate_command_buffers(
                    &vk::CommandBufferAllocateInfo::default()
                        .command_pool(command_pool)
                        .command_buffer_count(1),
                )
                .map_err(|e| failed("vkAllocateCommandBuffers", e))?[0];
            device
                .begin_command_buffer(cb, &vk::CommandBufferBeginInfo::default())
                .map_err(|e| failed("vkBeginCommandBuffer", e))?;
            device.cmd_bind_pipeline(cb, vk::PipelineBindPoint::COMPUTE, pipeline);
            device.cmd_bind_descriptor_sets(cb, vk::PipelineBindPoint::COMPUTE, layout, 0, &[set], &[]);
            device.cmd_dispatch(cb, WORDS / LOCAL_SIZE, 1, 1);
            device
                .end_command_buffer(cb)
                .map_err(|e| failed("vkEndCommandBuffer", e))?;

            let mut report = BurnReport::default();
            let output = std::slice::from_raw_parts(data.mapped as *const u32, WORDS as usize);
            let passes = until(deadline, |pass| {
                let seed = (pass as u32).wrapping_mul(0x2545_F491) ^ 0xA5A5_0000;
                let injected = if inject && pass == 0 { WORDS / 2 } else { NO_INJECT };
                std::ptr::copy_nonoverlapping(
                    [WORDS, seed, ALU_ROUNDS, injected].as_ptr(),
                    params.mapped as *mut u32,
                    4,
                );
                let cbs = [cb];
                device
                    .queue_submit(
                        queue,
                        &[vk::SubmitInfo::default().command_buffers(&cbs)],
                        vk::Fence::null(),
                    )
                    .map_err(|e| failed("vkQueueSubmit", e))?;
                device
                    .queue_wait_idle(queue)
                    .map_err(|e| failed("vkQueueWaitIdle", e))?;
                for (i, &got) in output.iter().enumerate() {
                    report.check_word(
                        || format!("invocation {i}"),
                        i as u32 ^ seed,
                        std::ptr::read_volatile(&got),
                    );
                }
                beat();
                Ok(())
            })?;
            report.passes = passes;
            report.detail = format!("{WORDS} invocations x {} rounds", ALU_ROUNDS * 2);
            Ok(report)
        })();
        drop(objects);
        device.destroy_device(None);
        result
    }
}

#[derive(Clone, Copy)]
struct HostBuffer {
    buffer: vk::Buffer,
    mapped: *mut std::ffi::c_void,
}

/// Everything created on the device, destroyed in reverse dependency order on drop.
struct Objects<'a> {
    device: &'a ash::Device,
    buffers: Vec<(vk::Buffer, vk::DeviceMemory)>,
    modules: Vec<vk::ShaderModule>,
    set_layouts: Vec<vk::DescriptorSetLayout>,
    pipeline_layouts: Vec<vk::PipelineLayout>,
    pipelines: Vec<vk::Pipeline>,
    descriptor_pools: Vec<vk::DescriptorPool>,
    command_pools: Vec<vk::CommandPool>,
}

impl<'a> Objects<'a> {
    fn new(device: &'a ash::Device) -> Self {
        Objects {
            device,
            buffers: Vec::new(),
            modules: Vec::new(),
            set_layouts: Vec::new(),
            pipeline_layouts: Vec::new(),
            pipelines: Vec::new(),
            descriptor_pools: Vec::new(),
            command_pools: Vec::new(),
        }
    }

    unsafe fn host_buffer(
        &mut self,
        props: &vk::PhysicalDeviceMemoryProperties,
        size: u64,
    ) -> Result<HostBuffer, BurnError> {
        let failed = |what: &str, e: vk::Result| BurnError::Failed(format!("{what}: {e}"));
        unsafe {
            let buffer = self
                .device
                .create_buffer(
                    &vk::BufferCreateInfo::default()
                        .size(size)
                        .usage(vk::BufferUsageFlags::STORAGE_BUFFER),
                    None,
                )
                .map_err(|e| failed("vkCreateBuffer", e))?;
            let req = self.device.get_buffer_memory_requirements(buffer);
            let Some(memory_type) = find_memory_type(
                props,
                req.memory_type_bits,
                vk::MemoryPropertyFlags::HOST_VISIBLE | vk::MemoryPropertyFlags::HOST_COHERENT,
            ) else {
                self.device.destroy_buffer(buffer, None);
                return Err(BurnError::Unsupported("no host-visible coherent memory".into()));
            };
            let memory = match self.device.allocate_memory(
                &vk::MemoryAllocateInfo::default()
                    .allocation_size(req.size)
                    .memory_type_index(memory_type),
                None,
            ) {
                Ok(m) => m,
                Err(e) => {
                    self.device.destroy_buffer(buffer, None);
                    return Err(failed("vkAllocateMemory", e));
                }
            };
            self.buffers.push((buffer, memory));
            self.device
                .bind_buffer_memory(buffer, memory, 0)
                .map_err(|e| failed("vkBindBufferMemory", e))?;
            let mapped = self
                .device
                .map_memory(memory, 0, vk::WHOLE_SIZE, vk::MemoryMapFlags::empty())
                .map_err(|e| failed("vkMapMemory", e))?;
            Ok(HostBuffer { buffer, mapped })
        }
    }
}

impl Drop for Objects<'_> {
    fn drop(&mut self) {
        unsafe {
            let d = self.device;
            for &p in &self.command_pools {
                d.destroy_command_pool(p, None);
            }
            for &p in &self.descriptor_pools {
                d.destroy_descriptor_pool(p, None);
            }
            for &p in &self.pipelines {
                d.destroy_pipeline(p, None);
            }
            for &l in &self.pipeline_layouts {
                d.destroy_pipeline_layout(l, None);
            }
            for &l in &self.set_layouts {
                d.destroy_descriptor_set_layout(l, None);
            }
            for &m in &self.modules {
                d.destroy_shader_module(m, None);
            }
            for &(b, m) in &self.buffers {
                d.destroy_buffer(b, None);
                d.free_memory(m, None);
            }
        }
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn kernel_compiles_to_spirv() {
        assert!(super::compile().is_ok());
    }
}
