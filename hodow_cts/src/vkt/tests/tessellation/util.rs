// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationUtil.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only what the ported tessellation tests use: the enums and their GLSL
// names, `isPatchDiscarded`, and the point-mode `referenceVertexCount` (a count of the coordinates the reference
// generators emit, so the coordinates themselves are not built).

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum TessPrimitiveType {
    Triangles,
    Quads,
    Isolines,
}

impl TessPrimitiveType {
    pub const ALL: [TessPrimitiveType; 3] = [
        TessPrimitiveType::Triangles,
        TessPrimitiveType::Quads,
        TessPrimitiveType::Isolines,
    ];

    /// `getTessPrimitiveTypeShaderName`
    pub fn shader_name(self) -> &'static str {
        match self {
            TessPrimitiveType::Triangles => "triangles",
            TessPrimitiveType::Quads => "quads",
            TessPrimitiveType::Isolines => "isolines",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum SpacingMode {
    Equal,
    FractionalOdd,
    FractionalEven,
}

impl SpacingMode {
    pub const ALL: [SpacingMode; 3] = [
        SpacingMode::Equal,
        SpacingMode::FractionalOdd,
        SpacingMode::FractionalEven,
    ];

    /// `getSpacingModeShaderName`
    pub fn shader_name(self) -> &'static str {
        match self {
            SpacingMode::Equal => "equal_spacing",
            SpacingMode::FractionalOdd => "fractional_odd_spacing",
            SpacingMode::FractionalEven => "fractional_even_spacing",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Winding {
    Ccw,
    Cw,
}

impl Winding {
    pub const ALL: [Winding; 2] = [Winding::Ccw, Winding::Cw];

    /// `getWindingShaderName`
    pub fn shader_name(self) -> &'static str {
        match self {
            Winding::Ccw => "ccw",
            Winding::Cw => "cw",
        }
    }
}

/// `getClampedTessLevel`
pub fn get_clamped_tess_level(mode: SpacingMode, tess_level: f32) -> f32 {
    match mode {
        SpacingMode::Equal | SpacingMode::FractionalOdd => tess_level.max(1.0),
        SpacingMode::FractionalEven => tess_level.max(2.0),
    }
}

/// `getRoundedTessLevel`
pub fn get_rounded_tess_level(mode: SpacingMode, clamped_tess_level: f32) -> i32 {
    let mut result = clamped_tess_level.ceil() as i32;

    match mode {
        SpacingMode::Equal => {}
        SpacingMode::FractionalOdd => result += 1 - result % 2,
        SpacingMode::FractionalEven => result += result % 2,
    }
    result
}

/// `getClampedRoundedTessLevel`
fn get_clamped_rounded_tess_level(mode: SpacingMode, tess_level: f32) -> i32 {
    get_rounded_tess_level(mode, get_clamped_tess_level(mode, tess_level))
}

/// `numOuterTessellationLevels`
pub fn num_outer_tessellation_levels(primitive_type: TessPrimitiveType) -> usize {
    match primitive_type {
        TessPrimitiveType::Triangles => 3,
        TessPrimitiveType::Quads => 4,
        TessPrimitiveType::Isolines => 2,
    }
}

/// `isPatchDiscarded`
pub fn is_patch_discarded(primitive_type: TessPrimitiveType, outer_levels: &[f32]) -> bool {
    outer_levels[..num_outer_tessellation_levels(primitive_type)]
        .iter()
        .any(|&level| level <= 0.0)
}

/// The size of `generateReferenceTriangleTessCoords`
fn reference_triangle_tess_coord_count(
    spacing_mode: SpacingMode,
    inner: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
) -> i32 {
    if inner == 1 {
        if outer0 == 1 && outer1 == 1 && outer2 == 1 {
            3
        } else {
            reference_triangle_tess_coord_count(
                spacing_mode,
                if spacing_mode == SpacingMode::FractionalOdd {
                    3
                } else {
                    2
                },
                outer0,
                outer1,
                outer2,
            )
        }
    } else {
        let mut count = outer0 + outer1 + outer2;

        let num_inner_triangles = inner / 2;
        for inner_triangle_ndx in 0..num_inner_triangles {
            let cur_inner_triangle_level = inner - 2 * (inner_triangle_ndx + 1);
            count += if cur_inner_triangle_level == 0 {
                1
            } else {
                3 * cur_inner_triangle_level
            };
        }
        count
    }
}

/// The size of `generateReferenceQuadTessCoords`
fn reference_quad_tess_coord_count(
    spacing_mode: SpacingMode,
    inner0: i32,
    inner1: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
    outer3: i32,
) -> i32 {
    if inner0 == 1 || inner1 == 1 {
        if inner0 == 1 && inner1 == 1 && outer0 == 1 && outer1 == 1 && outer2 == 1 && outer3 == 1 {
            4
        } else {
            let fallback = if spacing_mode == SpacingMode::FractionalOdd {
                3
            } else {
                2
            };
            reference_quad_tess_coord_count(
                spacing_mode,
                if inner0 > 1 { inner0 } else { fallback },
                if inner1 > 1 { inner1 } else { fallback },
                outer0,
                outer1,
                outer2,
                outer3,
            )
        }
    } else {
        outer0 + outer1 + outer2 + outer3 + (inner1 - 1) * (inner0 - 1)
    }
}

/// The size of `generateReferenceIsolineTessCoords`
fn reference_isoline_tess_coord_count(outer0: i32, outer1: i32) -> i32 {
    outer0 * (outer1 + 1)
}

/// `referencePointModePrimitiveCount`
fn reference_point_mode_primitive_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    inner_levels: &[f32],
    outer_levels: &[f32],
) -> i32 {
    if is_patch_discarded(primitive_type, outer_levels) {
        return 0;
    }

    let rounded = |level: f32| get_clamped_rounded_tess_level(spacing_mode, level);
    match primitive_type {
        TessPrimitiveType::Triangles => reference_triangle_tess_coord_count(
            spacing_mode,
            rounded(inner_levels[0]),
            rounded(outer_levels[0]),
            rounded(outer_levels[1]),
            rounded(outer_levels[2]),
        ),
        TessPrimitiveType::Quads => reference_quad_tess_coord_count(
            spacing_mode,
            rounded(inner_levels[0]),
            rounded(inner_levels[1]),
            rounded(outer_levels[0]),
            rounded(outer_levels[1]),
            rounded(outer_levels[2]),
            rounded(outer_levels[3]),
        ),
        TessPrimitiveType::Isolines => {
            // The first outer level is always rounded with equal spacing.
            reference_isoline_tess_coord_count(
                get_clamped_rounded_tess_level(SpacingMode::Equal, outer_levels[0]),
                rounded(outer_levels[1]),
            )
        }
    }
}

/// `referenceVertexCount` with `usePointMode` true: the number of unique vertices.
pub fn reference_point_mode_vertex_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    inner_levels: &[f32],
    outer_levels: &[f32],
) -> i32 {
    reference_point_mode_primitive_count(primitive_type, spacing_mode, inner_levels, outer_levels)
}

/// `vkt::tessellation::TessLevels`
#[repr(C)]
#[derive(Clone, Copy)]
pub struct TessLevels {
    pub inner: [f32; 2],
    pub outer: [f32; 4],
}

/// `makeRenderPassWithoutAttachments`
pub fn make_render_pass_without_attachments(
    device: &vulkanalia::prelude::v1_0::Device,
) -> Result<crate::vk::ref_util::Unique<'_, vulkanalia::vk::RenderPass>, crate::tcu::TestError> {
    use vulkanalia::prelude::v1_0::*;

