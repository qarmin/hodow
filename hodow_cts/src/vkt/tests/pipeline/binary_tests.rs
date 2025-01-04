// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineBinaryTests.cpp
//   external/vulkancts/framework/vulkan/vkPipelineBinaryUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only, so the `dedicated` group of upstream's
// `pipeline_binary` is ported without the ray tracing cases and without the graphics pipeline library branches
// (`getPartialPipelineCreateInfo`, four wrappers per test). `PipelineBinaryWrapper` is a small struct over the raw
// commands (vkCreatePipelineBinariesKHR and friends are called through `device.commands()` so that the result code
// is seen as upstream sees it). `GraphicsPipelineWrapper` is replaced by `GraphicsConfig`, which builds the create
// info of a pipeline with default state and hands it to a closure, because the internal cache case needs the create
// info of the pipeline it just made. The log messages of `unique_blob_keys` and `valid_key` are dropped.
//
// The `basic` groups (`graphics_tests`, `pipeline_from_get_data`, `compute_tests`) are the cache tests in their binary mode, in
// `cache_tests`. The creation feedback groups are in `creation_feedback_tests`. Not ported: every ray tracing case.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_binary::{BINARY_BLOB_KEYS, BINARY_COMPUTE, BINARY_GRAPHICS, BINARY_SPEC};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{rect_2d, viewport};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `TestType`, without the ray tracing members.
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    CreateIncomplete,
    NotEnoughSpace,
    DestroyNullBinary,
    CreateWithZeroBinaryCount,
    GraphicsPipelineFromInternalCache,
    GraphicsPipelineWithZeroBinaryCount,
    ComputePipelineFromInternalCache,
    UniqueKeyPairs,
    UniqueBlobKeys,
    ValidKey,
}

/// `BinariesStatus`
#[derive(Clone, Copy, PartialEq, Eq)]
enum BinariesStatus {
    Valid,
    Invalid,
    NotFound,
}

/// `VK_CHECK` over a raw result code.
fn check(result: vk::Result, what: &str) -> Result<(), TestError> {
    if result == vk::Result::SUCCESS {
        Ok(())
    } else {
        Err(TestError::Fail(format!("{what} returned {result:?}")))
    }
}

fn create_binaries_raw(
    device: &Device,
    info: &vk::PipelineBinaryCreateInfoKHR,
    handles: &mut vk::PipelineBinaryHandlesInfoKHR,
) -> vk::Result {
    unsafe { (device.commands().create_pipeline_binaries_khr)(device.handle(), info, std::ptr::null(), handles) }
}

fn destroy_binary_raw(device: &Device, binary: vk::PipelineBinaryKHR) {
    unsafe { (device.commands().destroy_pipeline_binary_khr)(device.handle(), binary, std::ptr::null()) }
}

fn get_binary_data_raw(
    device: &Device,
    binary: vk::PipelineBinaryKHR,
    key: &mut vk::PipelineBinaryKeyKHR,
    size: &mut usize,
    data: *mut c_void,
) -> vk::Result {
    let info = vk::PipelineBinaryDataInfoKHR {
        pipeline_binary: binary,
        ..Default::default()
    };
    unsafe { (device.commands().get_pipeline_binary_data_khr)(device.handle(), &info, key, size, data) }
}

fn key_bytes(key: &vk::PipelineBinaryKeyKHR) -> &[u8] {
    &key.key.0[..(key.key_size as usize).min(key.key.0.len())]
}

/// `vk::PipelineBinaryWrapper`
pub(super) struct PipelineBinaryWrapper<'a> {
    device: &'a Device,
    keys: Vec<vk::PipelineBinaryKeyKHR>,
    binaries: Vec<vk::PipelineBinaryKHR>,
}

impl<'a> PipelineBinaryWrapper<'a> {
    pub(super) fn new(device: &'a Device) -> Self {
        Self {
            device,
            keys: Vec::new(),
            binaries: Vec::new(),
        }
    }

    /// `createPipelineBinariesFromPipeline`
    pub(super) fn create_from_pipeline(&mut self, pipeline: vk::Pipeline) -> vk::Result {
        let info = vk::PipelineBinaryCreateInfoKHR {
            pipeline,
            ..Default::default()
        };
        self.create_from_create_info(&info)
    }

    /// `createPipelineBinariesFromInternalCache`; `pipeline_create_info` is the pointer to the create info of the pipeline.
    fn create_from_internal_cache(&mut self, pipeline_create_info: *const c_void) -> vk::Result {
        let wrapped = vk::PipelineCreateInfoKHR {
            next: pipeline_create_info.cast_mut(),
            ..Default::default()
        };
        let info = vk::PipelineBinaryCreateInfoKHR {
            pipeline_create_info: &wrapped,
            ..Default::default()
        };
        self.create_from_create_info(&info)
    }

