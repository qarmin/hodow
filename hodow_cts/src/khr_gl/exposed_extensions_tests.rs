// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcExposedExtensionsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `init` picks the ES or the desktop flavour from the context type; every KHR-GL root is a desktop one, so only the desktop branch exists here.

use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::tcu::{TestOutcome, TestStatus};

/// `glcts::ExposedExtensionsTest`
struct ExposedExtensionsTest {
    not_allowed_substring: &'static str,
    allowed_exceptions: &'static [&'static str],
}

impl TestCase for ExposedExtensionsTest {
    fn name(&self) -> &str {
        "validate_extensions"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut all_exceptions_are_valid = true;

        for extension in &context.context_info.extensions {
            if !extension.contains(self.not_allowed_substring) {
                continue;
            }
            // Every offender is logged, not only the first, so one run lists them all.
            if !self.allowed_exceptions.contains(&extension.as_str()) {
                log::info!("Implementations should not expose {extension}");
                all_exceptions_are_valid = false;
            }
        }

        if all_exceptions_are_valid {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

/// `glcts::ExposedExtensionsTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("exposed_extensions");
    group.add_child(Box::new(ExposedExtensionsTest {
        not_allowed_substring: "OES",
        allowed_exceptions: &["GL_OES_EGL_image"],
    }) as Box<dyn TestCase>);
    group
}
