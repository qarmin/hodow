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

// The generated SPIR-V is little-endian words in `.spv` files next to the generated modules, included with `include_bytes!`. Written
// out as `[u32; N]` literals it cost rustc ~560 bytes per word, 30+ GB for the whole Vulkan half; a blob costs the size of the file.
#[cfg(target_endian = "big")]
compile_error!("the generated SPIR-V blobs are little-endian words");

/// A byte blob aligned for `u32`, so `spirv_words` can read words out of it in place.
#[repr(C, align(4))]
pub struct SpirvBlob<T: ?Sized>(pub T);

/// The `len` words starting `offset` words into a generated blob.
pub const fn spirv_words(blob: &'static SpirvBlob<[u8]>, offset: usize, len: usize) -> &'static [u32] {
    assert!((offset + len) * 4 <= blob.0.len());
    // SAFETY: SpirvBlob is 4-byte aligned, the range was checked above, and every bit pattern is a valid u32.
    unsafe { std::slice::from_raw_parts(blob.0.as_ptr().cast::<u32>().add(offset), len) }
}

/// Whether the generated shader modules embed their GLSL (feature `shader_sources`); the SPIR-V is always embedded. The GLSL is about 900 MB and pushed the binary past the 2 GB a small-code-model link can address.
pub const KEEP_GLSL: bool = cfg!(feature = "shader_sources");

/// The shader source at `offset..offset + len` of a part's `.glsl` file.
///
/// The generator cuts the file at whole sources, each valid UTF-8 on its own; the range is checked here.
pub const fn glsl_text(text: &'static str, offset: usize, len: usize) -> &'static str {
    if text.is_empty() {
        return "";
    }
    assert!(offset + len <= text.len());
    // SAFETY: the range is inside `text` (checked above) and starts and ends at the boundaries of whole sources.
    unsafe { std::str::from_utf8_unchecked(std::slice::from_raw_parts(text.as_ptr().add(offset), len)) }
}

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

    /// `BinaryCollection::contains`
    pub fn contains(&self, name: &str) -> bool {
        self.programs.iter().any(|program| program.name == name)
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
/// The `rust_type` of a manifest entry that carries only its programs - the shape for
/// a shader several test cases share unchanged.
pub struct SharedProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

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
