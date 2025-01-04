// SPDX-License-Identifier: Apache-2.0
//
// Port of the parts of VK-GL-CTS `framework/common` and `framework/delibs` that the
// ported tests use. Everything here is ported on demand: a path that no ported test
// exercises yet is left out entirely rather than guessed at, and reaching one
// raises `TestError::NotPorted` instead of silently approximating - an approximation
// would produce a verdict indistinguishable from a real driver bug.

pub mod astc;
pub mod bilinear_image_compare;
pub mod compressed_texture;
pub mod de_string_util;
pub mod defs;
pub mod float;
pub mod float_format;
pub mod fuzzy_image_compare;
pub mod image_compare;
pub mod interval;
pub mod matrix;
pub mod pixel;
pub mod pixel_format;
pub mod png;
pub mod random;
pub mod rasterization_verifier;
pub mod result_collector;
pub mod rgba;
pub mod string_template;
pub mod surface;
pub mod surface_access;
pub mod test_case;
pub mod tex_compare_verifier;
pub mod tex_verifier;
pub mod texture;
pub mod texture_2d;
pub mod texture_2d_array;
pub mod texture_3d;
pub mod texture_cube;
pub mod vector;

pub use de_string_util::to_string_f32;
pub use defs::{TestError, TestOutcome, TestResult, TestStatus};
pub use pixel_format::PixelFormat;
pub use random::{Random, de_string_hash};
pub use rgba::RGBA;
pub use string_template::StringTemplate;
pub use surface::Surface;
pub use test_case::{FlatCase, TestCaseGroup, TestNode, TestNodeInfo, flatten};
pub use texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat, map_vk_format};
pub use vector::{IVec2, IVec3, IVec4, UVec3, UVec4, Vec2, Vec3, Vec4, multiply_components};
