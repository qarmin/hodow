//! Vulkan compute validation (pure-Rust stack: `ash` + `naga`).
//!
//! Runs a compute shader whose correct output is known analytically (`data[i] = i*3 + 7`)
//! on every Vulkan physical device, reads the buffer back and checks it bit-for-bit. As with
//! the OpenGL validation tests, the expected values come from the operation itself, so a
//! mismatch means the device/driver computed the wrong answer - not that a reference differs.
//!
//! The WGSL kernel is compiled to SPIR-V at runtime with `naga`, avoiding any external
//! shader compiler (and any C dependency).

use std::ffi::c_char;

use ash::vk;
use log::info;

/// Per-device outcome of the compute validation.
#[derive(Debug, Clone)]
pub struct VulkanDeviceResult {
    pub name: String,
    pub api_version: String,
    pub outcome: Result<(), String>,
}

/// Aggregate result: one entry per physical device (empty if none / loader missing).
#[derive(Debug, Clone, Default)]
pub struct VulkanReport {
    pub devices: Vec<VulkanDeviceResult>,
    /// Vulkan is simply not present (no loader / no ICD / no driver). Not a failure.
    pub unavailable: Option<String>,
    /// A genuine failure that should be reported as an error (e.g. our shader compilation).
    pub init_error: Option<String>,
}

const COUNT: usize = 1024;
const LOCAL_SIZE: u32 = 64;

const KERNEL_WGSL: &str = r#"
@group(0) @binding(0) var<storage, read_write> data: array<u32>;

@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) gid: vec3<u32>) {
    let i = gid.x;
    data[i] = i * 3u + 7u;
}
"#;

/// Compile the WGSL compute kernel to SPIR-V words. Pure Rust, no device required.
pub fn compile_kernel_spirv() -> Result<Vec<u32>, String> {
    let module = naga::front::wgsl::parse_str(KERNEL_WGSL).map_err(|e| format!("WGSL parse error: {e}"))?;
    let mut validator = naga::valid::Validator::new(naga::valid::ValidationFlags::all(), naga::valid::Capabilities::empty());
    let info = validator.validate(&module).map_err(|e| format!("WGSL validation error: {e}"))?;

    let mut options = naga::back::spv::Options::default();
    // Target Vulkan 1.1-era SPIR-V (1.3).
    options.lang_version = (1, 3);
    let spirv = naga::back::spv::write_vec(&module, &info, &options, None).map_err(|e| format!("SPIR-V generation error: {e}"))?;
    if spirv.first() != Some(&0x0723_0203) {
        return Err("naga produced invalid SPIR-V (bad magic number)".into());
    }
    Ok(spirv)
}

/// Enumerate Vulkan devices and run the compute validation on each.
pub fn run_compute_validation() -> VulkanReport {
    let spirv = match compile_kernel_spirv() {
        Ok(s) => s,
        Err(e) => {
            return VulkanReport {
                init_error: Some(format!("shader compilation failed: {e}")),
                ..Default::default()
            };
        }
    };
    info!("Vulkan: compiled WGSL kernel to {} SPIR-V words", spirv.len());

    // SAFETY: standard Vulkan loader/instance lifecycle; all handles are destroyed below.
    unsafe {
        let entry = match ash::Entry::load() {
            Ok(e) => e,
            Err(e) => {
                return VulkanReport {
                    unavailable: Some(format!("Vulkan loader not available: {e}")),
                    ..Default::default()
                };
            }
        };

        let app_info = vk::ApplicationInfo::default()
            .application_name(c"hodow")
            .application_version(0)
            .engine_name(c"hodow")
            .api_version(vk::make_api_version(0, 1, 1, 0));
        let instance_info = vk::InstanceCreateInfo::default().application_info(&app_info);

        let instance = match entry.create_instance(&instance_info, None) {
            Ok(i) => i,
            Err(e) => {
                // No ICD / incompatible driver: Vulkan is simply not present here.
                return VulkanReport {
                    unavailable: Some(format!("vkCreateInstance failed: {e}")),
                    ..Default::default()
                };
            }
        };

        let physical_devices = match instance.enumerate_physical_devices() {
            Ok(d) => d,
            Err(e) => {
                instance.destroy_instance(None);
                return VulkanReport {
                    init_error: Some(format!("enumerate_physical_devices failed: {e}")),
                    ..Default::default()
                };
            }
        };

        let mut devices = Vec::new();
        for pd in physical_devices {
            let props = instance.get_physical_device_properties(pd);
            let name = c_str_to_string(&props.device_name);
            let v = props.api_version;
            let api_version = format!("{}.{}.{}", vk::api_version_major(v), vk::api_version_minor(v), vk::api_version_patch(v));
            let outcome = run_on_device(&instance, pd, &spirv);
            devices.push(VulkanDeviceResult { name, api_version, outcome });
        }

        instance.destroy_instance(None);
        VulkanReport {
            devices,
            unavailable: None,
            init_error: None,
        }
    }
}

