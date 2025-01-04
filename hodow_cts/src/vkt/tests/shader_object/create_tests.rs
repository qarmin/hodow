// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectCreateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are `SHADER_OBJECT_CREATE_ALL[_MESH]` and `SHADER_OBJECT_STAGE_SET[_MESH]`
// of `shaders/manifest/shader_object_create.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtShaderObjectExtensionDeviceCommands, Handle, InstanceV1_1};

use super::util::{
    ShaderObject, create_shaders_raw, get_shader_binary_data, get_shader_name, get_shader_object_next_stages,
    shader_create_info,
};
use crate::generated::shaders::shader_object_create::{
    SHADER_OBJECT_CREATE_ALL, SHADER_OBJECT_CREATE_ALL_MESH, SHADER_OBJECT_STAGE_SET, SHADER_OBJECT_STAGE_SET_MESH,
};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, ProgramBinary};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

fn mesh_shader_features(context: &Context<'_>) -> vk::PhysicalDeviceMeshShaderFeaturesEXT {
    let mut mesh_features = vk::PhysicalDeviceMeshShaderFeaturesEXT::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut mesh_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    mesh_features
}

fn spirv_info(
    binary: &ProgramBinary,
    stage: vk::ShaderStageFlags,
    tessellation_supported: bool,
    geometry_supported: bool,
    set_layouts: &[vk::DescriptorSetLayout],
) -> vk::ShaderCreateInfoEXT {
    shader_create_info(
        vk::ShaderCreateFlagsEXT::empty(),
        stage,
        get_shader_object_next_stages(stage, tessellation_supported, geometry_supported),
        vk::ShaderCodeTypeEXT::SPIRV,
        std::mem::size_of_val(binary.spirv),
        binary.spirv.as_ptr().cast(),
        set_layouts,
        &[],
    )
}

// ---------------------------------------------------------------------------------------------------------------------
// create.multiple
// ---------------------------------------------------------------------------------------------------------------------