    use crate::vk::VkResultExt;

    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .build()];
    let info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(crate::vk::ref_util::Unique::new(device, render_pass))
}

/// `getClampedRoundedTessLevel`
pub fn clamped_rounded_tess_level(mode: SpacingMode, tess_level: f32) -> i32 {
    get_clamped_rounded_tess_level(mode, tess_level)
}

/// `getClampedRoundedTriangleTessLevels`: the inner level and the three outer ones.
pub fn clamped_rounded_triangle_tess_levels(
    spacing_mode: SpacingMode,
    inner_src: &[f32],
    outer_src: &[f32],
) -> (i32, [i32; 3]) {
    (
        get_clamped_rounded_tess_level(spacing_mode, inner_src[0]),
        [0, 1, 2].map(|i| get_clamped_rounded_tess_level(spacing_mode, outer_src[i])),
    )
}

/// `getClampedRoundedQuadTessLevels`: the two inner levels and the four outer ones.
pub fn clamped_rounded_quad_tess_levels(
    spacing_mode: SpacingMode,
    inner_src: &[f32],
    outer_src: &[f32],
) -> ([i32; 2], [i32; 4]) {
    (
        [0, 1].map(|i| get_clamped_rounded_tess_level(spacing_mode, inner_src[i])),
        [0, 1, 2, 3].map(|i| get_clamped_rounded_tess_level(spacing_mode, outer_src[i])),
    )
}

