# repro_harness

The files `fuzz export` copies into a finding's directory, so that the reproducer it
writes is a plain Rust project and not a script that needs this repository.

That distinction is the whole point of `findings/`. A directory there has to survive
being mailed to a driver vendor, or opened in a year on a machine that has never seen
hodow: `cargo build` and nothing else. A reproducer that shells out to `hodow_cts` is a
harness invocation, not a reproducer, and the moment the binary moves or the case tree
changes it stops answering the only question it exists for - *does this still happen?*

- `gl.rs` - an ES 3.1 context and the calls a compute reproducer needs, all through
  `dlopen`. Finding a display is the one part that is not boilerplate: the board this
  targets has a Wayland-only driver, a headless container has no compositor, and all four
  routes are tried in turn.
- `inter_invocation.rs` - the twenty `synchronization.inter_invocation.*` shaders,
  generated the way upstream generates them. Included because that one family accounts
  for most of what has been found so far, and because having the variants that *do not*
  hang in the same binary is what makes a finding a boundary rather than an assertion.

## The part a generator cannot write

`export` emits these, a `Cargo.toml`, a `justfile` that prints a verdict, a placeholder
`shader.comp` and a `main.rs` that is a skeleton, into a directory named
`NNNN-<api>-<case>---<what the driver did>` - see `findings/README.md` for the closed set
of symptoms that last part comes from, and which three of them a person has to supply. Filling that skeleton in - deciding
which of a case's several thousand lines are the ones that matter - is the work, and it
is a person's.

**Keep it short.** About twenty to thirty-five lines of `main.rs`: build the program,
allocate what it needs, dispatch, wait, count. The GLSL goes in a `.comp` file verbatim
and is `include_str!`'d, never assembled from strings in Rust - it is the part a driver
vendor reads, and they should not have to run a program to see it. `findings/0001-*` is
thirty-three lines of `main.rs` and forty-six of `shader.comp`, and is the shape to copy.

**Do not edit a finding's copy of `gl.rs`.** When one is missing a call, add it here and
copy the file back out; the first line of the copy says BOILERPLATE for that reason. What
is in it, beyond the entry points: `build_compute`, `build_render`/`draw_and_read_centre`/
`draw_triangles`/`read_target` (a fragment-shader case needs a real draw, and rewriting
one as compute changes the question - `struct.local.parameter_inout_highp` passes here as
compute and fails as a fragment shader), `compile` (a rejection is the question for a
finding about what the compiler accepts, not an obstacle), `ssbo_i32`/`read_i32`,
`image_2d`/`image_3d`/`image_cube`, `buffer` (allocating on a chosen target, which a
driver can place by), `read_layer_i32` (one layer through a framebuffer, the path the
suite uses to verify an integer image and not the same one as another compute shader),
`framebuffer_of`/`framebuffer_status_name` (renderbuffers at chosen attachment points,
for a case about completeness rather than about pixels), `buffer_variable` and `limit`
(ask the driver where it put something and what it advertises, rather than assuming),
`version`, `check`, and `step`/`die` with the exit codes the justfile reads.

**`init()` is an ES 3.1 context; `init_es(major, minor)` is any other.** A case upstream
runs on an ES 2.0 context has to be reproduced on one - the completeness rules changed at
ES 3.0, so asking the newer context gets a different and perfectly legal answer and the
reproducer reports the bug as fixed. Note a driver may answer an ES 2.0 request with an
ES 3.1 context (both Mesa and the Vivante do), so what decides which rules apply is
`version()`, not what was asked for.

**`init_es_like_suite(&[(3, 2), (3, 1)])` creates the context the way `hodow_cts` does**
on a Wayland display: newest version first, a fresh `wl_display` and EGL display per
attempt, and a refused attempt's display left initialised. On the Vivante board that
refused ES 3.2 attempt is the difference between a GPU hang and a clean run (0019), so a
case that reproduces through the suite and not through `init()` is worth retrying with it.

**A reproducer is worth nothing until it has reproduced.** The first version of `gl.rs`
was surfaceless, because compute needs no framebuffer; the case that takes the GPU down
through `hodow_cts` ran perfectly clean through it. Same shader, same dispatch, same
driver - and no hang, because the suite renders into a 256x256 pbuffer with depth and
stencil and that is evidently a different path through the driver. Run it on the board
and check the verdict before writing the README that says it reproduces.

And when it does not reproduce, that is a fact about the port and not about the driver -
go and find what the port left out. Two that mattered here: the case that only hangs when
its result buffer is mapped *without* a `glFinish` first (the map is the implicit
synchronisation, and it is what stops), and the case that hangs about one run in three,
which a single run reports as a pass.
