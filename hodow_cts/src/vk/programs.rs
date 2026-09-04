// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkPrograms.hpp / .cpp (vk::BinaryCollection)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The one real divergence from upstream in this file: upstream builds the collection
// by running glslang over the GLSL that `initPrograms` produced at run time. Here the
// SPIR-V is compiled ahead of time by `scripts/compile_shaders.py` and linked in, so
// this type is a lookup over that generated table rather than a compiler front end.
// The driver sees the identical SPIR-V either way - GLSL is not part of the Vulkan
// API, so nothing about driver coverage changes.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::ref_util::Unique;

/// One compiled shader: the SPIR-V words plus the GLSL it was built from.
///
/// The source is carried purely so a failure can quote the shader that produced it;
/// nothing in the run path looks at it.
#[derive(Debug, Clone, Copy)]
pub struct ProgramBinary {
    pub name: &'static str,
    pub spirv: &'static [u32],
    pub glsl: &'static str,
}

/// `vk::BinaryCollection` - the set of shader binaries belonging to one test case.
#[derive(Debug, Clone, Copy)]
pub struct BinaryCollection {
    programs: &'static [ProgramBinary],
}

impl BinaryCollection {
    pub const fn new(programs: &'static [ProgramBinary]) -> Self {
        Self { programs }
    }

    /// `BinaryCollection::get`. Upstream aborts on a missing name; this reports it as
    /// a NotPorted error so a manifest that forgot a program is legible rather than a
    /// bare panic.
    pub fn get(&self, name: &str) -> Result<ProgramBinary, TestError> {
        self.programs
            .iter()
            .find(|p| p.name == name)
            .copied()
            .ok_or_else(|| TestError::NotPorted(format!("no shader binary named {name:?} in this test's collection")))
    }
}

/// `vk::createShaderModule`
pub fn create_shader_module(device: &Device, binary: ProgramBinary) -> Result<Unique<'_, vk::ShaderModule>, TestError> {
    let info = vk::ShaderModuleCreateInfo {
        s_type: vk::StructureType::SHADER_MODULE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ShaderModuleCreateFlags::empty(),
        code_size: std::mem::size_of_val(binary.spirv),
        code: binary.spirv.as_ptr(),
    };
    let module = unsafe { device.create_shader_module(&info, None) }.vk_check("vkCreateShaderModule")?;
    Ok(Unique::new(device, module))
}
