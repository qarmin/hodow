// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).

fn main() -> std::process::ExitCode {
    std::process::ExitCode::from(hodow_cts::cli::main_from(std::env::args_os()))
}
