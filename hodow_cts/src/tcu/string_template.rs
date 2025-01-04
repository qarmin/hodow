// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuStringTemplate.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The parameter map is a slice of
// (name, value) pairs rather than a `std::map`, since every caller writes it out
// literally at the call site.

use crate::tcu::TestError;

const SINGLE_LINE_FLAG: &str = "single-line";
const OPT_FLAG: &str = "opt";
const DEFAULT_FLAG: &str = "default=";

/// `tcu::StringTemplate`
pub struct StringTemplate {
    template: String,
}

impl StringTemplate {
    pub fn new(str: impl Into<String>) -> Self {
        Self { template: str.into() }
    }

    /// `StringTemplate::specialize`
    pub fn specialize(&self, params: &[(&str, String)]) -> Result<String, TestError> {
        let mut res = String::new();

        let mut cur_ndx = 0;
        loop {
            let Some(param_ndx) = self.template[cur_ndx..].find("${").map(|n| cur_ndx + n) else {
                if cur_ndx < self.template.len() {
                    res.push_str(&self.template[cur_ndx..]);
                }
                break;
            };

            // Append in-between stuff.
            res.push_str(&self.template[cur_ndx..param_ndx]);

            // Find end-of-param.
            let Some(param_end_ndx) = self.template[param_ndx..].find('}').map(|n| param_ndx + n) else {
                return Err(TestError::InternalError(
                    "No '}' found in template parameter".to_string(),
                ));
            };

            // Parse parameter contents.
            let param_str = &self.template[param_ndx + 2..param_end_ndx];
            let mut param_single_line = false;
            let mut param_optional = false;
            let mut param_default = false;
            let param_name;
            let mut default_value = "";
            if let Some(colon_ndx) = param_str.find(':') {
                param_name = &param_str[..colon_ndx];
                let flags_str = &param_str[colon_ndx + 1..];
                if flags_str == SINGLE_LINE_FLAG {
                    param_single_line = true;
                } else if flags_str == OPT_FLAG {
                    param_optional = true;
                } else if let Some(value) = flags_str.strip_prefix(DEFAULT_FLAG) {
                    param_default = true;
                    default_value = value;
                } else {
                    return Err(TestError::InternalError(format!("Unrecognized flag{param_str}")));
                }
            } else {
                param_name = param_str;
            }

            // Fill in parameter value.
            if let Some((_, val)) = params.iter().find(|(name, _)| *name == param_name) {
                if param_single_line {
                    res.push_str(&val.replace('\n', " "));
                } else {
                    res.push_str(val);
                }
            } else if param_default {
                res.push_str(default_value);
            } else if !param_optional {
                return Err(TestError::InternalError(format!(
                    "Value for parameter '{param_name}' not found in map"
                )));
            }

            // Skip over template.
            cur_ndx = param_end_ndx + 1;
        }

        Ok(res)
    }
}
