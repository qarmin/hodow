//! Generated code. Do not hand-edit: regeneration must stay diff-clean.
//!
//! `shader_library` comes from `hodow_cts/scripts/gen_shader_library.py` (upstream's own
//! `.test` shader-library files, parsed ahead of time);
//! `shaders` comes from `hodow_cts/scripts/compile_shaders.py` (the shader manifests);
//! `vk_shader_library` from `hodow_cts/scripts/gen_vk_shader_library.py` (the Vulkan `.test` files, with the manifests it writes);
//! `glw` and `eglw` from `hodow_cts/scripts/gen_api_wrappers.py` (upstream's own
//! registry-generated `.inl` files); `glw_core` from `hodow_cts/scripts/gen_gl_core_loaders.py`
//! (the desktop core-profile loaders, from gl.xml).
pub mod eglw;
pub mod glw;
pub mod glw_core;
// The two heavy ones, and the whole reason the features exist: 11 MB of shader-library
// data and 67 MB of SPIR-V. `glw`/`eglw` above are entry-point tables, 664 KB together,
// and stay unconditional so nothing outside the two halves needs a cfg.
#[cfg(feature = "gles")]
pub mod shader_library;
// `gen_vk_shader_library.py`: the case tree of the Vulkan `glsl` group, each case pointing at its constant in `shaders`.
// `gen_khr_shader_library.py`: the case trees of the Khronos GL CTS shader-library files (desktop `shaders*` groups).
#[cfg(feature = "gl")]
pub mod khr_shader_library;
// `gen_ext_tokens.py`: `deqp::GLExtTokens`, the GL enums that are named differently when an extension provides them.
#[cfg(feature = "gl")]
pub mod ext_tokens;
// `gen_khr_packed_pixels_tables.py`: the desktop tables of the Khronos GL CTS packed-pixels test.
#[cfg(feature = "gl")]
pub mod khr_packed_pixels_tables;
// `gen_khr_texture_swizzle_tables.py`: the texture format table of the Khronos GL CTS texture-swizzle test.
#[cfg(feature = "gl")]
pub mod khr_texture_swizzle_tables;
// `gen_khr_internalformat_tables.py`: the desktop format tables of the Khronos GL CTS internalformat test.
#[cfg(feature = "gl")]
pub mod khr_internalformat_tables;
// `gen_khr_blend_colors.py`: the colour tables of the blend_equation_advanced blend_all/blend_specific tests.
#[cfg(feature = "gl")]
pub mod khr_blend_colors;
// `gen_khr_border_clamp_compressed.py`: the ETC2 blobs of the texture_border_clamp sampling tests.
#[cfg(feature = "gl")]
pub mod khr_border_clamp_compressed;
// `gen_khr_api_coverage.py`: the CoverageGL*.test files and the gluStrUtil name tables behind the `api.coverage` case.
#[cfg(feature = "gl")]
pub mod khr_api_coverage;
