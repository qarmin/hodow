// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectBinaryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are `SHADER_OBJECT_BASIC` of `shaders/manifest/shader_object_create.toml`
// (`addBasicShaderObjectShaders`). The `device_features` group is in `binary_device_features_tests`. `new_device` is a device created like the default one by `create_device_without_extensions`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtShaderObjectExtensionDeviceCommands, Handle};

use super::util::{
    ShaderObject, create_shader, create_shader_from_binary, create_shaders_raw, get_shader_binary_data,
    get_shader_name, get_shader_object_next_stages, shader_create_info,
};
use crate::generated::shaders::shader_object_create::SHADER_OBJECT_BASIC;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::context::create_device_without_extensions;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum QueryType {
    SameShader,
    NewShader,
    ShaderFromBinary,
    NewDevice,
    DeviceNoExtsFeatures,
}

#[derive(Clone, Copy)]
struct TestParams {
    stage: vk::ShaderStageFlags,
    linked: bool,
    query_type: QueryType,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum IncompleteBinaryTestType {
    HalfDataSize,
    GarbageData,
    GarbageSecondHalf,
    CreateFromHalfSize,
    CreateFromHalfSizeGarbage,
}

pub(super) struct DeviceGuard(pub(super) Device);

impl Drop for DeviceGuard {
    fn drop(&mut self) {
        unsafe {
            let _ = self.0.device_wait_idle();
            self.0.destroy_device(None);
        }
    }
}

/// The binary tests' own `getNextStage`: unlike the shared table it names one next stage.
fn get_next_stage(
    shader_stage: vk::ShaderStageFlags,
    tessellation_shader_feature: bool,
    geometry_shader_feature: bool,
) -> vk::ShaderStageFlags {
    if shader_stage == vk::ShaderStageFlags::VERTEX {
        if tessellation_shader_feature {
            return vk::ShaderStageFlags::TESSELLATION_CONTROL;
        } else if geometry_shader_feature {
            return vk::ShaderStageFlags::GEOMETRY;
        }
        vk::ShaderStageFlags::FRAGMENT
    } else if shader_stage == vk::ShaderStageFlags::TESSELLATION_CONTROL {
        vk::ShaderStageFlags::TESSELLATION_EVALUATION
    } else if shader_stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
        if geometry_shader_feature {
            return vk::ShaderStageFlags::GEOMETRY;
        }
        vk::ShaderStageFlags::FRAGMENT
    } else if shader_stage == vk::ShaderStageFlags::GEOMETRY {
        vk::ShaderStageFlags::FRAGMENT
    } else {
        vk::ShaderStageFlags::empty()
    }
}

/// `createShader` of the binary tests: one unlinked shader of `stage`, or the whole linked set of which `stage` is kept.
pub(super) fn create_test_shader<'a>(
    device: &'a Device,
    binaries: &BinaryCollection,
    features: &vk::PhysicalDeviceFeatures,
    descriptor_set_layout: Option<vk::DescriptorSetLayout>,
    linked: bool,
    stage: vk::ShaderStageFlags,
) -> Result<ShaderObject<'a>, TestError> {
    let tessellation = features.tessellation_shader != vk::FALSE;
    let geometry = features.geometry_shader != vk::FALSE;

    if !linked {
        let src = binaries.get(get_shader_name(stage))?;
        let layouts: Vec<vk::DescriptorSetLayout> = descriptor_set_layout.into_iter().collect();
        let create_info = shader_create_info(
            vk::ShaderCreateFlagsEXT::empty(),
            stage,
            get_next_stage(stage, tessellation, geometry),
            vk::ShaderCodeTypeEXT::SPIRV,
            std::mem::size_of_val(src.spirv),
            src.spirv.as_ptr().cast(),
            &layouts,
            &[],
        );

        let (shaders, _) = unsafe { device.create_shaders_ext(std::slice::from_ref(&create_info), None) }
            .vk_check("vkCreateShadersEXT")?;
        Ok(ShaderObject::new(device, shaders[0]))
    } else {
        let mut stages = vec![
            ("vert", vk::ShaderStageFlags::VERTEX),
            ("frag", vk::ShaderStageFlags::FRAGMENT),
        ];
        if tessellation {
            stages.push(("tesc", vk::ShaderStageFlags::TESSELLATION_CONTROL));
            stages.push(("tese", vk::ShaderStageFlags::TESSELLATION_EVALUATION));
        }
        if geometry {
            stages.push(("geom", vk::ShaderStageFlags::GEOMETRY));
        }

        let mut create_infos = Vec::new();
        for &(name, linked_stage) in &stages {
            let src = binaries.get(name)?;
            create_infos.push(shader_create_info(
                vk::ShaderCreateFlagsEXT::LINK_STAGE,
                linked_stage,
                get_next_stage(linked_stage, tessellation, geometry),
                vk::ShaderCodeTypeEXT::SPIRV,
                std::mem::size_of_val(src.spirv),
                src.spirv.as_ptr().cast(),
                &[],
                &[],
            ));
        }

        let (shaders, _) = unsafe { device.create_shaders_ext(&create_infos, None) }.vk_check("vkCreateShadersEXT")?;

        let mut kept = None;
        for (info, shader) in create_infos.iter().zip(shaders) {
            if info.stage == stage {
                kept = Some(shader);
            } else {
                unsafe { device.destroy_shader_ext(shader, None) };
            }
        }
        kept.map(|shader| ShaderObject::new(device, shader))
            .ok_or_else(|| TestError::InternalError("the linked set has no shader of the requested stage".to_string()))
    }
}