    /// `createPipelineBinariesFromCreateInfo`
    fn create_from_create_info(&mut self, create_info: &vk::PipelineBinaryCreateInfoKHR) -> vk::Result {
        // check how many binaries will be created
        let mut handles = vk::PipelineBinaryHandlesInfoKHR::default();
        let result = create_binaries_raw(self.device, create_info, &mut handles);
        if result != vk::Result::SUCCESS {
            return result;
        }

        // create pipeline binary objects
        let count = handles.pipeline_binary_count as usize;
        self.binaries.resize(count, vk::PipelineBinaryKHR::null());
        handles.pipeline_binaries = self.binaries.as_mut_ptr();
        create_binaries_raw(self.device, create_info, &mut handles)
    }

    /// `getPipelineBinaryData`, returning only the blobs (the data infos pointing to them are for the ray tracing cases).
    pub(super) fn get_pipeline_binary_data(&mut self) -> Result<Vec<Vec<u8>>, TestError> {
        let mut blobs = Vec::with_capacity(self.binaries.len());
        self.keys.clear();
        for &binary in &self.binaries {
            // get binary key and data size
            let mut key = vk::PipelineBinaryKeyKHR::default();
            let mut size = 0usize;
            check(
                get_binary_data_raw(self.device, binary, &mut key, &mut size, std::ptr::null_mut()),
                "vkGetPipelineBinaryDataKHR",
            )?;
            if size == 0 {
                return Err(TestError::InternalError("A pipeline binary has no data".to_string()));
            }

            // get binary data
            let mut blob = vec![0u8; size];
            check(
                get_binary_data_raw(self.device, binary, &mut key, &mut size, blob.as_mut_ptr().cast()),
                "vkGetPipelineBinaryDataKHR",
            )?;
            self.keys.push(key);
            blobs.push(blob);
        }
        Ok(blobs)
    }

    /// `deletePipelineBinariesKeepKeys`
    pub(super) fn delete_binaries_keep_keys(&mut self) {
        for &binary in &self.binaries {
            if !binary.is_null() {
                destroy_binary_raw(self.device, binary);
            }
        }
        self.binaries.clear();
    }

    /// `createPipelineBinariesFromBinaryData`: the keys read by `get_pipeline_binary_data` with the blobs it returned.
    pub(super) fn create_from_binary_data(&mut self, blobs: &[Vec<u8>]) -> vk::Result {
        // for graphics pipeline libraries not all pipeline stages have to have binaries
        if self.keys.is_empty() {
            return vk::Result::SUCCESS;
        }

        let data_infos: Vec<vk::PipelineBinaryDataKHR> = blobs
            .iter()
            .map(|blob| vk::PipelineBinaryDataKHR {
                data_size: blob.len(),
                data: blob.as_ptr().cast_mut().cast(),
            })
            .collect();
        let keys_and_data = vk::PipelineBinaryKeysAndDataKHR {
            binary_count: self.keys.len() as u32,
            pipeline_binary_keys: self.keys.as_ptr(),
            pipeline_binary_data: data_infos.as_ptr(),
        };
        let info = vk::PipelineBinaryCreateInfoKHR {
            keys_and_data_info: &keys_and_data,
            ..Default::default()
        };
        self.create_from_create_info(&info)
    }

    /// The raw handles, for `VkPipelineBinaryInfoKHR`.
    pub(super) fn handles(&self) -> &[vk::PipelineBinaryKHR] {
        &self.binaries
    }

    /// `getPipelineKey`; `pipeline_create_info` is the pointer to the create info of the pipeline.
    pub(super) fn get_pipeline_key(
        &self,
        pipeline_create_info: *const c_void,
    ) -> Result<vk::PipelineBinaryKeyKHR, TestError> {
        let wrapped = vk::PipelineCreateInfoKHR {
            next: pipeline_create_info.cast_mut(),
            ..Default::default()
        };
        let mut key = vk::PipelineBinaryKeyKHR::default();
        check(
            unsafe { (self.device.commands().get_pipeline_key_khr)(self.device.handle(), &wrapped, &mut key) },
            "vkGetPipelineKeyKHR",
        )?;
        Ok(key)
    }

    /// `PipelineBinaryTestWrapper::getPipelineBinaryKeyOnly`
    fn get_pipeline_binary_key_only(&mut self) -> Result<(), TestError> {
        self.keys.clear();
        for &binary in &self.binaries {
            let mut key = vk::PipelineBinaryKeyKHR::default();
            let mut size = 0usize;
            check(
                get_binary_data_raw(self.device, binary, &mut key, &mut size, std::ptr::null_mut()),
                "vkGetPipelineBinaryDataKHR",
            )?;
            if size == 0 {
                return Err(TestError::InternalError("A pipeline binary has no data".to_string()));
            }
            self.keys.push(key);
        }
        Ok(())
    }
}

