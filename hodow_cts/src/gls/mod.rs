// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared  (deqp::gls::)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The helpers upstream shares between its GL modules. Ported on demand, like `tcu`
// and `glu`: whatever the ported groups actually use, and nothing guessed at.

pub mod state_query_util;
