// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmComputeShaderCase.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The compute shader is SPIR-V assembly that `compile_shaders.py` assembles with
// spirv-as (the program named `compute` of the case's manifest entry). Only what the ported groups use is here: storage buffers as the
// inputs and outputs, an entry point name, the required extensions and a Vulkan version from the SPIR-V version, an exact comparison of
// the outputs or a function, and a check of the SPIR-V binary. Images and samplers as inputs, spec constants, push constants,
// physical storage buffers and the requested feature list are not. The pass runs on the universal queue of the default device, where
// upstream's `MultiQueueRunnerTestInstance` runs it on every compute queue.

use std::ffi::CString;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::tcu::{IVec2, TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
};
use crate::vk::programs::{BinaryCollection, ProgramBinary, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// `VerifyIOFunc`
pub type VerifyIo = fn(inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected_outputs: &[Vec<u8>]) -> bool;

/// The device features of `VulkanFeatures` that the ported groups request.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum RequiredFeature {
    ShaderFloat64,
    ShaderInt64,
    ShaderInt16,
    StorageBuffer16BitAccess,
    ShaderFloat16,
    ShaderInt8,
    UniformAndStorageBuffer8BitAccess,
    StorageBuffer8BitAccess,
    UniformAndStorageBuffer16BitAccess,
    StoragePushConstant16,
    StoragePushConstant8,
    LongVector,
    IntegerDotProduct,
    BFloat16DotProduct,
    BFloat16Type,
    ShaderSubgroupClock,
    ShaderDeviceClock,
    RobustBufferAccess,
    ShaderUntypedPointers,
    WorkgroupMemoryExplicitLayout,
    WorkgroupMemoryExplicitLayout8BitAccess,
    WorkgroupMemoryExplicitLayout16BitAccess,
    ShaderBufferFloat16Atomics,
    ShaderBufferFloat32Atomics,
    ShaderBufferFloat64Atomics,
    ShaderBufferInt64Atomics,
    ShaderBufferFloat16AtomicAdd,
    ShaderBufferFloat32AtomicAdd,
    ShaderBufferFloat64AtomicAdd,
    ShaderBufferFloat16AtomicMinMax,
    ShaderBufferFloat32AtomicMinMax,
    ShaderBufferFloat64AtomicMinMax,
    ShaderStorageBufferArrayDynamicIndexing,
}

/// What an input `Resource` is bound as: a buffer (`VK_DESCRIPTOR_TYPE_STORAGE_BUFFER`, or uniform with `uniform_inputs`) or an 8x8 image
/// uploaded from the input's bytes in `ComputeShaderSpec::input_format`; a `Sampler` has no data.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum InputKind {
    Buffer,
    StorageImage,
    SampledImage,
    CombinedImageSampler,
    Sampler,
}

