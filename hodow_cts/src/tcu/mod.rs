// SPDX-License-Identifier: Apache-2.0
//
// Port of the parts of VK-GL-CTS `framework/common` and `framework/delibs` that the
// ported tests use. Everything here is ported on demand: a path that no ported test
// exercises yet is left out entirely rather than guessed at, and reaching one
// raises `TestError::NotPorted` instead of silently approximating - an approximation
// would produce a verdict indistinguishable from a real driver bug.

pub mod defs;
pub mod random;
pub mod test_case;
pub mod texture;
pub mod vector;

pub use defs::{TestError, TestOutcome, TestResult, TestStatus};
pub use random::Random;
pub use test_case::{FlatCase, TestCaseGroup, TestNode, flatten};
pub use texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat, map_vk_format};
pub use vector::{IVec2, IVec3, UVec3, UVec4, Vec4, multiply_components};