pub(super) fn check_stage_features(context: &Context<'_>, stage: vk::ShaderStageFlags) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_shader_object")?;

    if (stage == vk::ShaderStageFlags::TESSELLATION_CONTROL || stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION)
        && context.get_device_features().tessellation_shader == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "tessellationShader feature not supported".to_string(),
        ));
    }
    if stage == vk::ShaderStageFlags::GEOMETRY && context.get_device_features().geometry_shader == vk::FALSE {
        return Err(TestError::NotSupported(
            "geometryShader feature not supported".to_string(),
        ));
    }
    Ok(())
}

// ---------------------------------------------------------------------------------------------------------------------
// binary.query
// ---------------------------------------------------------------------------------------------------------------------

fn run_binary_query(context: &Context<'_>, params: TestParams) -> TestOutcome {
    let device = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let features = *context.get_device_features();
    let tessellation_supported = features.tessellation_shader != vk::FALSE;
    let geometry_supported = features.geometry_shader != vk::FALSE;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;

    let layout = if params.stage == vk::ShaderStageFlags::COMPUTE {
        Some(*descriptor_set_layout)
    } else {
        None
    };

    let binaries = context.get_binary_collection();
    let shader = create_test_shader(device, &binaries, &features, layout, params.linked, params.stage)?;

    let data = get_shader_binary_data(device, shader.get())?;

    for _ in 0..10 {
        let other_data = match params.query_type {
            QueryType::SameShader => get_shader_binary_data(device, shader.get())?,
            QueryType::NewShader => {
                let other_shader =
                    create_test_shader(device, &binaries, &features, layout, params.linked, params.stage)?;
                get_shader_binary_data(device, other_shader.get())?
            }
            QueryType::ShaderFromBinary => {
                let other_shader = create_shader_from_binary(
                    device,
                    params.stage,
                    &data,
                    tessellation_supported,
                    geometry_supported,
                    layout,
                )?;
                get_shader_binary_data(device, other_shader.get())?
            }
            QueryType::NewDevice | QueryType::DeviceNoExtsFeatures => {
                let other_device = if params.query_type == QueryType::DeviceNoExtsFeatures {
                    let mut shader_object_features = vk::PhysicalDeviceShaderObjectFeaturesEXT::default();
                    shader_object_features.shader_object = vk::TRUE;
                    let test_features = vk::PhysicalDeviceFeatures {
                        tessellation_shader: u32::from(tessellation_supported),
                        geometry_shader: u32::from(geometry_supported),
                        ..Default::default()
                    };
                    let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                        .features(test_features)
                        .push_next(&mut shader_object_features);
                    let extensions = [c"VK_EXT_shader_object".as_ptr()];
                    let queue_priority = [1.0f32];
                    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
                        .queue_family_index(queue_family_index)
                        .queue_priorities(&queue_priority)
                        .build()];
                    let device_info = vk::DeviceCreateInfo::builder()
                        .queue_create_infos(&queue_infos)
                        .enabled_extension_names(&extensions)
                        .push_next(&mut features2);
                    DeviceGuard(
                        unsafe {
                            context
                                .get_instance()
                                .create_device(context.get_physical_device(), &device_info, None)
                        }
                        .vk_check("vkCreateDevice")?,
                    )
                } else {
                    DeviceGuard(create_device_without_extensions(
                        context.get_instance(),
                        context.get_physical_device(),
                        queue_family_index,
                        &[],
                    )?)
                };

                let other_descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                    .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                    .build(&other_device.0)?;
                let other_layout = if params.stage == vk::ShaderStageFlags::COMPUTE {
                    Some(*other_descriptor_set_layout)
                } else {
                    None
                };

                let other_shader = create_test_shader(
                    &other_device.0,
                    &binaries,
                    &if params.query_type == QueryType::DeviceNoExtsFeatures {
                        vk::PhysicalDeviceFeatures {
                            tessellation_shader: u32::from(tessellation_supported),
                            geometry_shader: u32::from(geometry_supported),
                            ..Default::default()
                        }
                    } else {
                        features
                    },
                    other_layout,
                    params.linked,
                    params.stage,
                )?;
                get_shader_binary_data(&other_device.0, other_shader.get())?
            }
        };

        if data.len() != other_data.len() {
            return Ok(TestStatus::fail("Size not matching"));
        }

        if data != other_data {
            return Ok(TestStatus::fail("Data not matching"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectBinaryQueryCase {
    name: &'static str,
    params: TestParams,
}

impl TestCase for ShaderObjectBinaryQueryCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_stage_features(context, self.params.stage)
    }

    fn programs(&self) -> BinaryCollection {
        SHADER_OBJECT_BASIC.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectBinaryQueryInstance {
            context,
            params: self.params,
        })
    }
}

struct ShaderObjectBinaryQueryInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for ShaderObjectBinaryQueryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_binary_query(self.context, self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// binary.incompatible
// ---------------------------------------------------------------------------------------------------------------------

fn run_incompatible_binary(
    context: &Context<'_>,
    shader_stage: vk::ShaderStageFlags,
    test_type: IncompleteBinaryTestType,
) -> TestOutcome {
    let device = context.get_device();
    let tessellation_supported = context.get_device_features().tessellation_shader != vk::FALSE;
    let geometry_supported = context.get_device_features().geometry_shader != vk::FALSE;

    let binaries = context.get_binary_collection();

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let layouts: Vec<vk::DescriptorSetLayout> = if shader_stage == vk::ShaderStageFlags::COMPUTE {
        vec![*descriptor_set_layout]
    } else {
        Vec::new()
    };

    let src = binaries.get(get_shader_name(shader_stage))?;
    let shader_create_info_spirv = shader_create_info(
        vk::ShaderCreateFlagsEXT::empty(),
        shader_stage,
        get_shader_object_next_stages(shader_stage, tessellation_supported, geometry_supported),
        vk::ShaderCodeTypeEXT::SPIRV,
        std::mem::size_of_val(src.spirv),
        src.spirv.as_ptr().cast(),
        &layouts,
        &[],
    );

    let shader = create_shader(device, &shader_create_info_spirv)?;
    let mut data_size = get_shader_binary_data(device, shader.get())?.len();
    let mut data = vec![123u8; data_size];

    if test_type == IncompleteBinaryTestType::HalfDataSize {
        data_size /= 2;
        let result = unsafe {
            (device.commands().get_shader_binary_data_ext)(
                device.handle(),
                shader.get(),
                &mut data_size,
                data.as_mut_ptr().cast(),
            )
        };

        if result != vk::Result::INCOMPLETE {
            return Ok(TestStatus::fail("Result was not VK_INCOMPLETE"));
        }

        if data.iter().any(|&byte| byte != 123) {
            return Ok(TestStatus::fail("Data was modified"));
        }

        if data_size != 0 {
            return Ok(TestStatus::fail("Data size was not 0"));
        }
    } else {
        let mut random = Random::new(102030);
        // Generate random garbage data
        if test_type != IncompleteBinaryTestType::CreateFromHalfSize {
            let first = if test_type == IncompleteBinaryTestType::GarbageData {
                0
            } else {
                data_size / 2
            };
            for byte in &mut data[first..data_size] {
                *byte = random.get_uint8();
            }
        }

        if test_type == IncompleteBinaryTestType::CreateFromHalfSize
            || test_type == IncompleteBinaryTestType::CreateFromHalfSizeGarbage
        {
            data_size /= 2;
        }

        let invalid_shader_create_info = shader_create_info(
            vk::ShaderCreateFlagsEXT::empty(),
            shader_stage,
            get_shader_object_next_stages(shader_stage, tessellation_supported, geometry_supported),
            vk::ShaderCodeTypeEXT::BINARY,
            data_size,
            data.as_ptr().cast(),
            &layouts,
            &[],
        );

        let mut dst_shader = [vk::ShaderEXT::null()];
        let result = create_shaders_raw(
            device,
            std::slice::from_ref(&invalid_shader_create_info),
            &mut dst_shader,
        );

        if result != vk::Result::INCOMPATIBLE_SHADER_BINARY_EXT {
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectIncompatibleBinaryCase {
    name: &'static str,
    shader_stage: vk::ShaderStageFlags,
    test_type: IncompleteBinaryTestType,
}

impl TestCase for ShaderObjectIncompatibleBinaryCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_stage_features(context, self.shader_stage)
    }

    fn programs(&self) -> BinaryCollection {
        SHADER_OBJECT_BASIC.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectIncompatibleBinaryInstance {
            context,
            shader_stage: self.shader_stage,
            test_type: self.test_type,
        })
    }
}

struct ShaderObjectIncompatibleBinaryInstance<'a> {
    context: &'a Context<'a>,
    shader_stage: vk::ShaderStageFlags,
    test_type: IncompleteBinaryTestType,
}

impl TestInstance for ShaderObjectIncompatibleBinaryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_incompatible_binary(self.context, self.shader_stage, self.test_type)
    }
}