/// Run the compute kernel on one physical device and validate the output bit-exact.
unsafe fn run_on_device(instance: &ash::Instance, pd: vk::PhysicalDevice, spirv: &[u32]) -> Result<(), String> {
    unsafe {
        // Find a queue family that supports compute.
        let queue_family = instance
            .get_physical_device_queue_family_properties(pd)
            .iter()
            .position(|q| q.queue_flags.contains(vk::QueueFlags::COMPUTE))
            .ok_or_else(|| "no compute-capable queue family".to_string())? as u32;

        let priorities = [1.0f32];
        let queue_info = vk::DeviceQueueCreateInfo::default().queue_family_index(queue_family).queue_priorities(&priorities);
        let queue_infos = [queue_info];
        let device_info = vk::DeviceCreateInfo::default().queue_create_infos(&queue_infos);
        let device = instance.create_device(pd, &device_info, None).map_err(|e| format!("create_device: {e}"))?;

        // Everything below must be cleaned up before returning; use a closure + result.
        let result = (|| -> Result<(), String> {
            let queue = device.get_device_queue(queue_family, 0);
            let buffer_size = (COUNT * std::mem::size_of::<u32>()) as vk::DeviceSize;

            // Storage buffer in host-visible + coherent memory so we can read it back directly.
            let buffer_info = vk::BufferCreateInfo::default()
                .size(buffer_size)
                .usage(vk::BufferUsageFlags::STORAGE_BUFFER)
                .sharing_mode(vk::SharingMode::EXCLUSIVE);
            let buffer = device.create_buffer(&buffer_info, None).map_err(|e| format!("create_buffer: {e}"))?;

            let req = device.get_buffer_memory_requirements(buffer);
            let mem_props = instance.get_physical_device_memory_properties(pd);
            let mem_type = find_memory_type(
                &mem_props,
                req.memory_type_bits,
                vk::MemoryPropertyFlags::HOST_VISIBLE | vk::MemoryPropertyFlags::HOST_COHERENT,
            )
            .ok_or_else(|| "no host-visible coherent memory type".to_string())?;
            let alloc_info = vk::MemoryAllocateInfo::default().allocation_size(req.size).memory_type_index(mem_type);
            let memory = device.allocate_memory(&alloc_info, None).map_err(|e| format!("allocate_memory: {e}"))?;
            device.bind_buffer_memory(buffer, memory, 0).map_err(|e| format!("bind_buffer_memory: {e}"))?;

            // Shader module + descriptor/pipeline layout.
            let sm_info = vk::ShaderModuleCreateInfo::default().code(spirv);
            let shader_module = device.create_shader_module(&sm_info, None).map_err(|e| format!("create_shader_module: {e}"))?;

            let binding = vk::DescriptorSetLayoutBinding::default()
                .binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .descriptor_count(1)
                .stage_flags(vk::ShaderStageFlags::COMPUTE);
            let bindings = [binding];
            let dsl_info = vk::DescriptorSetLayoutCreateInfo::default().bindings(&bindings);
            let dsl = device.create_descriptor_set_layout(&dsl_info, None).map_err(|e| format!("descriptor_set_layout: {e}"))?;
            let set_layouts = [dsl];
            let pl_info = vk::PipelineLayoutCreateInfo::default().set_layouts(&set_layouts);
            let pipeline_layout = device.create_pipeline_layout(&pl_info, None).map_err(|e| format!("pipeline_layout: {e}"))?;

            let stage = vk::PipelineShaderStageCreateInfo::default()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(shader_module)
                .name(c"main");
            let cp_info = vk::ComputePipelineCreateInfo::default().stage(stage).layout(pipeline_layout);
            let pipeline = device
                .create_compute_pipelines(vk::PipelineCache::null(), &[cp_info], None)
                .map_err(|(_, e)| format!("create_compute_pipelines: {e}"))?[0];

            // Descriptor pool + set pointing at the buffer.
            let pool_size = vk::DescriptorPoolSize::default().ty(vk::DescriptorType::STORAGE_BUFFER).descriptor_count(1);
            let pool_sizes = [pool_size];
            let dp_info = vk::DescriptorPoolCreateInfo::default().max_sets(1).pool_sizes(&pool_sizes);
            let descriptor_pool = device.create_descriptor_pool(&dp_info, None).map_err(|e| format!("descriptor_pool: {e}"))?;
            let ds_alloc = vk::DescriptorSetAllocateInfo::default().descriptor_pool(descriptor_pool).set_layouts(&set_layouts);
            let descriptor_set = device.allocate_descriptor_sets(&ds_alloc).map_err(|e| format!("allocate_descriptor_sets: {e}"))?[0];

            let buffer_desc = vk::DescriptorBufferInfo::default().buffer(buffer).offset(0).range(buffer_size);
            let buffer_descs = [buffer_desc];
            let write = vk::WriteDescriptorSet::default()
                .dst_set(descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_descs);
            device.update_descriptor_sets(&[write], &[]);

            // Command buffer: bind + dispatch.
            let cp_info = vk::CommandPoolCreateInfo::default().queue_family_index(queue_family);
            let command_pool = device.create_command_pool(&cp_info, None).map_err(|e| format!("command_pool: {e}"))?;
            let cb_alloc = vk::CommandBufferAllocateInfo::default()
                .command_pool(command_pool)
                .level(vk::CommandBufferLevel::PRIMARY)
                .command_buffer_count(1);
            let command_buffer = device.allocate_command_buffers(&cb_alloc).map_err(|e| format!("allocate_command_buffers: {e}"))?[0];

            let begin = vk::CommandBufferBeginInfo::default().flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT);
            device.begin_command_buffer(command_buffer, &begin).map_err(|e| format!("begin_command_buffer: {e}"))?;
            device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::COMPUTE, pipeline);
            device.cmd_bind_descriptor_sets(command_buffer, vk::PipelineBindPoint::COMPUTE, pipeline_layout, 0, &[descriptor_set], &[]);
            device.cmd_dispatch(command_buffer, COUNT as u32 / LOCAL_SIZE, 1, 1);
            device.end_command_buffer(command_buffer).map_err(|e| format!("end_command_buffer: {e}"))?;

            let cmd_buffers = [command_buffer];
            let submit = vk::SubmitInfo::default().command_buffers(&cmd_buffers);
            device.queue_submit(queue, &[submit], vk::Fence::null()).map_err(|e| format!("queue_submit: {e}"))?;
            device.device_wait_idle().map_err(|e| format!("device_wait_idle: {e}"))?;

            // Read back (host-coherent memory: no explicit invalidate needed).
            let ptr = device
                .map_memory(memory, 0, buffer_size, vk::MemoryMapFlags::empty())
                .map_err(|e| format!("map_memory: {e}"))? as *const u32;
            let out = std::slice::from_raw_parts(ptr, COUNT);
            let mut check = Ok(());
            for (i, &v) in out.iter().enumerate() {
                let expected = (i as u32) * 3 + 7;
                if v != expected {
                    check = Err(format!("output[{i}] = {v}, expected {expected}"));
                    break;
                }
            }
            device.unmap_memory(memory);

            // Cleanup device objects.
            device.destroy_command_pool(command_pool, None);
            device.destroy_descriptor_pool(descriptor_pool, None);
            device.destroy_pipeline(pipeline, None);
            device.destroy_pipeline_layout(pipeline_layout, None);
            device.destroy_descriptor_set_layout(dsl, None);
            device.destroy_shader_module(shader_module, None);
            device.destroy_buffer(buffer, None);
            device.free_memory(memory, None);

            check
        })();

        device.destroy_device(None);
        result
    }
}

fn find_memory_type(props: &vk::PhysicalDeviceMemoryProperties, type_bits: u32, flags: vk::MemoryPropertyFlags) -> Option<u32> {
    (0..props.memory_type_count).find(|&i| (type_bits & (1 << i)) != 0 && props.memory_types[i as usize].property_flags.contains(flags))
}

fn c_str_to_string(raw: &[c_char]) -> String {
    let bytes: Vec<u8> = raw.iter().take_while(|&&c| c != 0).map(|&c| c as u8).collect();
    String::from_utf8_lossy(&bytes).into_owned()
}