impl Drop for PipelineBinaryWrapper<'_> {
    fn drop(&mut self) {
        for &binary in &self.binaries {
            if !binary.is_null() {
                destroy_binary_raw(self.device, binary);
            }
        }
    }
}

/// What `with_compute_create_info` chains: `VkPipelineCreateFlags2CreateInfo` and `VkPipelineBinaryInfoKHR`.
fn with_compute_create_info<R>(
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
    flags2: Option<vk::PipelineCreateFlags2>,
    binary_info: Option<&[vk::PipelineBinaryKHR]>,
    f: impl FnOnce(&vk::ComputePipelineCreateInfo) -> R,
) -> R {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let mut flags2_info =
        vk::PipelineCreateFlags2CreateInfo::builder().flags(flags2.unwrap_or_else(vk::PipelineCreateFlags2::empty));
    let mut binary_chain = vk::PipelineBinaryInfoKHR::builder().pipeline_binaries(binary_info.unwrap_or(&[]));
    let mut info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(0);
    if flags2.is_some() {
        info = info.push_next(&mut flags2_info);
    }
    if binary_info.is_some() {
        info = info.push_next(&mut binary_chain);
    }
    f(&info)
}

fn create_compute<'a>(
    device: &'a Device,
    info: &vk::ComputePipelineCreateInfo,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[*info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// The state `GraphicsPipelineWrapper` fills in by default, plus what the tests change.
#[derive(Clone)]
struct GraphicsConfig<'a> {
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vert: vk::ShaderModule,
    frag: vk::ShaderModule,
    size: u32,
    topology: vk::PrimitiveTopology,
    /// `disableShaderModules`
    null_modules: bool,
    flags2: Option<vk::PipelineCreateFlags2>,
    binary_info: Option<&'a [vk::PipelineBinaryKHR]>,
    specialization: Option<&'a vk::SpecializationInfo>,
    rasterization: Option<vk::PipelineRasterizationStateCreateInfo>,
    alt_blend: Option<(vk::PipelineColorBlendAttachmentState, vk::LogicOp)>,
}

impl GraphicsConfig<'_> {
    fn new(
        layout: vk::PipelineLayout,
        render_pass: vk::RenderPass,
        vert: vk::ShaderModule,
        frag: vk::ShaderModule,
        size: u32,
    ) -> Self {
        Self {
            layout,
            render_pass,
            vert,
            frag,
            size,
            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            null_modules: false,
            flags2: None,
            binary_info: None,
            specialization: None,
            rasterization: None,
            alt_blend: None,
        }
    }
}

/// Builds the create info of a pipeline with default vertex input, depth, multisample and blend state.
fn with_graphics_create_info<R>(cfg: &GraphicsConfig<'_>, f: impl FnOnce(&vk::GraphicsPipelineCreateInfo) -> R) -> R {
    let module = |module: vk::ShaderModule| {
        if cfg.null_modules {
            vk::ShaderModule::null()
        } else {
            module
        }
    };
    let mut vert_stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::VERTEX)
        .module(module(cfg.vert))
        .name(b"main\0");
    let mut frag_stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::FRAGMENT)
        .module(module(cfg.frag))
        .name(b"main\0");
    if let Some(specialization) = cfg.specialization {
        vert_stage = vert_stage.specialization_info(specialization);
        frag_stage = frag_stage.specialization_info(specialization);
    }
    let stages = [vert_stage.build(), frag_stage.build()];

    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(cfg.topology)
        .primitive_restart_enable(false);
    let viewports = [viewport(0.0, 0.0, cfg.size as f32, cfg.size as f32, 0.0, 1.0)];
    let scissors = [rect_2d(cfg.size, cfg.size)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = cfg.rasterization.unwrap_or_else(|| {
        vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0)
            .build()
    });
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder();
    let default_attachment = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build();
    let (attachment, logic_op) = cfg.alt_blend.unwrap_or((default_attachment, vk::LogicOp::CLEAR));
    let attachments = [attachment];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(logic_op)
        .attachments(&attachments);

    let mut flags2_info =
        vk::PipelineCreateFlags2CreateInfo::builder().flags(cfg.flags2.unwrap_or_else(vk::PipelineCreateFlags2::empty));
    let mut binary_chain = vk::PipelineBinaryInfoKHR::builder().pipeline_binaries(cfg.binary_info.unwrap_or(&[]));
    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .layout(cfg.layout)
        .render_pass(cfg.render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    if cfg.flags2.is_some() {
        info = info.push_next(&mut flags2_info);
    }
    if cfg.binary_info.is_some() {
        info = info.push_next(&mut binary_chain);
    }
    f(&info)
}