fn run_create(context: &Context<'_>, use_mesh_shaders: bool) -> TestOutcome {
    let device = context.get_device();
    let tessellation_supported = context.get_device_features().tessellation_shader != vk::FALSE;
    let geometry_supported = context.get_device_features().geometry_shader != vk::FALSE;

    let binaries = context.get_binary_collection();
    let vert = binaries.get("vert")?;
    let tesc = binaries.get("tesc")?;
    let tese = binaries.get("tese")?;
    let geom = binaries.get("geom")?;
    let frag = binaries.get("frag")?;
    let comp = binaries.get("comp")?;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let set_layout = [*descriptor_set_layout];

    let mut shader_create_infos = vec![
        spirv_info(
            &vert,
            vk::ShaderStageFlags::VERTEX,
            tessellation_supported,
            geometry_supported,
            &[],
        ),
        spirv_info(
            &frag,
            vk::ShaderStageFlags::FRAGMENT,
            tessellation_supported,
            geometry_supported,
            &[],
        ),
        shader_create_info(
            vk::ShaderCreateFlagsEXT::empty(),
            vk::ShaderStageFlags::COMPUTE,
            vk::ShaderStageFlags::empty(),
            vk::ShaderCodeTypeEXT::SPIRV,
            std::mem::size_of_val(comp.spirv),
            comp.spirv.as_ptr().cast(),
            &set_layout,
            &[],
        ),
    ];

    if tessellation_supported {
        shader_create_info_push(
            &mut shader_create_infos,
            &tesc,
            vk::ShaderStageFlags::TESSELLATION_CONTROL,
            tessellation_supported,
            geometry_supported,
        );
        shader_create_info_push(
            &mut shader_create_infos,
            &tese,
            vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            tessellation_supported,
            geometry_supported,
        );
    }

    if geometry_supported {
        shader_create_info_push(
            &mut shader_create_infos,
            &geom,
            vk::ShaderStageFlags::GEOMETRY,
            tessellation_supported,
            geometry_supported,
        );
    }

    if use_mesh_shaders {
        let mesh = binaries.get("mesh")?;
        let task = binaries.get("task")?;
        let mesh_features = mesh_shader_features(context);
        if mesh_features.mesh_shader != vk::FALSE {
            shader_create_infos.push(spirv_info(&mesh, vk::ShaderStageFlags::MESH_EXT, false, false, &[]));
            // `nextStage` is 0 for these two upstream, whatever the stage-to-stage table says
            shader_create_infos.last_mut().expect("just pushed").next_stage = vk::ShaderStageFlags::empty();
        }

        if mesh_features.task_shader != vk::FALSE {
            shader_create_infos.push(spirv_info(&task, vk::ShaderStageFlags::TASK_EXT, false, false, &[]));
            shader_create_infos.last_mut().expect("just pushed").next_stage = vk::ShaderStageFlags::empty();
        }
    }

    let mut shaders_separate = Vec::new();
    for info in &shader_create_infos {
        let (shaders, _) =
            unsafe { device.create_shaders_ext(std::slice::from_ref(info), None) }.vk_check("vkCreateShadersEXT")?;
        shaders_separate.push(ShaderObject::new(device, shaders[0]));
    }
    let (shaders, _) =
        unsafe { device.create_shaders_ext(&shader_create_infos, None) }.vk_check("vkCreateShadersEXT")?;
    let shaders_together: Vec<ShaderObject<'_>> = shaders
        .into_iter()
        .map(|shader| ShaderObject::new(device, shader))
        .collect();

    let mut matching = true;
    for i in 0..shader_create_infos.len() {
        let data_separate = get_shader_binary_data(device, shaders_separate[i].get())?;
        let data_together = get_shader_binary_data(device, shaders_together[i].get())?;
        if data_separate.len() != data_together.len() {
            log::info!(
                "Data size of shader created separately is {}, but data size of shader created in the same call with others is {}",
                data_separate.len(),
                data_together.len()
            );
            matching = false;
            break;
        }
        if let Some(j) = (0..data_separate.len()).find(|&j| data_separate[j] != data_together[j]) {
            log::info!(
                "Data of shader created separately and data of shader created in the same call with others does not match at index {j}"
            );
            matching = false;
            break;
        }
    }

    drop(shaders_separate);
    drop(shaders_together);

    if !matching {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// A stage that needs no descriptor set layout: its `nextStage` comes from the stage-to-stage table.
fn shader_create_info_push(
    infos: &mut Vec<vk::ShaderCreateInfoEXT>,
    binary: &ProgramBinary,
    stage: vk::ShaderStageFlags,
    tessellation_supported: bool,
    geometry_supported: bool,
) {
    infos.push(spirv_info(
        binary,
        stage,
        tessellation_supported,
        geometry_supported,
        &[],
    ));
}

struct ShaderObjectCreateCase {
    name: &'static str,
    use_mesh_shaders: bool,
}

impl TestCase for ShaderObjectCreateCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")
    }

    fn programs(&self) -> BinaryCollection {
        if self.use_mesh_shaders {
            SHADER_OBJECT_CREATE_ALL_MESH.programs
        } else {
            SHADER_OBJECT_CREATE_ALL.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectCreateInstance {
            context,
            use_mesh_shaders: self.use_mesh_shaders,
        })
    }
}

struct ShaderObjectCreateInstance<'a> {
    context: &'a Context<'a>,
    use_mesh_shaders: bool,
}

impl TestInstance for ShaderObjectCreateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_create(self.context, self.use_mesh_shaders)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// create.<stage>.{succeed,fail}
// ---------------------------------------------------------------------------------------------------------------------