/// `getClampedRoundedIsolineTessLevels`
pub fn clamped_rounded_isoline_tess_levels(spacing_mode: SpacingMode, outer_src: &[f32]) -> [i32; 2] {
    [
        get_clamped_rounded_tess_level(SpacingMode::Equal, outer_src[0]),
        get_clamped_rounded_tess_level(spacing_mode, outer_src[1]),
    ]
}

/// `generateReferenceTriangleTessCoords`
///
/// \note The tessellation coordinates generated by this function could break some of the rules given in the spec
/// (e.g. it may not exactly hold that u+v+w == 1.0f, or [uvw] + (1.0f-[uvw]) == 1.0f).
pub fn generate_reference_triangle_tess_coords(
    spacing_mode: SpacingMode,
    inner: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
) -> Vec<[f32; 3]> {
    let mut tess_coords = Vec::new();

    if inner == 1 {
        if outer0 == 1 && outer1 == 1 && outer2 == 1 {
            tess_coords.push([1.0, 0.0, 0.0]);
            tess_coords.push([0.0, 1.0, 0.0]);
            tess_coords.push([0.0, 0.0, 1.0]);
            tess_coords
        } else {
            generate_reference_triangle_tess_coords(
                spacing_mode,
                if spacing_mode == SpacingMode::FractionalOdd {
                    3
                } else {
                    2
                },
                outer0,
                outer1,
                outer2,
            )
        }
    } else {
        for i in 0..outer0 {
            let v = i as f32 / outer0 as f32;
            tess_coords.push([0.0, v, 1.0 - v]);
        }
        for i in 0..outer1 {
            let v = i as f32 / outer1 as f32;
            tess_coords.push([1.0 - v, 0.0, v]);
        }
        for i in 0..outer2 {
            let v = i as f32 / outer2 as f32;
            tess_coords.push([v, 1.0 - v, 0.0]);
        }

        let num_inner_triangles = inner / 2;
        for inner_triangle_ndx in 0..num_inner_triangles {
            let cur_inner_triangle_level = inner - 2 * (inner_triangle_ndx + 1);

            if cur_inner_triangle_level == 0 {
                tess_coords.push([1.0 / 3.0; 3]);
            } else {
                let min_uvw = (2 * (inner_triangle_ndx + 1)) as f32 / (3 * inner) as f32;
                let max_uvw = 1.0 - 2.0 * min_uvw;
                let corners = [
                    [max_uvw, min_uvw, min_uvw],
                    [min_uvw, max_uvw, min_uvw],
                    [min_uvw, min_uvw, max_uvw],
                ];

                for i in 0..cur_inner_triangle_level {
                    let f = i as f32 / cur_inner_triangle_level as f32;
                    for j in 0..3 {
                        let a = corners[j];
                        let b = corners[(j + 1) % 3];
                        tess_coords.push([
                            (1.0 - f) * a[0] + f * b[0],
                            (1.0 - f) * a[1] + f * b[1],
                            (1.0 - f) * a[2] + f * b[2],
                        ]);
                    }
                }
            }
        }

        tess_coords
    }
}