fn create_graphics<'a>(
    device: &'a Device,
    info: &vk::GraphicsPipelineCreateInfo,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[*info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn build_graphics<'a>(device: &'a Device, cfg: &GraphicsConfig<'_>) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    with_graphics_create_info(cfg, |info| create_graphics(device, info))
}

fn all_zero(blob: &[u8]) -> bool {
    blob.iter().all(|&byte| byte == 0)
}

/// `BasicComputePipelineTestInstance::iterate`
fn iterate_basic_compute(context: &Context<'_>, ty: TestType) -> TestOutcome {
    let device = context.get_device();

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
    let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
    let pipeline = with_compute_create_info(
        *pipeline_layout,
        *shader_module,
        Some(vk::PipelineCreateFlags2::CAPTURE_DATA_KHR),
        None,
        |info| create_compute(device, info),
    )?;

    match ty {
        TestType::CreateIncomplete => {
            let create_info = vk::PipelineBinaryCreateInfoKHR {
                pipeline: *pipeline,
                ..Default::default()
            };

            // check how many binaries will be created
            let mut handles = vk::PipelineBinaryHandlesInfoKHR::default();
            check(
                create_binaries_raw(device, &create_info, &mut handles),
                "vkCreatePipelineBinariesKHR",
            )?;

            let binary_count = handles.pipeline_binary_count as usize;
            if binary_count < 2 {
                return Ok(TestStatus::pass("Binary count too small"));
            }

            let mut binaries_raw = vec![vk::PipelineBinaryKHR::null(); binary_count];
            handles.pipeline_binaries = binaries_raw.as_mut_ptr();
            handles.pipeline_binary_count = 1;

            // test that vkCreatePipelineBinariesKHR returns VK_INCOMPLETE when pipelineBinaryCount
            // is less than the total count of binaries that might be created
            let result = create_binaries_raw(device, &create_info, &mut handles);
            for &binary in &binaries_raw {
                if !binary.is_null() {
                    destroy_binary_raw(device, binary);
                }
            }
            if result == vk::Result::INCOMPLETE {
                return Ok(TestStatus::pass("Pass"));
            }
        }
        TestType::NotEnoughSpace => {
            let mut binaries = PipelineBinaryWrapper::new(device);
            binaries.create_from_pipeline(*pipeline);
            let Some(&first_binary) = binaries.binaries.first() else {
                return Ok(TestStatus::fail("The pipeline produced no binaries"));
            };

            // get first binary key and data size
            let mut binary_key = vk::PipelineBinaryKeyKHR::default();
            let mut binary_data_size = 0usize;
            check(
                get_binary_data_raw(
                    device,
                    first_binary,
                    &mut binary_key,
                    &mut binary_data_size,
                    std::ptr::null_mut(),
                ),
                "vkGetPipelineBinaryDataKHR",
            )?;
            if binary_data_size <= 1 {
                return Err(TestError::InternalError(
                    "Binary data is too small to be cut".to_string(),
                ));
            }

            // try getting binary data while providing not enough space
            let mut pipeline_data_blob = vec![0u8; binary_data_size];
            binary_data_size -= 1;
            let result = get_binary_data_raw(
                device,
                first_binary,
                &mut binary_key,
                &mut binary_data_size,
                pipeline_data_blob.as_mut_ptr().cast(),
            );

            // check if NOT_ENOUGH_SPACE error was returned and if binaryDataSize has been updated to the correct size
            if result == vk::Result::ERROR_NOT_ENOUGH_SPACE_KHR && binary_data_size == pipeline_data_blob.len() {
                return Ok(TestStatus::pass("Pass"));
            }
        }
        TestType::DestroyNullBinary => {
            let mut binaries = PipelineBinaryWrapper::new(device);
            binaries.create_from_pipeline(*pipeline);

            destroy_binary_raw(device, vk::PipelineBinaryKHR::null());
            return Ok(TestStatus::pass("Pass"));
        }
        TestType::CreateWithZeroBinaryCount => {
            let _test_pipeline = with_compute_create_info(*pipeline_layout, *shader_module, None, Some(&[]), |info| {
                create_compute(device, info)
            })?;
            return Ok(TestStatus::pass("Pass"));
        }
        _ => return Err(TestError::InternalError("Not a basic compute case".to_string())),
    }

    Ok(TestStatus::fail("Fail"))
}