fn run_stage(
    context: &Context<'_>,
    stage_param: vk::ShaderStageFlags,
    fail: bool,
    use_mesh_shaders: bool,
) -> TestOutcome {
    let device = context.get_device();
    let tessellation_supported = context.get_device_features().tessellation_shader != vk::FALSE;
    let geometry_supported = context.get_device_features().geometry_shader != vk::FALSE;

    let binaries = context.get_binary_collection();

    let mut random = Random::new(102030);
    let mut stages = vec![
        vk::ShaderStageFlags::VERTEX,
        vk::ShaderStageFlags::FRAGMENT,
        vk::ShaderStageFlags::COMPUTE,
    ];
    if tessellation_supported {
        stages.push(vk::ShaderStageFlags::TESSELLATION_CONTROL);
        stages.push(vk::ShaderStageFlags::TESSELLATION_EVALUATION);
    }
    if geometry_supported {
        stages.push(vk::ShaderStageFlags::GEOMETRY);
    }
    if use_mesh_shaders {
        let mesh_features = mesh_shader_features(context);
        if mesh_features.mesh_shader != vk::FALSE {
            stages.push(vk::ShaderStageFlags::MESH_EXT);
        }
        if mesh_features.task_shader != vk::FALSE {
            stages.push(vk::ShaderStageFlags::TASK_EXT);
        }
    }

    let count = if stage_param == vk::ShaderStageFlags::ALL {
        50usize
    } else {
        10
    };

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let set_layout = [*descriptor_set_layout];

    let mut shader_create_infos = Vec::new();

    for i in 0..count {
        let stage = if stage_param == vk::ShaderStageFlags::ALL {
            stages[random.get_uint32() as usize % stages.len()]
        } else {
            stage_param
        };

        let use_layout = stage == vk::ShaderStageFlags::COMPUTE;

        let src = binaries.get(&format!("{}{}", get_shader_name(stage), i % 10))?;
        shader_create_infos.push(spirv_info(
            &src,
            stage,
            tessellation_supported,
            geometry_supported,
            if use_layout { &set_layout } else { &[] },
        ));
    }

    let (shaders, _) = match unsafe { device.create_shaders_ext(&shader_create_infos, None) } {
        Ok(result) => result,
        Err(error) => {
            log::info!("vkCreateShadersEXT returned {error:?}");
            return Ok(TestStatus::fail("Fail"));
        }
    };
    let shaders: Vec<ShaderObject<'_>> = shaders
        .into_iter()
        .map(|shader| ShaderObject::new(device, shader))
        .collect();

    let mut binary_data = Vec::with_capacity(count);
    for shader in &shaders {
        binary_data.push(get_shader_binary_data(device, shader.get())?);
    }

    drop(shaders);

    let fail_index = random.get_uint32() as usize % count;

    for (i, info) in shader_create_infos.iter_mut().enumerate() {
        info.code_type = vk::ShaderCodeTypeEXT::BINARY;
        info.code_size = if fail && fail_index == i {
            1
        } else {
            binary_data[i].len()
        };
        info.code = binary_data[i].as_ptr().cast();
    }

    let garbage = vk::ShaderEXT::from_raw(1234);
    let mut binary_shaders = vec![garbage; count]; // Fill with garbage
    let result = create_shaders_raw(device, &shader_create_infos, &mut binary_shaders);

    // Clean up all shaders that the driver actually wrote to. This includes indicies past the first failure, as the driver may
    // have completed compilation of later shaders prior to detecting the error.
    let destroy_written = |binary_shaders: &[vk::ShaderEXT]| {
        for &shader in binary_shaders {
            if shader != garbage {
                unsafe { device.destroy_shader_ext(shader, None) };
            }
        }
    };

    if fail {
        if result != vk::Result::INCOMPATIBLE_SHADER_BINARY_EXT {
            log::info!(
                "Shader at index {fail_index}was created with size 1, but vkCreateShadersEXT returned {result:?}"
            );
            destroy_written(&binary_shaders);
            return Ok(TestStatus::fail("Fail"));
        }

        for i in 0..count {
            if i < fail_index {
                if binary_shaders[i] == garbage {
                    log::info!(
                        "vkCreateShadersEXT returned VK_ERROR_INCOMPATIBLE_SHADER_BINARY_EXT and failed at index {fail_index}, but shader at index {i}was not created"
                    );
                    destroy_written(&binary_shaders);
                    return Ok(TestStatus::fail("Fail"));
                } else if binary_shaders[i] == vk::ShaderEXT::null() {
                    log::info!(
                        "vkCreateShadersEXT returned VK_ERROR_INCOMPATIBLE_SHADER_BINARY_EXT with an intentional failure at {fail_index}, but the first null shader is at index {i}"
                    );
                    destroy_written(&binary_shaders);
                    return Ok(TestStatus::fail("Fail"));
                }
            }
            if i == fail_index && binary_shaders[i] != vk::ShaderEXT::null() {
                let what = if binary_shaders[i] == garbage {
                    "was not written to"
                } else {
                    "succeeded"
                };
                log::info!(
                    "vkCreateShadersEXT returned VK_ERROR_INCOMPATIBLE_SHADER_BINARY_EXT, the shader at index {fail_index} {what}, but should have failed and been set to VK_NULL_HANDLE"
                );
                destroy_written(&binary_shaders);
                return Ok(TestStatus::fail("Fail"));
            }
        }
        destroy_written(&binary_shaders);
    } else {
        if result != vk::Result::SUCCESS {
            log::info!("vkCreateShadersEXT returned {result:?}");
            destroy_written(&binary_shaders);
            return Ok(TestStatus::fail("Fail"));
        }

        destroy_written(&binary_shaders);
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectStageCase {
    name: &'static str,
    stage: vk::ShaderStageFlags,
    fail: bool,
    use_mesh_shaders: bool,
}

impl TestCase for ShaderObjectStageCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;
        if self.use_mesh_shaders {
            context.require_device_functionality("VK_EXT_mesh_shader")?;
        }

        if (self.stage == vk::ShaderStageFlags::TESSELLATION_CONTROL
            || self.stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION)
            && context.get_device_features().tessellation_shader == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "tessellationShader feature not supported".to_string(),
            ));
        }
        if self.stage == vk::ShaderStageFlags::GEOMETRY && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature not supported".to_string(),
            ));
        }
        if self.stage == vk::ShaderStageFlags::TASK_EXT && mesh_shader_features(context).task_shader == vk::FALSE {
            return Err(TestError::NotSupported("Task shaders not supported".to_string()));
        }
        if self.stage == vk::ShaderStageFlags::MESH_EXT && mesh_shader_features(context).mesh_shader == vk::FALSE {
            return Err(TestError::NotSupported("Mesh shaders not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.use_mesh_shaders {
            SHADER_OBJECT_STAGE_SET_MESH.programs
        } else {
            SHADER_OBJECT_STAGE_SET.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectStageInstance {
            context,
            stage: self.stage,
            fail: self.fail,
            use_mesh_shaders: self.use_mesh_shaders,
        })
    }
}

