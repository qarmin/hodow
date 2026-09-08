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
pub mod defs;
pub mod fuzzy_image_compare;
pub mod image_compare;
pub mod pixel;
pub mod pixel_format;
pub mod random;
pub mod rgba;
pub mod string_template;
pub mod surface;
pub mod test_case;
pub mod tex_verifier;
pub mod texture;
pub mod vector;

pub use defs::{TestError, TestOutcome, TestResult, TestStatus};
pub use pixel_format::PixelFormat;
pub use random::Random;
pub use rgba::RGBA;
pub use string_template::StringTemplate;
pub use surface::Surface;
pub use test_case::{FlatCase, TestCaseGroup, TestNode, TestNodeInfo, flatten};
pub use texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat, map_vk_format};
pub use vector::{IVec2, IVec3, IVec4, UVec3, UVec4, Vec2, Vec3, Vec4, multiply_components};