/// `generateReferenceQuadTessCoords`
///
/// \note The tessellation coordinates generated by this function could break some of the rules given in the spec
/// (e.g. it may not exactly hold that [uv] + (1.0f-[uv]) == 1.0f).
pub fn generate_reference_quad_tess_coords(
    spacing_mode: SpacingMode,
    inner0: i32,
    inner1: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
    outer3: i32,
) -> Vec<[f32; 3]> {
    let mut tess_coords = Vec::new();

    if inner0 == 1 || inner1 == 1 {
        if inner0 == 1 && inner1 == 1 && outer0 == 1 && outer1 == 1 && outer2 == 1 && outer3 == 1 {
            tess_coords.push([0.0, 0.0, 0.0]);
            tess_coords.push([1.0, 0.0, 0.0]);
            tess_coords.push([0.0, 1.0, 0.0]);
            tess_coords.push([1.0, 1.0, 0.0]);
            tess_coords
        } else {
            let fallback = if spacing_mode == SpacingMode::FractionalOdd {
                3
            } else {
                2
            };
            generate_reference_quad_tess_coords(
                spacing_mode,
                if inner0 > 1 { inner0 } else { fallback },
                if inner1 > 1 { inner1 } else { fallback },
                outer0,
                outer1,
                outer2,
                outer3,
            )
        }
    } else {
        for i in 0..outer0 {
            let v = i as f32 / outer0 as f32;
            tess_coords.push([0.0, v, 0.0]);
        }
        for i in 0..outer1 {
            let v = i as f32 / outer1 as f32;
            tess_coords.push([1.0 - v, 0.0, 0.0]);
        }
        for i in 0..outer2 {
            let v = i as f32 / outer2 as f32;
            tess_coords.push([1.0, 1.0 - v, 0.0]);
        }
        for i in 0..outer3 {
            let v = i as f32 / outer3 as f32;
            tess_coords.push([v, 1.0, 0.0]);
        }

        for inner_vtx_y in 0..inner1 - 1 {
            for inner_vtx_x in 0..inner0 - 1 {
                tess_coords.push([
                    (inner_vtx_x + 1) as f32 / inner0 as f32,
                    (inner_vtx_y + 1) as f32 / inner1 as f32,
                    0.0,
                ]);
            }
        }

        tess_coords
    }
}

/// `generateReferenceIsolineTessCoords`
///
/// \note The tessellation coordinates generated by this function could break some of the rules given in the spec
/// (e.g. it may not exactly hold that [uv] + (1.0f-[uv]) == 1.0f).
pub fn generate_reference_isoline_tess_coords(outer0: i32, outer1: i32) -> Vec<[f32; 3]> {
    let mut tess_coords = Vec::new();

    for y in 0..outer0 {
        for x in 0..outer1 + 1 {
            tess_coords.push([x as f32 / outer1 as f32, y as f32 / outer0 as f32, 0.0]);
        }
    }

    tess_coords
}

/// `referenceTriangleNonPointModePrimitiveCount`
fn reference_triangle_non_point_mode_primitive_count(
    spacing_mode: SpacingMode,
    inner: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
) -> i32 {
    if inner == 1 {
        if outer0 == 1 && outer1 == 1 && outer2 == 1 {
            1
        } else {
            reference_triangle_non_point_mode_primitive_count(
                spacing_mode,
                if spacing_mode == SpacingMode::FractionalOdd {
                    3
                } else {
                    2
                },
                outer0,
                outer1,
                outer2,
            )
        }
    } else {
        let mut result = outer0 + outer1 + outer2;

        let num_inner_triangles = inner / 2;
        for inner_triangle_ndx in 0..num_inner_triangles {
            let cur_inner_triangle_level = inner - 2 * (inner_triangle_ndx + 1);

            if cur_inner_triangle_level == 1 {
                result += 4;
            } else {
                result += 2 * 3 * cur_inner_triangle_level;
            }
        }

        result
    }
}