struct ShaderObjectStageInstance<'a> {
    context: &'a Context<'a>,
    stage: vk::ShaderStageFlags,
    fail: bool,
    use_mesh_shaders: bool,
}

impl TestInstance for ShaderObjectStageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_stage(self.context, self.stage, self.fail, self.use_mesh_shaders)
    }
}

/// `createShaderObjectCreateTests`
pub fn create_shader_object_create_tests() -> TestCaseGroup {
    let mut create_group = TestCaseGroup::new("create");

    let mut multiple_group = TestCaseGroup::new("multiple");

    multiple_group.add_child(Box::new(ShaderObjectCreateCase {
        name: "all",
        use_mesh_shaders: false,
    }) as Box<dyn TestCase>);
    multiple_group.add_child(Box::new(ShaderObjectCreateCase {
        name: "all_with_mesh",
        use_mesh_shaders: true,
    }) as Box<dyn TestCase>);

    create_group.add_child(multiple_group);

    let stage_tests = [
        (vk::ShaderStageFlags::VERTEX, false, "vert"),
        (vk::ShaderStageFlags::TESSELLATION_CONTROL, false, "tesc"),
        (vk::ShaderStageFlags::TESSELLATION_EVALUATION, false, "tese"),
        (vk::ShaderStageFlags::GEOMETRY, false, "geom"),
        (vk::ShaderStageFlags::FRAGMENT, false, "frag"),
        (vk::ShaderStageFlags::COMPUTE, false, "comp"),
        (vk::ShaderStageFlags::MESH_EXT, true, "mesh"),
        (vk::ShaderStageFlags::TASK_EXT, true, "task"),
        (vk::ShaderStageFlags::ALL, false, "all"),
        (vk::ShaderStageFlags::ALL, true, "all_with_mesh"),
    ];

    let fail_tests = [(false, "succeed"), (true, "fail")];

    for (stage, use_mesh_shaders, stage_name) in stage_tests {
        let mut stage_group = TestCaseGroup::new(stage_name);
        for (fail, fail_name) in fail_tests {
            stage_group.add_child(Box::new(ShaderObjectStageCase {
                name: fail_name,
                stage,
                fail,
                use_mesh_shaders,
            }) as Box<dyn TestCase>);
        }
        create_group.add_child(stage_group);
    }

    create_group
}
