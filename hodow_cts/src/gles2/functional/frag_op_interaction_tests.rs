// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFragOpInteractionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `fragment_ops.interaction`: 100 random shader pairs (`basic_shader`) drawn through random render states, see
// `gls::frag_op_interaction_case`.

use crate::glu::TestCaseGroup;
use crate::rsg::parameters::Version;

/// `FragOpInteractionTests::init`
pub fn create_tests() -> TestCaseGroup {
    crate::gls::frag_op_interaction_case::create_tests(Version::Version100, 0x667eacfd)
}
