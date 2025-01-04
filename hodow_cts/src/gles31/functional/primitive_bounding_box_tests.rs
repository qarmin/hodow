// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fPrimitiveBoundingBoxTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `state_query` sub-group is
// ported here; `triangles` (and the line/point groups as they land) live in
// `primitive_bounding_box_render_tests.rs`, and `depth`, `blit_fbo`, `clear` and
// `call_order` in `primitive_bounding_box_misc_tests.rs`.
//
// Upstream's `getBoundingBoxFunction` exists only so a *desktop* GL context can resolve
// `glPrimitiveBoundingBoxARB` by hand; on an ES context it returns
// `funcs.primitiveBoundingBox`, which is the only case this port can reach, so the
// helper collapses into a direct call.

use crate::gls::state_query_util::{Guarded, QueryValue, round_half_down, round_half_up};
use crate::glu::{ApiCase, Context, TestCaseGroup, add_api_case};
use crate::glw;
use crate::tcu::Random;

/// `BoundingBox` - `min` in components 0..4, `max` in components 4..8, which is the
/// order `getComponentAccess` gives them and the order every query returns them in.
#[derive(Clone, Copy)]
struct BoundingBox {
    components: [f32; 8],
}

impl BoundingBox {
    const fn new(min: [f32; 4], max: [f32; 4]) -> Self {
        Self {
            components: [min[0], min[1], min[2], min[3], max[0], max[1], max[2], max[3]],
        }
    }

    /// `getComponentAccess`
    const fn component(&self, ndx: usize) -> f32 {
        self.components[ndx]
    }
}

/// `boundingBoxSupported`
///
/// Upstream also accepts a desktop `core(4, 5)` context carrying
/// `GL_ARB_ES3_2_compatibility`; this port only ever creates ES contexts, so that
/// branch cannot be reached and is not written out.
fn bounding_box_supported(context: &Context) -> bool {
    context.context_type().supports(3, 2)
        || context
            .context_info
            .is_extension_supported("GL_EXT_primitive_bounding_box")
}

/// `InitialValueCase::init` / `QueryCase::init`
fn require_support(case: &mut ApiCase<'_>) -> bool {
    if bounding_box_supported(case.context()) {
        return true;
    }
    case.not_supported("Test requires GL_EXT_primitive_bounding_box extension");
    false
}

/// `resetBoundingBox`
fn reset_bounding_box(case: &mut ApiCase<'_>) {
    // SAFETY: eight scalars, on a context that has the entry point.
    unsafe {
        case.gl()
            .primitive_bounding_box(-1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
    };
}

/// Reads the eight-component bounding box state through `query`, reporting a driver
/// that wrote nothing or wrote out of bounds exactly as `verifyValidity` does.
fn query_bbox<T: QueryValue + std::fmt::Debug>(
    case: &mut ApiCase<'_>,
    query: impl FnOnce(&glw::Functions, *mut T),
) -> Option<[T; 8]> {
    let mut state = Guarded::<[T; 8]>::new();
    query(case.gl(), state.as_mut_ptr().cast::<T>());
    case.expect_no_error("query");
    if !state.verify_validity(case) {
        return None;
    }
    Some(state.value())
}

/// `InitialValueCase::iterate`
fn initial_value_case(case: &mut ApiCase<'_>) {
    if !require_support(case) {
        return;
    }

    case.section("Querying GL_PRIMITIVE_BOUNDING_BOX_EXT, expecting (-1, -1, -1, 1) (1, 1, 1, 1)");

    // SAFETY: eight GLfloats out, guarded on each side.
    let Some(state) = query_bbox::<f32>(case, |gl, ptr| unsafe {
        gl.get_floatv(glw::GL_PRIMITIVE_BOUNDING_BOX_EXT, ptr)
    }) else {
        return;
    };

    log::debug!("Got {state:?}");

    if state != [-1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0] {
        case.fail(format!("unexpected value {state:?}"), "Invalid initial value");
    }
}

/// `QueryCase::QueryMethod`
#[derive(Clone, Copy, PartialEq, Eq)]
enum QueryMethod {
    Float,
    Boolean,
    Int,
    Int64,
}

/// `QueryCase::verifyState`
fn verify_state(case: &mut ApiCase<'_>, method: QueryMethod, bbox: &BoundingBox) -> bool {
    match method {
        QueryMethod::Float => {
            // SAFETY: eight GLfloats out, guarded on each side.
            let Some(state) = query_bbox::<f32>(case, |gl, ptr| unsafe {
                gl.get_floatv(glw::GL_PRIMITIVE_BOUNDING_BOX_EXT, ptr)
            }) else {
                return false;
            };
            log::debug!("glGetFloatv returned {state:?}");

            if (0..8).any(|ndx| state[ndx] != bbox.component(ndx)) {
                case.fail(
                    format!("unexpected value {state:?}, expected {:?}", bbox.components),
                    "Unexpected query result",
                );
                return false;
            }
            true
        }
        QueryMethod::Int => {
            // SAFETY: eight GLints out, guarded on each side.
            let Some(state) = query_bbox::<i32>(case, |gl, ptr| unsafe {
                gl.get_integerv(glw::GL_PRIMITIVE_BOUNDING_BOX_EXT, ptr)
            }) else {
                return false;
            };
            log::debug!("glGetIntegerv returned {state:?}");

            let error = (0..8).any(|ndx| {
                let value = f64::from(state[ndx]);
                value != f64::from(round_half_down(bbox.component(ndx)))
                    && value != f64::from(round_half_up(bbox.component(ndx)))
            });
            if error {
                case.fail(
                    format!("unexpected value {state:?}, expected {}", expected_rounded_str(bbox)),
                    "Unexpected query result",
                );
                return false;
            }
            true
        }
        QueryMethod::Int64 => {
            // SAFETY: eight GLint64s out, guarded on each side.
            let Some(state) = query_bbox::<i64>(case, |gl, ptr| unsafe {
                gl.get_integer_64v(glw::GL_PRIMITIVE_BOUNDING_BOX_EXT, ptr)
            }) else {
                return false;
            };
            log::debug!("glGetInteger64v returned {state:?}");

            #[expect(
                clippy::cast_precision_loss,
                reason = "upstream compares the GLint64 against the rounded float directly"
            )]
            let error = (0..8).any(|ndx| {
                let value = state[ndx] as f32;
                value != round_half_down(bbox.component(ndx)) && value != round_half_up(bbox.component(ndx))
            });
            if error {
                case.fail(
                    format!("unexpected value {state:?}, expected {}", expected_rounded_str(bbox)),
                    "Unexpected query result",
                );
                return false;
            }
            true
        }
        QueryMethod::Boolean => {
            // SAFETY: eight GLbooleans out, guarded on each side.
            let Some(state) = query_bbox::<u8>(case, |gl, ptr| unsafe {
                gl.get_booleanv(glw::GL_PRIMITIVE_BOUNDING_BOX_EXT, ptr)
            }) else {
                return false;
            };
            log::debug!("glGetBooleanv returned {state:?}");

            let expected = |ndx: usize| {
                if bbox.component(ndx) != 0.0 {
                    glw::TRUE
                } else {
                    glw::FALSE
                }
            };
            if (0..8).any(|ndx| state[ndx] != expected(ndx)) {
                let want: Vec<&str> = (0..8)
                    .map(|ndx| {
                        if expected(ndx) == glw::TRUE {
                            "GL_TRUE"
                        } else {
                            "GL_FALSE"
                        }
                    })
                    .collect();
                case.fail(
                    format!("unexpected value {state:?}, expected [{}]", want.join(", ")),
                    "Unexpected query result",
                );
                return false;
            }
            true
        }
    }
}