/// `ComputeShaderSpec`
#[derive(Clone)]
pub struct ComputeShaderSpec {
    pub inputs: Vec<Vec<u8>>,
    pub outputs: Vec<Vec<u8>>,
    pub num_work_groups: [u32; 3],
    pub entry_point: String,
    pub extensions: Vec<String>,
    /// `spirvVersion` above 1.0: the Vulkan 1.1 that SPIR-V 1.3 needs.
    pub spirv_1_3: bool,
    /// `spirvVersion` 1.5: the Vulkan 1.2 that SPIR-V 1.5 needs.
    pub spirv_1_5: bool,
    /// The SPIR-V minor version the binary must carry: needs a Vulkan that allows it, and the header is checked.
    pub spirv_version_minor: Option<u32>,
    pub verify_io: Option<VerifyIo>,
    pub verify_binary: Option<fn(&ProgramBinary) -> bool>,
    pub fail_message: &'static str,
    pub fail_result: TestResult,
    pub shader_int64: bool,
    pub features: Vec<RequiredFeature>,
    pub uniform_inputs: bool,
    /// Bindings below the first buffer that nothing binds, for a shader whose first buffer is at binding 1 or higher.
    pub leading_unused_bindings: u32,
    /// `numArrayInputs`: the last this many inputs are the elements of one array, bound at the binding after the inputs before them; every buffer after the array follows at the next binding.
    pub array_count: u32,
    /// The minimum the compute work group count, size and invocations limits must offer along x.
    pub min_x_limit: u32,
    pub push_constants: Vec<u8>,
    /// The data of each specialization constant, constant id 0 first.
    pub spec_constants: Vec<Vec<u8>>,
    /// What the output buffers hold before the dispatch, where it is not the 0xff fill.
    pub output_initial: Vec<Vec<u8>>,
    /// Which bytes of each output are compared, 0xff for compared, where not every byte is.
    pub output_masks: Vec<Vec<u8>>,
    pub maintenance8: bool,
    /// `requestedVulkanFeatures.extFma`: the width (16, 32 or 64) whose `shaderFmaFloat*` of `VK_KHR_shader_fma` the case needs, 0 for none.
    pub fma_float_bits: u32,
    /// A float controls property of the given width, by the name of its execution mode.
    pub float_controls_property: Option<(u32, &'static str)>,
    /// More float controls properties of the given width, by the name of their execution mode, that the device must have.
    pub extra_float_controls_properties: Vec<(u32, &'static str)>,
    /// `shaderFloatControls2` of `VkPhysicalDeviceShaderFloatControls2FeaturesKHR`.
    pub float_controls2: bool,
    pub variable_pointers_storage_buffer: bool,
    pub variable_pointers: bool,
    pub vulkan_memory_model: bool,
    pub signed_zero_inf_nan_preserve_float32: bool,
    pub denorm_preserve_float32: bool,
    pub denorm_flush_to_zero_float32: bool,
    /// `usesPhysStorageBuffer`: every buffer is created with a device address and the shader gets them through one buffer at binding 0.
    pub uses_phys_storage_buffer: bool,
    /// `uses64BitIndexing`: the pipeline is created with `VK_PIPELINE_CREATE_2_64_BIT_INDEXING_BIT_EXT`.
    pub uses_64bit_indexing: bool,
    /// The kind of each input, where an input is not a buffer; empty or shorter than `inputs` means buffers.
    pub input_kinds: Vec<InputKind>,
    /// `inputFormat`: the format of the 8x8 images made from the image inputs.
    pub input_format: vk::Format,
    /// The output buffers take the first bindings and the inputs follow, for a shader whose read-write buffer is at binding 0 and whose read-only one is at 1.
    pub output_first: bool,
    /// One dispatch per entry in one command buffer, with the entry as the push constants of it, in place of `push_constants` and a single dispatch.
    pub push_constant_sequence: Vec<Vec<u8>>,
    /// One dispatch per entry point named here, in this order, each from a pipeline of its own over the same module, in place of `entry_point` and a single dispatch.
    pub entry_point_sequence: Vec<String>,
    /// The graphics runner's `inputColors` and `outputColors`: the colour of each of the four corner triangles and the colour the corner pixel must have, where they are not the default colours.
    pub graphics_colors: Option<([[u8; 4]; 4], [[u8; 4]; 4])>,
    /// `isSpirVersionsAsRequested` for a graphics case: every program of the case must carry the SPIR-V version `spirv_version_minor` names.
    pub check_graphics_versions: bool,
    /// `splitRenderArea` of the graphics runner: 16 scissored 64x64 passes in place of one 256x256 pass.
    pub split_render_area: bool,
}

impl Default for ComputeShaderSpec {
    fn default() -> Self {
        Self {
            inputs: Vec::new(),
            outputs: Vec::new(),
            num_work_groups: [1, 1, 1],
            entry_point: "main".to_string(),
            extensions: Vec::new(),
            spirv_1_3: false,
            spirv_1_5: false,
            spirv_version_minor: None,
            verify_io: None,
            verify_binary: None,
            fail_message: "Output does not match with expected results",
            fail_result: TestResult::Fail,
            shader_int64: false,
            features: Vec::new(),
            uniform_inputs: false,
            leading_unused_bindings: 0,
            array_count: 0,
            min_x_limit: 0,
            push_constants: Vec::new(),
            spec_constants: Vec::new(),
            output_initial: Vec::new(),
            output_masks: Vec::new(),
            maintenance8: false,
            fma_float_bits: 0,
            float_controls_property: None,
            extra_float_controls_properties: Vec::new(),
            float_controls2: false,
            variable_pointers_storage_buffer: false,
            variable_pointers: false,
            vulkan_memory_model: false,
            signed_zero_inf_nan_preserve_float32: false,
            denorm_preserve_float32: false,
            denorm_flush_to_zero_float32: false,
            uses_phys_storage_buffer: false,
            uses_64bit_indexing: false,
            input_kinds: Vec::new(),
            input_format: vk::Format::R32G32B32A32_SFLOAT,
            output_first: false,
            push_constant_sequence: Vec::new(),
            entry_point_sequence: Vec::new(),
            graphics_colors: None,
            check_graphics_versions: false,
            split_render_area: false,
        }
    }
}

/// `SpvAsmComputeShaderCase`
pub struct SpvAsmComputeShaderCase {
    pub name: String,
    pub spec: ComputeShaderSpec,
    pub programs: BinaryCollection,
}

impl TestCase for SpvAsmComputeShaderCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `SpvAsmComputeShaderCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.spec.spirv_1_3 && context.api_version() < (1, 1, 0) {
            return Err(TestError::NotSupported(
                "Vulkan higher than or equal to 1.1.0 is required for this test to run".to_string(),
            ));
        }

        if self.spec.spirv_1_5 && context.api_version() < (1, 2, 0) {
            return Err(TestError::NotSupported(
                "Vulkan higher than or equal to 1.2.0 is required for this test to run".to_string(),
            ));
        }

        if let Some(minor) = self.spec.spirv_version_minor {
            let max_minor = match context.api_version() {
                (1, 0, _) => 0,
                (1, 1, _) => 3,
                (1, 2, _) => 5,
                _ => 6,
            };
            if minor > max_minor {
                return Err(TestError::NotSupported(
                    "Specified SPIR-V version is not supported by the device/instance".to_string(),
                ));
            }
        }

        for extension in &self.spec.extensions {
            context.require_device_functionality(extension)?;
        }

        if self.spec.min_x_limit > 0 {
            let limits = &context.get_device_properties().limits;
            if limits.max_compute_work_group_count[0] < self.spec.min_x_limit {
                return Err(TestError::NotSupported(format!(
                    "Minimum of {} required for maxComputeWorkGroupCount.x",
                    self.spec.min_x_limit
                )));
            }
            if limits.max_compute_work_group_size[0] < self.spec.min_x_limit {
                return Err(TestError::NotSupported(format!(
                    "Minimum of {} required for maxComputeWorkGroupSize.x",
                    self.spec.min_x_limit
                )));
            }
            if limits.max_compute_work_group_invocations < self.spec.min_x_limit {
                return Err(TestError::NotSupported(format!(
                    "Minimum of {} required for maxComputeWorkGroupInvocations",
                    self.spec.min_x_limit
                )));
            }
        }

        if self.spec.shader_int64 && context.get_device_features().shader_int64 == vk::FALSE {
            return Err(TestError::NotSupported("shaderInt64 not supported".to_string()));
        }

        if !self.spec.features.is_empty() {
            let mut vulkan11 = vk::PhysicalDeviceVulkan11Features::default();
            let mut vulkan12 = vk::PhysicalDeviceVulkan12Features::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut vulkan11)
                .push_next(&mut vulkan12);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            let core = features2.features;
            let mut long_vector = vk::PhysicalDeviceShaderLongVectorFeaturesEXT::default();
            if self.spec.features.contains(&RequiredFeature::LongVector) {
                let mut long_vector_features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut long_vector);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut long_vector_features2)
                };
            }
            let mut dot_product = vk::PhysicalDeviceShaderIntegerDotProductFeatures::default();
            if self.spec.features.contains(&RequiredFeature::IntegerDotProduct) {
                let mut dot_product_features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut dot_product);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut dot_product_features2)
                };
            }
            let mut bfloat16 = vk::PhysicalDeviceShaderBfloat16FeaturesKHR::default();
            if self.spec.features.contains(&RequiredFeature::BFloat16DotProduct)
                || self.spec.features.contains(&RequiredFeature::BFloat16Type)
            {
                let mut bfloat16_features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut bfloat16);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut bfloat16_features2)
                };
            }
            let mut shader_clock = vk::PhysicalDeviceShaderClockFeaturesKHR::default();
            if self.spec.features.contains(&RequiredFeature::ShaderSubgroupClock)
                || self.spec.features.contains(&RequiredFeature::ShaderDeviceClock)
            {
                let mut shader_clock_features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut shader_clock);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut shader_clock_features2)
                };
            }
            let mut untyped_pointers = vk::PhysicalDeviceShaderUntypedPointersFeaturesKHR::default();
            if self.spec.features.contains(&RequiredFeature::ShaderUntypedPointers) {
                let mut untyped_features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut untyped_pointers);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut untyped_features2)
                };
            }
            let mut explicit_layout = vk::PhysicalDeviceWorkgroupMemoryExplicitLayoutFeaturesKHR::default();
            if self.spec.features.iter().any(|feature| {
                matches!(
                    feature,
                    RequiredFeature::WorkgroupMemoryExplicitLayout
                        | RequiredFeature::WorkgroupMemoryExplicitLayout8BitAccess
                        | RequiredFeature::WorkgroupMemoryExplicitLayout16BitAccess
                )
            }) {
                let mut layout_features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut explicit_layout);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut layout_features2)
                };
            }
            let mut atomic_float = vk::PhysicalDeviceShaderAtomicFloatFeaturesEXT::default();
            let mut atomic_float2 = vk::PhysicalDeviceShaderAtomicFloat2FeaturesEXT::default();
            if self.spec.features.iter().any(|feature| {
                matches!(
                    feature,
                    RequiredFeature::ShaderBufferFloat16Atomics
                        | RequiredFeature::ShaderBufferFloat32Atomics
                        | RequiredFeature::ShaderBufferFloat64Atomics
                        | RequiredFeature::ShaderBufferFloat16AtomicAdd
                        | RequiredFeature::ShaderBufferFloat32AtomicAdd
                        | RequiredFeature::ShaderBufferFloat64AtomicAdd
                        | RequiredFeature::ShaderBufferFloat16AtomicMinMax
                        | RequiredFeature::ShaderBufferFloat32AtomicMinMax
                        | RequiredFeature::ShaderBufferFloat64AtomicMinMax
                )
            }) {
                let mut atomic_features2 = vk::PhysicalDeviceFeatures2::builder()
                    .push_next(&mut atomic_float)
                    .push_next(&mut atomic_float2);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut atomic_features2)
                };
            }
            for feature in &self.spec.features {
                let (supported, name) = match feature {
                    RequiredFeature::ShaderStorageBufferArrayDynamicIndexing => (
                        core.shader_storage_buffer_array_dynamic_indexing,
                        "shaderStorageBufferArrayDynamicIndexing",
                    ),
                    RequiredFeature::ShaderBufferFloat16Atomics => (
                        atomic_float2.shader_buffer_float16_atomics,
                        "shaderBufferFloat16Atomics",
                    ),
                    RequiredFeature::ShaderBufferFloat32Atomics => {
                        (atomic_float.shader_buffer_float32_atomics, "shaderBufferFloat32Atomics")
                    }
                    RequiredFeature::ShaderBufferFloat64Atomics => {
                        (atomic_float.shader_buffer_float64_atomics, "shaderBufferFloat64Atomics")
                    }
                    RequiredFeature::ShaderBufferFloat16AtomicAdd => (
                        atomic_float2.shader_buffer_float16_atomic_add,
                        "shaderBufferFloat16AtomicAdd",
                    ),
                    RequiredFeature::ShaderBufferFloat32AtomicAdd => (
                        atomic_float.shader_buffer_float32_atomic_add,
                        "shaderBufferFloat32AtomicAdd",
                    ),
                    RequiredFeature::ShaderBufferFloat64AtomicAdd => (
                        atomic_float.shader_buffer_float64_atomic_add,
                        "shaderBufferFloat64AtomicAdd",
                    ),
                    RequiredFeature::ShaderBufferFloat16AtomicMinMax => (
                        atomic_float2.shader_buffer_float16_atomic_min_max,
                        "shaderBufferFloat16AtomicMinMax",
                    ),
                    RequiredFeature::ShaderBufferFloat32AtomicMinMax => (
                        atomic_float2.shader_buffer_float32_atomic_min_max,
                        "shaderBufferFloat32AtomicMinMax",
                    ),
                    RequiredFeature::ShaderBufferFloat64AtomicMinMax => (
                        atomic_float2.shader_buffer_float64_atomic_min_max,
                        "shaderBufferFloat64AtomicMinMax",
                    ),
                    RequiredFeature::ShaderBufferInt64Atomics => {
                        (vulkan12.shader_buffer_int64_atomics, "shaderBufferInt64Atomics")
                    }
                    RequiredFeature::ShaderUntypedPointers => {
                        (untyped_pointers.shader_untyped_pointers, "shaderUntypedPointers")
                    }
                    RequiredFeature::WorkgroupMemoryExplicitLayout => (
                        explicit_layout.workgroup_memory_explicit_layout,
                        "workgroupMemoryExplicitLayout",
                    ),
                    RequiredFeature::WorkgroupMemoryExplicitLayout8BitAccess => (
                        explicit_layout.workgroup_memory_explicit_layout_8bit_access,
                        "workgroupMemoryExplicitLayout8BitAccess",
                    ),
                    RequiredFeature::WorkgroupMemoryExplicitLayout16BitAccess => (
                        explicit_layout.workgroup_memory_explicit_layout_16bit_access,
                        "workgroupMemoryExplicitLayout16BitAccess",
                    ),
                    RequiredFeature::ShaderFloat64 => (core.shader_float64, "shaderFloat64"),
                    RequiredFeature::ShaderInt64 => (core.shader_int64, "shaderInt64"),
                    RequiredFeature::ShaderInt16 => (core.shader_int16, "shaderInt16"),
                    RequiredFeature::StorageBuffer16BitAccess => {
                        (vulkan11.storage_buffer_16bit_access, "storageBuffer16BitAccess")
                    }
                    RequiredFeature::ShaderFloat16 => (vulkan12.shader_float16, "shaderFloat16"),
                    RequiredFeature::ShaderInt8 => (vulkan12.shader_int8, "shaderInt8"),
                    RequiredFeature::UniformAndStorageBuffer8BitAccess => (
                        vulkan12.uniform_and_storage_buffer_8bit_access,
                        "uniformAndStorageBuffer8BitAccess",
                    ),
                    RequiredFeature::StorageBuffer8BitAccess => {
                        (vulkan12.storage_buffer_8bit_access, "storageBuffer8BitAccess")
                    }
                    RequiredFeature::UniformAndStorageBuffer16BitAccess => (
                        vulkan11.uniform_and_storage_buffer_16bit_access,
                        "uniformAndStorageBuffer16BitAccess",
                    ),
                    RequiredFeature::StoragePushConstant8 => (vulkan12.storage_push_constant8, "storagePushConstant8"),
                    RequiredFeature::StoragePushConstant16 => {
                        (vulkan11.storage_push_constant16, "storagePushConstant16")
                    }
                    RequiredFeature::LongVector => (long_vector.long_vector, "longVector"),
                    RequiredFeature::RobustBufferAccess => (core.robust_buffer_access, "robustBufferAccess"),
                    RequiredFeature::ShaderSubgroupClock => (shader_clock.shader_subgroup_clock, "shaderSubgroupClock"),
                    RequiredFeature::ShaderDeviceClock => (shader_clock.shader_device_clock, "shaderDeviceClock"),
                    RequiredFeature::BFloat16Type => (bfloat16.shader_b_float16_type, "shaderBFloat16Type"),
                    RequiredFeature::BFloat16DotProduct => (
                        bfloat16.shader_b_float16_type & bfloat16.shader_b_float_16dot_product,
                        "shaderBFloat16DotProduct",
                    ),
                    RequiredFeature::IntegerDotProduct => {
                        (dot_product.shader_integer_dot_product, "shaderIntegerDotProduct")
                    }
                };
                if supported == vk::FALSE {
                    return Err(TestError::NotSupported(format!("{name} not supported")));
                }
            }
        }

        if self.spec.variable_pointers_storage_buffer || self.spec.variable_pointers {
            let mut variable_pointers = vk::PhysicalDeviceVulkan11Features::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut variable_pointers);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if self.spec.variable_pointers_storage_buffer
                && variable_pointers.variable_pointers_storage_buffer == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "variablePointersStorageBuffer not supported".to_string(),
                ));
            }
            if self.spec.variable_pointers && variable_pointers.variable_pointers == vk::FALSE {
                return Err(TestError::NotSupported("variablePointers not supported".to_string()));
            }
        }

        if self.spec.uses_phys_storage_buffer {
            let mut bda = vk::PhysicalDeviceVulkan12Features::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut bda);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if bda.buffer_device_address == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Request physical storage buffer feature not supported".to_string(),
                ));
            }
        }

        if self.spec.uses_64bit_indexing {
            let mut indexing = vk::PhysicalDeviceShader64BitIndexingFeaturesEXT::default();
            if context.is_device_functionality_supported("VK_EXT_shader_64bit_indexing") {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut indexing);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if indexing.shader_64bit_indexing == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shader64BitIndexing not supported by this implementation".to_string(),
                ));
            }
        }

        if self.spec.float_controls2 {
            let mut float_controls2 = vk::PhysicalDeviceShaderFloatControls2Features::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut float_controls2);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if float_controls2.shader_float_controls2 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderFloatControls2 not supported".to_string(),
                ));
            }
        }

        if self.spec.fma_float_bits != 0 {
            context.require_device_functionality("VK_KHR_shader_fma")?;
            let mut shader_fma = vk::PhysicalDeviceShaderFmaFeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut shader_fma);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            let (supported, name) = match self.spec.fma_float_bits {
                16 => (shader_fma.shader_fma_float16, "shaderFmaFloat16"),
                32 => (shader_fma.shader_fma_float32, "shaderFmaFloat32"),
                _ => (shader_fma.shader_fma_float64, "shaderFmaFloat64"),
            };
            if supported == vk::FALSE {
                return Err(TestError::NotSupported(format!("{name} not supported")));
            }
        }

        if self.spec.maintenance8 {
            let mut maintenance8 = vk::PhysicalDeviceMaintenance8FeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut maintenance8);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if maintenance8.maintenance8 == vk::FALSE {
                return Err(TestError::NotSupported("maintenance8 not supported".to_string()));
            }
        }

        if self.spec.vulkan_memory_model {
            let mut memory_model = vk::PhysicalDeviceVulkan12Features::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut memory_model);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if memory_model.vulkan_memory_model == vk::FALSE {
                return Err(TestError::NotSupported("vulkanMemoryModel not supported".to_string()));
            }
        }

        for (width, mode) in self
            .spec
            .float_controls_property
            .into_iter()
            .chain(self.spec.extra_float_controls_properties.iter().copied())
        {
            let mut float_controls = vk::PhysicalDeviceFloatControlsProperties::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut float_controls);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            let supported = match (width, mode) {
                (16, "DenormPreserve") => float_controls.shader_denorm_preserve_float16,
                (16, "DenormFlushToZero") => float_controls.shader_denorm_flush_to_zero_float16,
                (16, "SignedZeroInfNanPreserve") => float_controls.shader_signed_zero_inf_nan_preserve_float16,
                (16, "RoundingModeRTE") => float_controls.shader_rounding_mode_rte_float16,
                (16, "RoundingModeRTZ") => float_controls.shader_rounding_mode_rtz_float16,
                (32, "DenormPreserve") => float_controls.shader_denorm_preserve_float32,
                (32, "DenormFlushToZero") => float_controls.shader_denorm_flush_to_zero_float32,
                (32, "SignedZeroInfNanPreserve") => float_controls.shader_signed_zero_inf_nan_preserve_float32,
                (32, "RoundingModeRTE") => float_controls.shader_rounding_mode_rte_float32,
                (32, "RoundingModeRTZ") => float_controls.shader_rounding_mode_rtz_float32,
                (64, "DenormPreserve") => float_controls.shader_denorm_preserve_float64,
                (64, "DenormFlushToZero") => float_controls.shader_denorm_flush_to_zero_float64,
                (64, "SignedZeroInfNanPreserve") => float_controls.shader_signed_zero_inf_nan_preserve_float64,
                (64, "RoundingModeRTE") => float_controls.shader_rounding_mode_rte_float64,
                (64, "RoundingModeRTZ") => float_controls.shader_rounding_mode_rtz_float64,
                _ => return Err(TestError::InternalError("Unknown property requested".to_string())),
            };
            if supported == vk::FALSE {
                return Err(TestError::NotSupported("Property is not supported".to_string()));
            }
        }

        if self.spec.signed_zero_inf_nan_preserve_float32
            || self.spec.denorm_preserve_float32
            || self.spec.denorm_flush_to_zero_float32
        {
            let mut float_controls = vk::PhysicalDeviceFloatControlsProperties::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut float_controls);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            let missing = (self.spec.signed_zero_inf_nan_preserve_float32
                && float_controls.shader_signed_zero_inf_nan_preserve_float32 == vk::FALSE)
                || (self.spec.denorm_preserve_float32 && float_controls.shader_denorm_preserve_float32 == vk::FALSE)
                || (self.spec.denorm_flush_to_zero_float32
                    && float_controls.shader_denorm_flush_to_zero_float32 == vk::FALSE);
            if missing {
                return Err(TestError::NotSupported(
                    "Requested float controls properties are not supported".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SpvAsmComputeShaderInstance {
            context,
            spec: &self.spec,
        })
    }
}

/// What one input of the spec became.
enum InputBinding {
    Buffer {
        buffer_ndx: usize,
        size: usize,
    },
    Image {
        view_ndx: Option<usize>,
        sampler_ndx: Option<usize>,
        layout: vk::ImageLayout,
    },
}

/// The descriptor a binding is written with.
enum Bound {
    Buffer(vk::DescriptorBufferInfo),
    Image(vk::DescriptorImageInfo),
}

/// `createImageAndBindMemory` and `copyBufferToImage`: an 8x8 image in `format` filled from `staging`, left in the layout the shader reads it in.
fn upload_image<'a>(
    context: &'a Context<'_>,
    staging: &BufferWithMemory<'_>,
    format: vk::Format,
    storage: bool,
) -> Result<ImageWithMemory<'a>, TestError> {
    let device = context.get_device();
    let usage = if storage {
        vk::ImageUsageFlags::STORAGE
    } else {
        vk::ImageUsageFlags::SAMPLED
    } | vk::ImageUsageFlags::TRANSFER_DST;
    let image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        make_image_create_info(IVec2::new(8, 8), format, usage),
        MemoryRequirement::ANY,
    )?;

    let (final_layout, final_access) = if storage {
        (
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
        )
    } else {
        (vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL, vk::AccessFlags::SHADER_READ)
    };
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image.get(),
        range,
    );
    let to_shader = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        final_access,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        final_layout,
        image.get(),
        range,
    );
    let region = make_buffer_image_copy(
        vk::Extent3D {
            width: 8,
            height: 8,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_buffer_to_image(
            cmd,
            staging.get(),
            image.get(),
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_shader],
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
    Ok(image)
}

pub(super) struct SpvAsmComputeShaderInstance<'a> {
    pub(super) context: &'a Context<'a>,
    pub(super) spec: &'a ComputeShaderSpec,
}

impl TestInstance for SpvAsmComputeShaderInstance<'_> {
    /// `SpvAsmComputeShaderInstance::queuePass`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let spec = self.spec;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        assert!(!spec.outputs.is_empty());

        let host_buffer = |bytes: usize, usage: vk::BufferUsageFlags| {
            let (usage, requirement) = if spec.uses_phys_storage_buffer {
                (
                    usage | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
                    MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
                )
            } else {
                (usage, MemoryRequirement::HOST_VISIBLE)
            };
            BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(bytes as vk::DeviceSize, usage),
                requirement,
            )
        };
        let (input_usage, input_descriptor_type) = if spec.uniform_inputs {
            (vk::BufferUsageFlags::UNIFORM_BUFFER, vk::DescriptorType::UNIFORM_BUFFER)
        } else {
            (vk::BufferUsageFlags::STORAGE_BUFFER, vk::DescriptorType::STORAGE_BUFFER)
        };

        let kind_of = |ndx: usize| spec.input_kinds.get(ndx).copied().unwrap_or(InputKind::Buffer);
        let mut input_buffers = Vec::new();
        let mut input_images = Vec::new();
        let mut image_views = Vec::new();
        let mut samplers = Vec::new();
        let mut input_bindings = Vec::new();
        for (input_ndx, input) in spec.inputs.iter().enumerate() {
            let kind = kind_of(input_ndx);
            if kind == InputKind::Buffer {
                let buffer = host_buffer(input.len(), input_usage)?;
                unsafe {
                    std::ptr::copy_nonoverlapping(input.as_ptr(), buffer.get_allocation().get_host_ptr(), input.len())
                };
                flush_alloc(device, buffer.get_allocation())?;
                input_bindings.push(InputBinding::Buffer {
                    buffer_ndx: input_buffers.len(),
                    size: input.len(),
                });
                input_buffers.push(buffer);
                continue;
            }

            let mut view_ndx = None;
            if kind != InputKind::Sampler {
                let staging = BufferWithMemory::new(
                    device,
                    allocator,
                    make_buffer_create_info(input.len() as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                unsafe {
                    std::ptr::copy_nonoverlapping(input.as_ptr(), staging.get_allocation().get_host_ptr(), input.len())
                };
                flush_alloc(device, staging.get_allocation())?;
                let image = upload_image(context, &staging, spec.input_format, kind == InputKind::StorageImage)?;
                let view = make_image_view(
                    device,
                    image.get(),
                    vk::ImageViewType::_2D,
                    spec.input_format,
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                )?;
                input_images.push(image);
                image_views.push(view);
                view_ndx = Some(image_views.len() - 1);
            }

            let mut sampler_ndx = None;
            if matches!(kind, InputKind::Sampler | InputKind::CombinedImageSampler) {
                let sampler_info = vk::SamplerCreateInfo::builder()
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
                    .min_lod(0.0)
                    .max_lod(0.0)
                    .border_color(vk::BorderColor::INT_OPAQUE_BLACK)
                    .unnormalized_coordinates(false);
                let sampler = unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?;
                samplers.push(Unique::new(device, sampler));
                sampler_ndx = Some(samplers.len() - 1);
            }

            let layout = if kind == InputKind::StorageImage || kind == InputKind::Sampler {
                vk::ImageLayout::GENERAL
            } else {
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
            };
            input_bindings.push(InputBinding::Image {
                view_ndx,
                sampler_ndx,
                layout,
            });
        }

        let mut output_buffers = Vec::new();
        for (output_ndx, output) in spec.outputs.iter().enumerate() {
            let buffer = host_buffer(output.len(), vk::BufferUsageFlags::STORAGE_BUFFER)?;
            match spec.output_initial.get(output_ndx) {
                Some(initial) => unsafe {
                    std::ptr::copy_nonoverlapping(
                        initial.as_ptr(),
                        buffer.get_allocation().get_host_ptr(),
                        output.len().min(initial.len()),
                    )
                },
                None => unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0xff, output.len()) },
            }
            flush_alloc(device, buffer.get_allocation())?;
            output_buffers.push(buffer);
        }

        // With physical storage buffers every descriptor is replaced by one buffer holding the device addresses of the others.
        let address_buffer = if spec.uses_phys_storage_buffer {
            let addresses: Vec<u8> = input_buffers
                .iter()
                .chain(&output_buffers)
                .flat_map(|buffer| {
                    unsafe {
                        device.get_buffer_device_address(&vk::BufferDeviceAddressInfo::builder().buffer(buffer.get()))
                    }
                    .to_ne_bytes()
                })
                .collect();
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(addresses.len() as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    addresses.as_ptr(),
                    buffer.get_allocation().get_host_ptr(),
                    addresses.len(),
                )
            };
            flush_alloc(device, buffer.get_allocation())?;
            Some((buffer, addresses.len()))
        } else {
            None
        };

        // One binding per input, then one storage buffer binding per output.
        let descriptor_types: Vec<vk::DescriptorType> = match &address_buffer {
            Some(_) => vec![vk::DescriptorType::STORAGE_BUFFER],
            None => {
                let input_types = (0..spec.inputs.len()).map(|ndx| match kind_of(ndx) {
                    InputKind::Buffer => input_descriptor_type,
                    InputKind::StorageImage => vk::DescriptorType::STORAGE_IMAGE,
                    InputKind::SampledImage => vk::DescriptorType::SAMPLED_IMAGE,
                    InputKind::CombinedImageSampler => vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    InputKind::Sampler => vk::DescriptorType::SAMPLER,
                });
                let output_types = std::iter::repeat_n(vk::DescriptorType::STORAGE_BUFFER, output_buffers.len());
                if spec.output_first {
                    output_types.chain(input_types).collect()
                } else {
                    input_types.chain(output_types).collect()
                }
            }
        };
        let leading = spec.leading_unused_bindings as usize;
        let array_count = spec.array_count as usize;
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        let mut pool_builder = DescriptorPoolBuilder::new();
        let array_start = spec.inputs.len().saturating_sub(array_count);
        if array_count > 0 {
            for (ndx, &descriptor_type) in descriptor_types[..array_start].iter().enumerate() {
                layout_builder =
                    layout_builder.add_indexed_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE, ndx as u32, 1);
                pool_builder = pool_builder.add_type(descriptor_type, 1);
            }
            layout_builder = layout_builder.add_indexed_binding(
                descriptor_types[array_start],
                vk::ShaderStageFlags::COMPUTE,
                array_start as u32,
                array_count as u32,
            );
            pool_builder = pool_builder.add_type(descriptor_types[array_start], array_count as u32);
            for (ndx, &descriptor_type) in descriptor_types[array_start + array_count..].iter().enumerate() {
                layout_builder = layout_builder.add_indexed_binding(
                    descriptor_type,
                    vk::ShaderStageFlags::COMPUTE,
                    (array_start + 1 + ndx) as u32,
                    1,
                );
                pool_builder = pool_builder.add_type(descriptor_type, 1);
            }
        } else {
            let layout_types: Vec<vk::DescriptorType> =
                std::iter::repeat_n(vk::DescriptorType::STORAGE_BUFFER, leading)
                    .chain(descriptor_types.iter().copied())
                    .collect();
            for &descriptor_type in &layout_types {
                layout_builder = layout_builder.add_single_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE);
                pool_builder = pool_builder.add_type(descriptor_type, 1);
            }
        }
        let descriptor_set_layout = layout_builder.build(device)?;
        let set_layouts = [*descriptor_set_layout];
        let push_size = spec
            .push_constant_sequence
            .first()
            .map_or(spec.push_constants.len(), Vec::len);
        let push_constant_ranges = if push_size == 0 {
            Vec::new()
        } else {
            vec![vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                offset: 0,
                size: push_size as u32,
            }]
        };
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let mut bindings: Vec<Bound> = match &address_buffer {
            Some((buffer, size)) => vec![Bound::Buffer(vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: *size as vk::DeviceSize,
            })],
            None => input_bindings
                .iter()
                .map(|binding| match *binding {
                    InputBinding::Buffer { buffer_ndx, size } => Bound::Buffer(vk::DescriptorBufferInfo {
                        buffer: input_buffers[buffer_ndx].get(),
                        offset: 0,
                        range: size as vk::DeviceSize,
                    }),
                    InputBinding::Image {
                        view_ndx,
                        sampler_ndx,
                        layout,
                    } => Bound::Image(vk::DescriptorImageInfo {
                        sampler: sampler_ndx.map_or(vk::Sampler::null(), |ndx| *samplers[ndx]),
                        image_view: view_ndx.map_or(vk::ImageView::null(), |ndx| *image_views[ndx]),
                        image_layout: layout,
                    }),
                })
                .chain(output_buffers.iter().zip(&spec.outputs).map(|(buffer, output)| {
                    Bound::Buffer(vk::DescriptorBufferInfo {
                        buffer: buffer.get(),
                        offset: 0,
                        range: output.len() as vk::DeviceSize,
                    })
                }))
                .collect(),
        };
        if spec.output_first {
            bindings.rotate_right(output_buffers.len());
        }
        let writes: Vec<vk::WriteDescriptorSet> = bindings
            .iter()
            .enumerate()
            .map(|(binding, bound)| {
                let (dst_binding, dst_array_element) = if array_count == 0 {
                    ((binding + leading) as u32, 0)
                } else if binding < array_start {
                    (binding as u32, 0)
                } else if binding < array_start + array_count {
                    (array_start as u32, (binding - array_start) as u32)
                } else {
                    ((binding - array_count + 1) as u32, 0)
                };
                vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: descriptor_set.get(),
                    dst_binding,
                    dst_array_element,
                    descriptor_count: 1,
                    descriptor_type: descriptor_types[binding],
                    image_info: if let Bound::Image(info) = bound {
                        std::ptr::from_ref(info)
                    } else {
                        std::ptr::null()
                    },
                    buffer_info: if let Bound::Buffer(info) = bound {
                        std::ptr::from_ref(info)
                    } else {
                        std::ptr::null()
                    },
                    texel_buffer_view: std::ptr::null(),
                }
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let binaries = context.get_binary_collection();
        let binary = binaries.get("compute")?;
        if let Some(minor) = spec.spirv_version_minor
            && binary.spirv.get(1).copied() != Some(0x0001_0000 | (minor << 8))
        {
            return Ok(TestStatus::fail("Binary SPIR-V version is different from requested"));
        }
        if let Some(verify_binary) = spec.verify_binary
            && !verify_binary(&binary)
        {
            return Ok(TestStatus::fail("Binary verification of SPIR-V in the test failed"));
        }
        let module = create_shader_module(device, binary)?;

        let entry_points: Vec<CString> = if spec.entry_point_sequence.is_empty() {
            vec![spec.entry_point.clone()]
        } else {
            spec.entry_point_sequence.clone()
        }
        .iter()
        .map(|name| {
            CString::new(name.as_str()).map_err(|_| TestError::InternalError("entry point with a nul".to_string()))
        })
        .collect::<Result<_, _>>()?;
        let mut spec_data = Vec::new();
        let mut map_entries = Vec::new();
        for (constant_id, data) in spec.spec_constants.iter().enumerate() {
            map_entries.push(vk::SpecializationMapEntry {
                constant_id: constant_id as u32,
                offset: spec_data.len() as u32,
                size: data.len(),
            });
            spec_data.extend_from_slice(data);
        }
        let specialization_info = vk::SpecializationInfo::builder()
            .map_entries(&map_entries)
            .data(&spec_data);
        let mut pipelines = Vec::new();
        for entry_point in &entry_points {
            let mut stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*module)
                .name(entry_point.as_bytes_with_nul());
            if !spec.spec_constants.is_empty() {
                stage = stage.specialization_info(&specialization_info);
            }
            let stage = stage.build();
            let mut pipeline_flags2 = vk::PipelineCreateFlags2CreateInfo {
                flags: vk::PipelineCreateFlags2::_64_BIT_INDEXING_EXT,
                ..Default::default()
            };
            let mut pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0);
            if spec.uses_64bit_indexing {
                pipeline_info = pipeline_info.push_next(&mut pipeline_flags2);
            }
            let pipeline_info = pipeline_info.build();
            pipelines.push(Unique::new(
                device,
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?
                    .0[0],
            ));
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        unsafe {
            if !spec.entry_point_sequence.is_empty() {
                for pipeline in &pipelines {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, **pipeline);
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::COMPUTE,
                        *pipeline_layout,
                        0,
                        &[descriptor_set.get()],
                        &[] as &[u32],
                    );
                    device.cmd_dispatch(
                        cmd,
                        spec.num_work_groups[0],
                        spec.num_work_groups[1],
                        spec.num_work_groups[2],
                    );
                }
            }
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipelines[0]);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            if spec.entry_point_sequence.is_empty() && spec.push_constant_sequence.is_empty() {
                if !spec.push_constants.is_empty() {
                    device.cmd_push_constants(
                        cmd,
                        *pipeline_layout,
                        vk::ShaderStageFlags::COMPUTE,
                        0,
                        &spec.push_constants,
                    );
                }
                device.cmd_dispatch(
                    cmd,
                    spec.num_work_groups[0],
                    spec.num_work_groups[1],
                    spec.num_work_groups[2],
                );
            }
            for push_constants in spec
                .push_constant_sequence
                .iter()
                .filter(|_| spec.entry_point_sequence.is_empty())
            {
                device.cmd_push_constants(cmd, *pipeline_layout, vk::ShaderStageFlags::COMPUTE, 0, push_constants);
                device.cmd_dispatch(
                    cmd,
                    spec.num_work_groups[0],
                    spec.num_work_groups[1],
                    spec.num_work_groups[2],
                );
            }

            // The data written by the shader has to be available to the host.
            for output in &output_buffers {
                let barrier = vk::BufferMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                    .dst_access_mask(vk::AccessFlags::HOST_READ)
                    .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .buffer(output.get())
                    .offset(0)
                    .size(vk::WHOLE_SIZE)
                    .build();
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let mut results = Vec::new();
        for (output, expected) in output_buffers.iter().zip(&spec.outputs) {
            invalidate_alloc(device, output.get_allocation())?;
            results.push(
                unsafe {
                    std::slice::from_raw_parts(output.get_allocation().get_host_ptr().cast_const(), expected.len())
                }
                .to_vec(),
            );
        }

        let matches = match spec.verify_io {
            Some(verify_io) => verify_io(&spec.inputs, &results, &spec.outputs),
            None => results
                .iter()
                .zip(&spec.outputs)
                .enumerate()
                .all(
                    |(output_ndx, (result, expected))| match spec.output_masks.get(output_ndx) {
                        Some(mask) if !mask.is_empty() => result
                            .iter()
                            .zip(expected)
                            .zip(mask)
                            .all(|((result, expected), mask)| result & mask == expected & mask),
                        _ => result == expected,
                    },
                ),
        };

        if matches {
            Ok(TestStatus::pass("Output match with expected"))
        } else {
            Ok(TestStatus::new(spec.fail_result, spec.fail_message))
        }
    }
}
