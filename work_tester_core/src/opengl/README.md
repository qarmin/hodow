OpenGL support (work_tester_core)

This folder contains helpers to initialize an OpenGL context and load GL
functions for GPU-backed tests. The implementation here is intentionally
minimal — expand to add more tests and capabilities.

Implemented functions and extensions (grouped by version)

GL ES 2.0 / GL 2.0
- [x] Basic shader compilation (implemented)
- [ ] Vertex buffer objects
- [ ] Textures

GL 3.3 / GL ES 3.0
- [ ] Instanced rendering
- [ ] Transform feedback

GL 4.5
- [ ] Direct state access

Notes:
- The `gpu` feature in Cargo controls whether this module is compiled.
- When the feature is disabled, a lightweight stub implementation is
  provided (see the crate root `lib.rs`).

