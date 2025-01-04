// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/simplereference/
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `reference_context` is the start of `sglrReferenceContext` - the software GL context
// most of upstream's render tests compare against - currently covering buffer objects
// and vertex array objects only; see that module's own doc comment for the exact
// boundary. `reference_utils` is the GL-enum-to-`rr`-enum mapping a test needs when it
// drives `rr::FragmentProcessor` directly, predating `reference_context` and
// independent of it.
//
// `shader_program`/`context`/`context_util` port `sglrShaderProgram`/`sglrContext`/
// `sglrContextUtil` - a shader shape with named, runtime-settable uniform slots plus a
// narrow GL-state-machine trait a test case drives generically over either a real
// driver or `ReferenceContext` (which implements it). `gl_context` ports
// `sglrGLContext` - the real-driver-backed implementor, so a test written once against
// `&mut dyn Context` runs unchanged against either it or `ReferenceContext`; see that
// module's own doc comment for exactly what's narrowed relative to upstream.

pub mod context;
pub mod context_util;
pub mod gl_context;
pub mod object_manager;
pub mod reference_context;
pub mod reference_utils;
pub mod shader_program;
