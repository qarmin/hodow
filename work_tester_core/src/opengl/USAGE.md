# OpenGL Testing - Quick Start

## Overview

This module provides an OpenGL testing framework similar to the CPU SIMD testing structure. Each test targets a specific OpenGL version and tests related functionality.

## Running Tests

### Via justfile

```bash
# Run with GPU support
just gpu

# Run in release mode
just gpu-release

# Generate function coverage table
just gen-gl-table
```

### Direct cargo commands

```bash
# Build and run with GPU feature
cargo run --features gpu -- --gui

# Check cross-compilation
just arm
```

## Available Tests

Currently implemented:

1. **GL 2.0 Shaders** (`gl20_shaders.rs`) - Tests shader compilation, linking, and attribute locations
2. **GL 3.3 VAO** (`gl33_vao.rs`) - Tests Vertex Array Objects and indexed drawing

## Adding a New Test

### Step 1: Create test file

Create `work_tester_core/src/opengl/tests/gl30_example.rs`:

```rust
#![cfg(feature = "gpu")]

//! OpenGL 3.0 Example Test
//!
//! GL_VERSION: 3.0
//! GL_FUNCTIONS: glBindFragDataLocation, glGetFragDataLocation, glClearBufferfv

use crate::opengl::test_trait::{GLTest, GLVersion};
use std::error::Error;

pub struct GL30ExampleTest;

impl GLTest for GL30ExampleTest {
    fn name(&self) -> &'static str {
        "GL30_Example"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }

    fn used_functions(&self) -> &[&'static str] {
        &[
            "glBindFragDataLocation",
            "glGetFragDataLocation",
            "glClearBufferfv",
        ]
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        // Your test code here
        Ok("Test passed".to_string())
    }
}
```

### Step 2: Register the test

Edit `work_tester_core/src/opengl/tests/mod.rs`:

```rust
pub mod gl30_example;  // Add this line

pub fn all_tests() -> Vec<&'static dyn GLTest> {
    vec![
        &gl20_shaders::GL20ShadersTest,
        &gl30_example::GL30ExampleTest,  // Add this line
        &gl33_vao::GL33VAOTest,
    ]
}
```

### Step 3: Update documentation

Run the table generator:

```bash
just gen-gl-table
```

This will update `FUNCTIONS_TABLE.md` with your new test's functions.

## Test Structure

Each test must:
- Have `GL_VERSION` and `GL_FUNCTIONS` comments
- Implement the `GLTest` trait
- Be self-contained
- Use version-appropriate OpenGL functions
- Return descriptive success/error messages

## Metadata Format

The special comments are parsed by `scripts/generate_gl_table.py`:

```rust
//! GL_VERSION: X.Y
//! GL_FUNCTIONS: func1, func2, func3, ...
```

- `GL_VERSION`: Major.Minor version (e.g., "3.3", "2.0")
- `GL_FUNCTIONS`: Comma-separated list of OpenGL functions used

## Cross-Compilation

Tests are designed to compile for different targets:

```bash
# Test ARM 32-bit cross-compilation
just arm
```

The OpenGL context creation is platform-aware and will use appropriate backends (EGL, GLX, etc.).

## Troubleshooting

### Context creation fails

Make sure you have proper OpenGL drivers installed:
- Linux: `libgl1-mesa-dev`, `libegl1-mesa-dev`
- Headless servers may need Mesa software rendering

### Function not found

The `gl` crate only includes modern OpenGL functions (2.0+). Legacy functions (glBegin, glEnd, etc.) are not supported.

### Cross-compilation issues

Ensure you have the `cargo-zigbuild` tool installed:

```bash
cargo install cargo-zigbuild
```

## Architecture

```
work_tester_core/src/opengl/
├── mod.rs              # Main module, exports
├── context.rs          # OpenGL context creation
├── loader.rs           # GL function loading
├── test_trait.rs       # GLTest trait definition
├── tests/
│   ├── mod.rs         # Test registration
│   ├── gl20_shaders.rs
│   └── gl33_vao.rs
├── README.md          # Overview documentation
├── USAGE.md           # This file
└── FUNCTIONS_TABLE.md # Auto-generated function coverage

scripts/
└── generate_gl_table.py  # Table generator script
```