/// `ComputePipelineInternalCacheTestInstance::iterate`
fn iterate_compute_internal_cache(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let mut pipeline_binary_wrapper = PipelineBinaryWrapper::new(device);

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;

    let mut shader_module = Some(create_shader_module(
        device,
        context.get_binary_collection().get("comp")?,
    )?);
    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

    // create compute pipeline
    let module_handle = shader_module
        .as_ref()
        .map_or(vk::ShaderModule::null(), |module| **module);
    let mut pipeline = Some(with_compute_create_info(
        *pipeline_layout,
        module_handle,
        None,
        None,
        |info| create_compute(device, info),
    )?);

    // create pipeline binaries from internal cache
    let mut binaries_status = BinariesStatus::Valid;
    let result = with_compute_create_info(*pipeline_layout, module_handle, None, None, |info| {
        pipeline_binary_wrapper.create_from_internal_cache((info as *const vk::ComputePipelineCreateInfo).cast())
    });
    if result != vk::Result::SUCCESS {
        binaries_status = BinariesStatus::NotFound;
    }

    // check pipeline binary data
    if binaries_status == BinariesStatus::Valid {
        // delete pipeline and shader module
        pipeline = None;
        shader_module = None;

        let pipeline_data_blob = pipeline_binary_wrapper.get_pipeline_binary_data()?;

        // check first blob and make sure that it does not contain only 0
        if pipeline_data_blob.first().is_none_or(|blob| all_zero(blob)) {
            binaries_status = BinariesStatus::Invalid;
        }
    }

    // test pipeline
    let buffer_size = (8 * std::mem::size_of::<u32>()) as vk::DeviceSize;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(
            buffer_size,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    let buffer_descriptor_info = vk::DescriptorBufferInfo {
        buffer: buffer.get(),
        offset: 0,
        range: buffer_size,
    };
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &buffer_descriptor_info,
        )
        .update(device);

    // create pipeline form internal cache or fallback to normal pipeline when binary data is not valid
    let binaries_raw = pipeline_binary_wrapper.binaries.clone();
    if binaries_status == BinariesStatus::Invalid {
        shader_module = Some(create_shader_module(
            device,
            context.get_binary_collection().get("comp")?,
        )?);
    }
    drop(pipeline.take());
    let module_handle = shader_module
        .as_ref()
        .map_or(vk::ShaderModule::null(), |module| **module);
    let binary_info = if binaries_status == BinariesStatus::Valid {
        Some(binaries_raw.as_slice())
    } else {
        None
    };
    let pipeline = with_compute_create_info(*pipeline_layout, module_handle, None, binary_info, |info| {
        create_compute(device, info)
    })?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_dispatch(cmd, 1, 1, 1);
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, buffer.get_allocation())?;
    let buffer_ptr = buffer.get_allocation().get_host_ptr().cast::<u32>();
    for i in 0..8u32 {
        if unsafe { buffer_ptr.add(i as usize).read_unaligned() } != i {
            return Ok(TestStatus::fail("Invalid value in buffer"));
        }
    }

    match binaries_status {
        BinariesStatus::Valid => Ok(TestStatus::pass("Pass")),
        BinariesStatus::Invalid => Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Driver wasn't able to pull out valid binary",
        )),
        BinariesStatus::NotFound => Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Pipeline binary was not found in internal cache",
        )),
    }
}