fn query_type_name(query_type: QueryType) -> &'static str {
    match query_type {
        QueryType::SameShader => "same_shader",
        QueryType::NewShader => "new_shader",
        QueryType::ShaderFromBinary => "shader_from_binary",
        QueryType::NewDevice => "new_device",
        QueryType::DeviceNoExtsFeatures => "device_no_exts_features",
    }
}

/// `createShaderObjectBinaryTests`, without `device_features`.
pub fn create_shader_object_binary_tests() -> TestCaseGroup {
    let mut binary_group = TestCaseGroup::new("binary");

    let stage_tests = [
        (vk::ShaderStageFlags::VERTEX, "vert"),
        (vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"),
        (vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"),
        (vk::ShaderStageFlags::GEOMETRY, "geom"),
        (vk::ShaderStageFlags::FRAGMENT, "frag"),
        (vk::ShaderStageFlags::COMPUTE, "comp"),
    ];

    let linked_tests = [false, true];

    let query_type_tests = [
        QueryType::SameShader,
        QueryType::NewShader,
        QueryType::ShaderFromBinary,
        QueryType::NewDevice,
        QueryType::DeviceNoExtsFeatures,
    ];

    let mut query_group = TestCaseGroup::new("query");
    for (stage, stage_name) in stage_tests {
        let mut stage_group = TestCaseGroup::new(stage_name);
        for linked in linked_tests {
            if linked && stage == vk::ShaderStageFlags::COMPUTE {
                continue;
            }

            let mut linked_group = TestCaseGroup::new(if linked { "linked" } else { "unlinked" });
            for query_type in query_type_tests {
                let params = TestParams {
                    stage,
                    linked,
                    query_type,
                };
                linked_group.add_child(Box::new(ShaderObjectBinaryQueryCase {
                    name: query_type_name(query_type),
                    params,
                }) as Box<dyn TestCase>);
            }
            stage_group.add_child(linked_group);
        }
        query_group.add_child(stage_group);
    }

    let incompatible_tests = [
        (IncompleteBinaryTestType::HalfDataSize, "half_size"),
        (IncompleteBinaryTestType::GarbageData, "garbage_data"),
        (IncompleteBinaryTestType::GarbageSecondHalf, "garbage_second_half"),
        (IncompleteBinaryTestType::CreateFromHalfSize, "create_from_half_size"),
        (
            IncompleteBinaryTestType::CreateFromHalfSizeGarbage,
            "create_from_half_size_garbage",
        ),
    ];

    let mut incompatible_group = TestCaseGroup::new("incompatible");
    for (stage, stage_name) in stage_tests {
        let mut stage_group = TestCaseGroup::new(stage_name);
        for (test_type, name) in incompatible_tests {
            stage_group.add_child(Box::new(ShaderObjectIncompatibleBinaryCase {
                name,
                shader_stage: stage,
                test_type,
            }) as Box<dyn TestCase>);
        }
        incompatible_group.add_child(stage_group);
    }

    binary_group.add_child(query_group);
    binary_group.add_child(incompatible_group);
    binary_group.add_child(super::binary_device_features_tests::create_device_features_tests());

    binary_group
}