/// The `Expected [...]` line upstream's integer branches build, where a component whose
/// two roundings differ prints as `{down, up}`.
fn expected_rounded_str(bbox: &BoundingBox) -> String {
    let parts: Vec<String> = (0..8)
        .map(|ndx| {
            let down = round_half_down(bbox.component(ndx));
            let up = round_half_up(bbox.component(ndx));
            if down == up {
                format!("{down}")
            } else {
                format!("{{{down}, {up}}}")
            }
        })
        .collect();
    format!("[{}]", parts.join(", "))
}

/// `QueryCase::iterate`
fn query_case(case: &mut ApiCase<'_>, method: QueryMethod) {
    if !require_support(case) {
        return;
    }

    const FIXED_CASES: [BoundingBox; 6] = [
        BoundingBox::new([0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]),
        BoundingBox::new([-0.0, -0.0, -0.0, -0.0], [0.0, 0.0, 0.0, -0.0]),
        BoundingBox::new([0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, -1.0]),
        BoundingBox::new([2.0, 2.0, 2.0, 2.0], [1.5, 1.5, 1.5, 1.0]),
        BoundingBox::new([1.0, 1.0, 1.0, 1.0], [-1.0, -1.0, -1.0, -1.0]),
        BoundingBox::new([1.0, 1.0, 1.0, 0.3], [-1.0, -1.0, -1.0, -1.2]),
    ];
    const NUM_RANDOM_CASES: usize = 9;

    let mut rnd = Random::new(0x00DE_3210);
    let mut cases: Vec<BoundingBox> = FIXED_CASES.to_vec();

    for _ in 0..NUM_RANDOM_CASES {
        let mut bounding_box = BoundingBox::new([0.0; 4], [0.0; 4]);

        // parameter evaluation order is not guaranteed, cannot just do "max = (rand(), rand(), ...)
        for coord_ndx in 0..8 {
            bounding_box.components[coord_ndx] = rnd.get_float_range(-4.0, 4.0);
        }

        cases.push(bounding_box);
    }

    for (case_ndx, bounding_box) in cases.iter().enumerate() {
        case.section(&format!("Iteration {}", case_ndx + 1));

        // SAFETY: eight scalars, on a context that has the entry point.
        unsafe {
            case.gl().primitive_bounding_box(
                bounding_box.component(0),
                bounding_box.component(1),
                bounding_box.component(2),
                bounding_box.component(3),
                bounding_box.component(4),
                bounding_box.component(5),
                bounding_box.component(6),
                bounding_box.component(7),
            );
        }

        verify_state(case, method, bounding_box);
    }

    reset_bounding_box(case);
}

/// `PrimitiveBoundingBoxTests::init`'s `.state_query` sub-group.
fn state_query_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("state_query");

    add_api_case(&mut group, "initial_value", initial_value_case);
    for (name, method) in [
        ("getfloat", QueryMethod::Float),
        ("getboolean", QueryMethod::Boolean),
        ("getinteger", QueryMethod::Int),
        ("getinteger64", QueryMethod::Int64),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| query_case(case, method));
    }

    group
}

/// `PrimitiveBoundingBoxTests::init`, restricted to the groups that are ported.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("primitive_bounding_box");
    group.add_child(state_query_group());
    super::primitive_bounding_box_render_tests::add_groups(&mut group);
    super::primitive_bounding_box_misc_tests::add_groups(&mut group);
    group
}