/// `referenceQuadNonPointModePrimitiveCount`
fn reference_quad_non_point_mode_primitive_count(
    spacing_mode: SpacingMode,
    inner0: i32,
    inner1: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
    outer3: i32,
) -> i32 {
    if inner0 == 1 || inner1 == 1 {
        if inner0 == 1 && inner1 == 1 && outer0 == 1 && outer1 == 1 && outer2 == 1 && outer3 == 1 {
            2
        } else {
            let fallback = if spacing_mode == SpacingMode::FractionalOdd {
                3
            } else {
                2
            };
            reference_quad_non_point_mode_primitive_count(
                spacing_mode,
                if inner0 > 1 { inner0 } else { fallback },
                if inner1 > 1 { inner1 } else { fallback },
                outer0,
                outer1,
                outer2,
                outer3,
            )
        }
    } else {
        2 * (inner0 - 2) * (inner1 - 2) + 2 * (inner0 - 2) + 2 * (inner1 - 2) + outer0 + outer1 + outer2 + outer3
    }
}

/// `referenceNonPointModePrimitiveCount`
fn reference_non_point_mode_primitive_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    inner_levels: &[f32],
    outer_levels: &[f32],
) -> i32 {
    if is_patch_discarded(primitive_type, outer_levels) {
        return 0;
    }

    let rounded = |level: f32| get_clamped_rounded_tess_level(spacing_mode, level);
    match primitive_type {
        TessPrimitiveType::Triangles => reference_triangle_non_point_mode_primitive_count(
            spacing_mode,
            rounded(inner_levels[0]),
            rounded(outer_levels[0]),
            rounded(outer_levels[1]),
            rounded(outer_levels[2]),
        ),
        TessPrimitiveType::Quads => reference_quad_non_point_mode_primitive_count(
            spacing_mode,
            rounded(inner_levels[0]),
            rounded(inner_levels[1]),
            rounded(outer_levels[0]),
            rounded(outer_levels[1]),
            rounded(outer_levels[2]),
            rounded(outer_levels[3]),
        ),
        TessPrimitiveType::Isolines => {
            // The first outer level is always rounded with equal spacing.
            get_clamped_rounded_tess_level(SpacingMode::Equal, outer_levels[0]) * rounded(outer_levels[1])
        }
    }
}

/// `numVerticesPerPrimitive`
pub fn num_vertices_per_primitive(primitive_type: TessPrimitiveType, use_point_mode: bool) -> i32 {
    if use_point_mode {
        return 1;
    }

    match primitive_type {
        TessPrimitiveType::Triangles => 3,
        // quads are composed of two triangles
        TessPrimitiveType::Quads => 3,
        TessPrimitiveType::Isolines => 2,
    }
}

/// `referencePrimitiveCount`
pub fn reference_primitive_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    use_point_mode: bool,
    inner_levels: &[f32],
    outer_levels: &[f32],
) -> i32 {
    if use_point_mode {
        reference_point_mode_primitive_count(primitive_type, spacing_mode, inner_levels, outer_levels)
    } else {
        reference_non_point_mode_primitive_count(primitive_type, spacing_mode, inner_levels, outer_levels)
    }
}

/// `referenceVertexCount` - in point mode the number of unique vertices, in non-point mode the maximum theoretical number of vertices.
pub fn reference_vertex_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    use_point_mode: bool,
    inner_levels: &[f32],
    outer_levels: &[f32],
) -> i32 {
    let primitive_count = if use_point_mode {
        reference_point_mode_primitive_count(primitive_type, spacing_mode, inner_levels, outer_levels)
    } else {
        reference_non_point_mode_primitive_count(primitive_type, spacing_mode, inner_levels, outer_levels)
    };
    primitive_count * num_vertices_per_primitive(primitive_type, use_point_mode)
}