/// `GraphicsPipelineInternalCacheTestInstance::iterate` for the monolithic construction type
fn iterate_graphics_internal_cache(context: &Context<'_>, ty: TestType) -> TestOutcome {
    const RENDER_SIZE: u32 = 8;
    let device = context.get_device();
    let binary_collection = context.get_binary_collection();

    let render_pass = make_render_pass(device, COLOR_FORMAT)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let vert_module = create_shader_module(device, binary_collection.get("vert")?)?;
    let frag_module = create_shader_module(device, binary_collection.get("frag")?)?;
    let mut pipeline_binary_wrapper = PipelineBinaryWrapper::new(device);

    let mut config = GraphicsConfig::new(*pipeline_layout, *render_pass, *vert_module, *frag_module, RENDER_SIZE);
    config.topology = vk::PrimitiveTopology::TRIANGLE_STRIP;

    // use local scope to delete pipeline
    let mut binaries_status = BinariesStatus::Valid;
    {
        // pipelineBinaryInternalCache is available so create pipeline without VK_PIPELINE_CREATE_2_CAPTURE_DATA_BIT_KHR
        let early_result = with_graphics_create_info(&config, |info| -> Result<Option<TestStatus>, TestError> {
            let _pipeline = create_graphics(device, info)?;

            // reuse code to check 0 binary count
            if ty == TestType::GraphicsPipelineWithZeroBinaryCount {
                let mut zero_config = config.clone();
                zero_config.binary_info = Some(&[]);
                let _test_pipeline = build_graphics(device, &zero_config)?;
                return Ok(Some(TestStatus::pass("Pass")));
            }

            if pipeline_binary_wrapper
                .create_from_internal_cache((info as *const vk::GraphicsPipelineCreateInfo).cast())
                != vk::Result::SUCCESS
            {
                binaries_status = BinariesStatus::NotFound;
            }
            Ok(None)
        })?;
        if let Some(status) = early_result {
            return Ok(status);
        }
    }

    // check pipeline binary data
    if binaries_status == BinariesStatus::Valid && !pipeline_binary_wrapper.binaries.is_empty() {
        let pipeline_data_blob = pipeline_binary_wrapper.get_pipeline_binary_data()?;

        // check first blob and make sure that it does not contain only 0
        if pipeline_data_blob.first().is_some_and(|blob| all_zero(blob)) {
            binaries_status = BinariesStatus::Invalid;
        }
    }

    // test pipeline
    let image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        image_info,
        MemoryRequirement::ANY,
    )?;
    let readback_size = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
    let readback = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(readback_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let image_view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*image_view], RENDER_SIZE, RENDER_SIZE, 1)?;
    let clear_value = vk::ClearValue {
        color: vk::ClearColorValue { float32: [0.0; 4] },
    };

    // create pipeline form internal cache or fallback to normal pipeline when binary data is not valid
    let binaries_raw = pipeline_binary_wrapper.binaries.clone();
    let mut final_config = config.clone();
    if binaries_status == BinariesStatus::Valid {
        final_config.null_modules = true;
        final_config.binary_info = Some(&binaries_raw);
    }
    let pipeline = build_graphics(device, &final_config)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    begin_render_pass(
        device,
        cmd,
        *render_pass,
        *framebuffer,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        clear_value,
    );
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        device.cmd_draw(cmd, 4, 1, 0, 0);
    }
    end_render_pass(device, cmd);
    copy_image_to_buffer(device, cmd, image.get(), readback.get(), RENDER_SIZE, RENDER_SIZE);
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, readback.get_allocation())?;
    let pixels =
        unsafe { std::slice::from_raw_parts(readback.get_allocation().get_host_ptr(), readback_size as usize) };

    // check just few fragments around diagonal
    let expected = [255u8, 0, 255, 0];
    for i in 0..7usize {
        let offset = 4 * (i * i + i);
        if pixels[offset..offset + 4] != expected {
            return Ok(TestStatus::fail("Invalid fragment color"));
        }
    }

    match binaries_status {
        BinariesStatus::Valid => Ok(TestStatus::pass("Pass")),
        BinariesStatus::Invalid => Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Driver wasn't able to pull out valid binary",
        )),
        BinariesStatus::NotFound => Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Pipeline binary was not found in internal cache",
        )),
    }
}

/// `UniqueKayPairsTestInstance::iterate`
fn iterate_unique_key_pairs(context: &Context<'_>) -> TestOutcome {
    const RENDER_SIZE: u32 = 16;
    let device = context.get_device();
    let binary_collection = context.get_binary_collection();

    let render_pass = make_render_pass(device, COLOR_FORMAT)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let vert_module = create_shader_module(device, binary_collection.get("vert")?)?;
    let frag_module = create_shader_module(device, binary_collection.get("frag")?)?;

    let specialization_data: [[f32; 2]; 4] = [[0.1, 0.2], [0.3, 0.4], [0.5, 0.6], [0.7, 0.8]];

    // specialization constants
    let entry_size = std::mem::size_of::<f32>();
    let specialization_map = [
        vk::SpecializationMapEntry {
            constant_id: 0,
            offset: 0,
            size: entry_size,
        },
        vk::SpecializationMapEntry {
            constant_id: 1,
            offset: entry_size as u32,
            size: entry_size,
        },
    ];

    let mut pipelines = Vec::new();
    let mut binaries: Vec<PipelineBinaryWrapper> = Vec::new();
    let mut pipeline_data_blob: Vec<Vec<Vec<u8>>> = Vec::new();

    for i in 0..4usize {
        let data: Vec<u8> = specialization_data[i]
            .iter()
            .flat_map(|value| value.to_ne_bytes())
            .collect();
        let specialization_info = vk::SpecializationInfo::builder()
            .map_entries(&specialization_map)
            .data(&data);

        let mut config = GraphicsConfig::new(*pipeline_layout, *render_pass, *vert_module, *frag_module, RENDER_SIZE);
        config.flags2 = Some(vk::PipelineCreateFlags2::CAPTURE_DATA_KHR);
        config.specialization = Some(&specialization_info);
        pipelines.push(build_graphics(device, &config)?);

        let mut wrapper = PipelineBinaryWrapper::new(device);
        wrapper.create_from_pipeline(*pipelines[i]);

        // read binaries data out of the device
        pipeline_data_blob.push(wrapper.get_pipeline_binary_data()?);
        binaries.push(wrapper);

        for (curr_index, curr_blob) in pipeline_data_blob[i].iter().enumerate() {
            // compare with binaries from previous pipelines
            for p in (0..i).rev() {
                for (prev_index, prev_blob) in pipeline_data_blob[p].iter().enumerate() {
                    // skip if blob has different size
                    if curr_blob.len() != prev_blob.len() {
                        continue;
                    }

                    // if pipeline binary data is the same but the keys are different flag a QualityWarning
                    if curr_blob == prev_blob {
                        let curr_key = &binaries[i].keys[curr_index];
                        let prev_key = &binaries[p].keys[prev_index];

                        if curr_key.key_size != prev_key.key_size {
                            continue;
                        }

                        if key_bytes(curr_key) != key_bytes(prev_key) {
                            return Ok(TestStatus::new(
                                TestResult::QualityWarning,
                                "Multiple keys generated for identical binaries",
                            ));
                        }
                    }
                }
            }
        }
    }

    // there is no duplicated pipeline binary data
    Ok(TestStatus::pass("Pass"))
}

/// `UniqueBlobKeysTestInstance::iterate`
fn iterate_unique_blob_keys(context: &Context<'_>) -> TestOutcome {
    const RENDER_SIZE: u32 = 16;
    let device = context.get_device();
    let binary_collection = context.get_binary_collection();

    let render_pass = make_render_pass(device, COLOR_FORMAT)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let vert1_shader = create_shader_module(device, binary_collection.get("vert1")?)?;
    let vert2_shader = create_shader_module(device, binary_collection.get("vert2")?)?;
    let frag1_shader = create_shader_module(device, binary_collection.get("frag1")?)?;
    let frag2_shader = create_shader_module(device, binary_collection.get("frag2")?)?;
    let frag3_shader = create_shader_module(device, binary_collection.get("frag3")?)?;

    let alternative_rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::BACK)
        .front_face(vk::FrontFace::CLOCKWISE)
        .depth_bias_enable(false)
        .depth_bias_constant_factor(0.0)
        .depth_bias_clamp(0.0)
        .depth_bias_slope_factor(0.0)
        .line_width(1.0)
        .build();
    let alternative_blend_attachment = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(true)
        .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
        .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ONE)
        .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
        .alpha_blend_op(vk::BlendOp::SUBTRACT)
        .color_write_mask(vk::ColorComponentFlags::R | vk::ColorComponentFlags::G | vk::ColorComponentFlags::B)
        .build();

    let vert_shaders = [*vert1_shader, *vert1_shader, *vert1_shader, *vert2_shader];
    let frag_shaders = [*frag1_shader, *frag1_shader, *frag2_shader, *frag3_shader];

    let mut pipelines = Vec::new();
    let mut binaries: Vec<PipelineBinaryWrapper> = Vec::new();
    let mut pipeline_data_blob: Vec<Vec<Vec<u8>>> = Vec::new();

    for i in 0..4usize {
        let use_alternative_state = i == 1 || i == 3;

        let mut config = GraphicsConfig::new(
            *pipeline_layout,
            *render_pass,
            vert_shaders[i],
            frag_shaders[i],
            RENDER_SIZE,
        );
        config.flags2 = Some(vk::PipelineCreateFlags2::CAPTURE_DATA_KHR);
        if use_alternative_state {
            config.rasterization = Some(alternative_rasterization_state);
            config.alt_blend = Some((alternative_blend_attachment, vk::LogicOp::CLEAR));
        }
        pipelines.push(build_graphics(device, &config)?);

        let mut wrapper = PipelineBinaryWrapper::new(device);
        check(
            wrapper.create_from_pipeline(*pipelines[i]),
            "vkCreatePipelineBinariesKHR",
        )?;
        pipeline_data_blob.push(wrapper.get_pipeline_binary_data()?);
        binaries.push(wrapper);
    }

    let mut test_ok = true;
    for i in 0..4usize {
        for j in i..4usize {
            for a in 0..pipeline_data_blob[i].len() {
                let b_start = if i == j { a + 1 } else { 0 };
                for b in b_start..pipeline_data_blob[j].len() {
                    let key_a = &binaries[i].keys[a];
                    let key_b = &binaries[j].keys[b];
                    let data_a = &pipeline_data_blob[i][a];
                    let data_b = &pipeline_data_blob[j][b];

                    if key_a.key_size != key_b.key_size || key_bytes(key_a) != key_bytes(key_b) {
                        continue;
                    }

                    if data_a == data_b {
                        continue;
                    }

                    test_ok = false;
                }
            }
        }
    }

    if !test_ok {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `PipelineBinaryKeyTestInstance::iterate` for the monolithic construction type
fn iterate_valid_key(context: &Context<'_>) -> TestOutcome {
    const RENDER_SIZE: u32 = 16;
    let device = context.get_device();
    let binary_collection = context.get_binary_collection();

    let render_pass = make_render_pass(device, COLOR_FORMAT)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let vert_module = create_shader_module(device, binary_collection.get("vert")?)?;
    let frag_module = create_shader_module(device, binary_collection.get("frag")?)?;

    let mut config = GraphicsConfig::new(*pipeline_layout, *render_pass, *vert_module, *frag_module, RENDER_SIZE);
    config.flags2 = Some(vk::PipelineCreateFlags2::CAPTURE_DATA_KHR);
    let pipeline = build_graphics(device, &config)?;

    let mut test_binaries = PipelineBinaryWrapper::new(device);
    test_binaries.create_from_pipeline(*pipeline);
    // read key
    test_binaries.get_pipeline_binary_key_only()?;

    let mut test_ok = true;
    for key in &test_binaries.keys {
        if key.key_size == 0 || key.key_size as usize > vk::MAX_PIPELINE_BINARY_KEY_SIZE_KHR {
            test_ok = false;
            break;
        }
    }

    if !test_ok {
        return Err(TestError::Fail("Failed".to_string()));
    }

    Ok(TestStatus::pass("Passed"))
}

/// `BaseTestCase`
struct BinaryCase {
    name: &'static str,
    ty: TestType,
}

impl TestCase for BinaryCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `BaseTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_pipeline_binary")?;

        if matches!(
            self.ty,
            TestType::GraphicsPipelineFromInternalCache | TestType::ComputePipelineFromInternalCache
        ) {
            let mut binary_properties = vk::PhysicalDevicePipelineBinaryPropertiesKHR::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut binary_properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }
            if binary_properties.pipeline_binary_internal_cache == vk::FALSE {
                return Err(TestError::NotSupported(
                    "pipelineBinaryInternalCache property not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    /// `BaseTestCase::initPrograms`
    fn programs(&self) -> BinaryCollection {
        match self.ty {
            TestType::GraphicsPipelineFromInternalCache | TestType::GraphicsPipelineWithZeroBinaryCount => {
                BINARY_GRAPHICS.programs
            }
            TestType::CreateIncomplete
            | TestType::NotEnoughSpace
            | TestType::DestroyNullBinary
            | TestType::CreateWithZeroBinaryCount
            | TestType::ComputePipelineFromInternalCache => BINARY_COMPUTE.programs,
            TestType::UniqueKeyPairs | TestType::ValidKey => BINARY_SPEC.programs,
            TestType::UniqueBlobKeys => BINARY_BLOB_KEYS.programs,
        }
    }

    /// `BaseTestCase::createInstance`
    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BinaryInstance { context, ty: self.ty })
    }
}

struct BinaryInstance<'a> {
    context: &'a Context<'a>,
    ty: TestType,
}

impl TestInstance for BinaryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.ty {
            TestType::CreateIncomplete
            | TestType::NotEnoughSpace
            | TestType::DestroyNullBinary
            | TestType::CreateWithZeroBinaryCount => iterate_basic_compute(self.context, self.ty),
            TestType::GraphicsPipelineFromInternalCache | TestType::GraphicsPipelineWithZeroBinaryCount => {
                iterate_graphics_internal_cache(self.context, self.ty)
            }
            TestType::ComputePipelineFromInternalCache => iterate_compute_internal_cache(self.context),
            TestType::ValidKey => iterate_valid_key(self.context),
            TestType::UniqueBlobKeys => iterate_unique_blob_keys(self.context),
            TestType::UniqueKeyPairs => iterate_unique_key_pairs(self.context),
        }
    }
}

/// `addPipelineBinaryDedicatedTests` for the monolithic construction type, inside upstream's `pipeline_binary` group.
pub fn create_pipeline_binary_tests() -> TestCaseGroup {
    let mut binary_group = TestCaseGroup::new("pipeline_binary");
    super::cache_tests::add_pipeline_binary_basic_tests(&mut binary_group);
    super::creation_feedback_tests::add_pipeline_binary_creation_feedback_tests(&mut binary_group);
    let mut dedicated_tests = TestCaseGroup::new("dedicated");

    let cases = [
        ("unique_key_pairs", TestType::UniqueKeyPairs),
        ("unique_blob_keys", TestType::UniqueBlobKeys),
        (
            "graphics_pipeline_from_internal_cache",
            TestType::GraphicsPipelineFromInternalCache,
        ),
        ("valid_key", TestType::ValidKey),
        ("create_incomplete", TestType::CreateIncomplete),
        ("not_enough_space", TestType::NotEnoughSpace),
        ("destroy_null_binary", TestType::DestroyNullBinary),
        (
            "compute_pipeline_with_zero_binary_count",
            TestType::CreateWithZeroBinaryCount,
        ),
        (
            "compute_pipeline_from_internal_cache",
            TestType::ComputePipelineFromInternalCache,
        ),
        (
            "graphics_pipeline_with_zero_binary_count",
            TestType::GraphicsPipelineWithZeroBinaryCount,
        ),
    ];
    for (name, ty) in cases {
        dedicated_tests.add_child(Box::new(BinaryCase { name, ty }) as Box<dyn TestCase>);
    }

    binary_group.add_child(dedicated_tests);
    binary_group
}
