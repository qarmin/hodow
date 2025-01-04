// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fPrimitiveBoundingBoxTests.cpp (PointRenderCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `points` and `wide_points` groups.
// `m_attribData` is regenerated on demand (`generate_attribute_data` is a pure function
// of nothing) instead of being cached on the case. The desktop-only
// `GL_PROGRAM_POINT_SIZE` branch is not written out (this port only creates ES contexts).
// Pixel probes outside the surface read as "no hit" instead of upstream's out-of-bounds
// read.

use super::primitive_bounding_box_render_tests::{
    BBoxSizeKind, Common, IterationConfig, Pattern, ProjectedBBox, Resources, ShaderFunction, VA_NUM_ATTRIB_VECS, Vec4,
    Warning, gen_shader_function, generate_random_config, get_viewport_bounding_box_area, project_bounding_box,
    read_viewport, setup_render,
};
use crate::glu::ApiCase;
use crate::glw;
use crate::tcu::Random;
use crate::tcu::surface::Surface;

#[derive(Clone, Copy)]
struct GeneratedPoint {
    center: [f32; 2],
    size: i32,
    even: bool,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ResultPointType {
    Full,
    Partial,
}

pub struct PointPattern {
    num_stripes: i32,
    is_wide_point_case: bool,
}

impl PointPattern {
    pub fn new(wide: bool) -> Self {
        Self {
            num_stripes: 4,
            is_wide_point_case: wide,
        }
    }

    fn channel(viewport: &Surface, x: i32, y: i32, component_ndx: usize) -> i32 {
        if x < 0 || y < 0 || x >= viewport.get_width() || y >= viewport.get_height() {
            return 0;
        }
        let pixel = viewport.get_pixel(x, y);
        match component_ndx {
            0 => pixel.get_red(),
            1 => pixel.get_green(),
            2 => pixel.get_blue(),
            _ => pixel.get_alpha(),
        }
    }

    /// `generateAttributeData`
    fn generate_attribute_data(&self) -> Vec<Vec4> {
        let green: Vec4 = [0.0, 1.0, 0.0, 1.0];
        let blue: Vec4 = [0.0, 0.0, 1.0, 1.0];
        let n = self.num_stripes;
        let mut cell_order: Vec<i32> = (0..n * n * 2).collect();
        let mut rnd = Random::new(0xDE22446);

        rnd.shuffle(&mut cell_order);

        let mut data: Vec<Vec4> = vec![[0.0; 4]; cell_order.len() * 2];
        for (ndx, &point_id) in cell_order.iter().enumerate() {
            let direction = point_id & 0x01;
            let major_coord = (point_id >> 1) / n;
            let minor_coord = (point_id >> 1) % n;

            if direction != 0 {
                data[ndx * VA_NUM_ATTRIB_VECS] =
                    [minor_coord as f32 / n as f32, major_coord as f32 / n as f32, 0.0, 1.0];
                data[ndx * VA_NUM_ATTRIB_VECS + 1] = green;
            } else {
                data[ndx * VA_NUM_ATTRIB_VECS] = [
                    (major_coord as f32 + 0.5) / n as f32,
                    (minor_coord as f32 + 0.5) / n as f32,
                    0.0,
                    1.0,
                ];
                data[ndx * VA_NUM_ATTRIB_VECS + 1] = blue;
            }
        }
        data
    }

    /// `genReferencePointData`
    fn gen_reference_point_data(&self, c: &Common, config: &IterationConfig) -> Vec<GeneratedPoint> {
        let attrib_data = self.generate_attribute_data();

        // vertex shader
        let mut current_points: Vec<GeneratedPoint> = (0..attrib_data.len() / 2)
            .map(|ndx| {
                let even = attrib_data[ndx * 2 + 1][1] == 1.0; // is green
                GeneratedPoint {
                    center: [attrib_data[ndx * 2][0], attrib_data[ndx * 2][1]],
                    even,
                    size: if self.is_wide_point_case {
                        if even { 5 } else { 3 }
                    } else {
                        1
                    },
                }
            })
            .collect();

        // tessellation
        if c.has_tessellation_stage {
            let mut tessellated_points = Vec::with_capacity(current_points.len() * 4);
            for p in &current_points {
                let position = [p.center[0], 1.0 - p.center[1]]; // mirror Y

                for (dx, dy) in [(-0.07, -0.07), (0.07, -0.07), (0.07, 0.07), (-0.07, 0.07)] {
                    tessellated_points.push(GeneratedPoint {
                        center: [position[0] + dx, position[1] + dy],
                        size: p.size,
                        even: p.even,
                    });
                }
            }
            current_points = tessellated_points;
        }

        // geometry
        if c.has_geometry_stage {
            let mut geometry_shaded_points = Vec::with_capacity(current_points.len() * 3);
            for p in &current_points {
                let position = [1.0 - p.center[0], p.center[1]]; // mirror X

                for (dx, dy) in [(0.05, 0.03), (-0.01, -0.02), (-0.05, 0.02)] {
                    geometry_shaded_points.push(GeneratedPoint {
                        center: [position[0] + dx, position[1] + dy],
                        size: p.size,
                        even: p.even,
                    });
                }
            }
            current_points = geometry_shaded_points;
        }

        // sort from left to right, top to bottom (`PointSorter`)
        current_points.sort_by(|a, b| {
            if a.center[1] < b.center[1] {
                std::cmp::Ordering::Less
            } else if a.center[1] > b.center[1] {
                std::cmp::Ordering::Greater
            } else {
                a.center[0]
                    .partial_cmp(&b.center[0])
                    .unwrap_or(std::cmp::Ordering::Equal)
            }
        });

        // map to pattern space
        for p in &mut current_points {
            p.center = [
                p.center[0] * config.pattern_size[0] + config.pattern_pos[0],
                p.center[1] * config.pattern_size[1] + config.pattern_pos[1],
            ];
        }

        current_points
    }

    /// `verifyNarrowPointPattern`; returns "any error".
    fn verify_narrow_point_pattern(
        viewport: &Surface,
        ref_points: &[GeneratedPoint],
        bbox: &ProjectedBBox,
        log_flood_counter: &mut i32,
    ) -> bool {
        let mut any_error = false;

        // check that there is something near each sample
        for ref_point in ref_points {
            let epsilon = 1.0e-6f32;

            // skip points not in the the bbox, treat boundary as "in"
            if ref_point.center[0] < bbox.min[0] - epsilon
                || ref_point.center[1] < bbox.min[1] - epsilon
                || ref_point.center[0] > bbox.max[0] + epsilon
                || ref_point.center[1] > bbox.max[1] + epsilon
            {
                continue;
            }

            // transform to viewport coords
            let pixel_center = [
                ((ref_point.center[0] * 0.5 + 0.5) * viewport.get_width() as f32).round() as i32,
                ((ref_point.center[1] * 0.5 + 0.5) * viewport.get_height() as f32).round() as i32,
            ];

            // find rasterized point in the result
            if pixel_center[0] < 1
                || pixel_center[1] < 1
                || pixel_center[0] >= viewport.get_width() - 1
                || pixel_center[1] >= viewport.get_height() - 1
            {
                // viewport boundary, assume point is fine
                continue;
            }

            let component_ndx = if ref_point.even { 1 } else { 2 }; // analyze either green or blue channel
            let mut found_result = false;

            // check neighborhood
            'search: for dy in -1..2 {
                for dx in -1..2 {
                    if Self::channel(viewport, pixel_center[0] + dx, pixel_center[1] + dy, component_ndx) > 0 {
                        found_result = true;
                        break 'search;
                    }
                }
            }

            if !found_result {
                any_error = true;

                *log_flood_counter -= 1;
                if *log_flood_counter >= 0 {
                    log::debug!(
                        "Missing point near {pixel_center:?}, vertex coordinates={:?}.",
                        ref_point.center
                    );
                }
            }
        }

        any_error
    }

    /// `verifyWidePointPattern`; returns "any error".
    fn verify_wide_point_pattern(
        &self,
        viewport: &Surface,
        ref_points: &[GeneratedPoint],
        bbox: &ProjectedBBox,
        log_flood_counter: &mut i32,
    ) -> bool {
        let mut any_error = false;

        // check that there is something near each sample
        for ref_point in ref_points {
            if ref_point.center[0] >= bbox.min[0]
                && ref_point.center[1] >= bbox.min[1]
                && ref_point.center[0] <= bbox.max[0]
                && ref_point.center[1] <= bbox.max[1]
            {
                // point fully in the bounding box
                any_error |=
                    !Self::verify_wide_point(viewport, ref_point, bbox, ResultPointType::Full, log_flood_counter);
            } else if ref_point.center[0] >= bbox.min[0] + ref_point.size as f32 / 2.0
                && ref_point.center[1] >= bbox.min[1] - ref_point.size as f32 / 2.0
                && ref_point.center[0] <= bbox.max[0] + ref_point.size as f32 / 2.0
                && ref_point.center[1] <= bbox.max[1] - ref_point.size as f32 / 2.0
            {
                // point leaks into bounding box
                any_error |=
                    !Self::verify_wide_point(viewport, ref_point, bbox, ResultPointType::Partial, log_flood_counter);
            }
        }

        any_error
    }

    /// `verifyWidePoint`; true when the point is fine.
    fn verify_wide_point(
        viewport: &Surface,
        ref_point: &GeneratedPoint,
        bbox: &ProjectedBBox,
        point_type: ResultPointType,
        log_flood_counter: &mut i32,
    ) -> bool {
        let component_ndx = if ref_point.even { 1 } else { 2 };
        let half_point_size_ceil = (ref_point.size + 1) / 2;
        let half_point_size_floor = (ref_point.size + 1) / 2;
        let viewport_bbox_area = get_viewport_bounding_box_area(
            bbox,
            [viewport.get_width(), viewport.get_height()],
            ref_point.size as f32,
        );
        let verification_area = [
            viewport_bbox_area[0].max(0),
            viewport_bbox_area[1].max(0),
            viewport_bbox_area[2].min(viewport.get_width()),
            viewport_bbox_area[3].min(viewport.get_height()),
        ];
        let point_pos = [
            ((ref_point.center[0] * 0.5 + 0.5) * viewport.get_width() as f32).round() as i32,
            ((ref_point.center[1] * 0.5 + 0.5) * viewport.get_height() as f32).round() as i32,
        ];

        // find any fragment within the point that is inside the bbox, start search at the center

        if point_pos[0] >= verification_area[0]
            && point_pos[1] >= verification_area[1]
            && point_pos[0] < verification_area[2]
            && point_pos[1] < verification_area[3]
            && Self::channel(viewport, point_pos[0], point_pos[1], component_ndx) != 0
        {
            return Self::verify_wide_point_at(
                point_pos,
                viewport,
                ref_point,
                verification_area,
                point_type,
                component_ndx,
                log_flood_counter,
            );
        }

        for dy in -half_point_size_ceil..=half_point_size_ceil {
            for dx in -half_point_size_ceil..=half_point_size_ceil {
                let test_pos = [point_pos[0] + dx, point_pos[1] + dy];

                if dx == 0 && dy == 0 {
                    continue;
                }

                if test_pos[0] >= verification_area[0]
                    && test_pos[1] >= verification_area[1]
                    && test_pos[0] < verification_area[2]
                    && test_pos[1] < verification_area[3]
                    && Self::channel(viewport, test_pos[0], test_pos[1], component_ndx) != 0
                {
                    return Self::verify_wide_point_at(
                        test_pos,
                        viewport,
                        ref_point,
                        verification_area,
                        point_type,
                        component_ndx,
                        log_flood_counter,
                    );
                }
            }
        }

        // could not find point, this is only ok near boundaries
        if point_pos[0] + half_point_size_floor < verification_area[0] - 1
            || point_pos[1] + half_point_size_floor < verification_area[1] - 1
            || point_pos[0] - half_point_size_floor >= verification_area[2] - 1
            || point_pos[1] - half_point_size_floor >= verification_area[3] - 1
        {
            return true;
        }

        *log_flood_counter -= 1;
        if *log_flood_counter >= 0 {
            log::debug!(
                "Missing wide point near {point_pos:?}, vertex coordinates={:?}.",
                ref_point.center
            );
        }

        false
    }

    /// `verifyWidePointAt`; true when the point is fine.
    fn verify_wide_point_at(
        point_pos: [i32; 2],
        viewport: &Surface,
        ref_point: &GeneratedPoint,
        bbox: [i32; 4],
        point_type: ResultPointType,
        component_ndx: usize,
        log_flood_counter: &mut i32,
    ) -> bool {
        let expected_point_size = ref_point.size;
        let mut viewport_clipped_top = false;
        let mut viewport_clipped_bottom = false;
        let mut primitive_clipped_top = false;
        let mut primitive_clipped_bottom = false;
        let mut widths_upwards: Vec<[i32; 2]> = Vec::new();
        let mut widths_downwards: Vec<[i32; 2]> = Vec::new();

        // search upwards
        let mut y = point_pos[1];
        loop {
            if y < bbox[1] || y < 0 {
                if y < bbox[1] {
                    primitive_clipped_top = true;
                }
                if y < 0 {
                    viewport_clipped_top = true;
                }
                break;
            } else if point_pos[1] - y > expected_point_size {
                // no need to go further than point height
                break;
            } else if Self::channel(viewport, point_pos[0], y, component_ndx) == 0 {
                break;
            } else {
                widths_upwards.push(Self::scan_point_width_at(
                    [point_pos[0], y],
                    viewport,
                    expected_point_size,
                    component_ndx,
                ));
            }
            y -= 1;
        }

        // top is clipped
        if (viewport_clipped_top || (point_type == ResultPointType::Partial && primitive_clipped_top))
            && !widths_upwards.is_empty()
        {
            let range = widths_upwards[widths_upwards.len() - 1];
            let square_fits = (range[1] - range[0] + 1) >= expected_point_size;
            let width_clipped = point_type == ResultPointType::Partial && (range[0] <= bbox[0] || range[1] >= bbox[2]);

            if square_fits || width_clipped {
                return true;
            }
        }

        // and downwards
        let mut y = point_pos[1] + 1;
        loop {
            if y >= bbox[3] || y >= viewport.get_height() {
                if y >= bbox[3] {
                    primitive_clipped_bottom = true;
                }
                if y >= viewport.get_height() {
                    viewport_clipped_bottom = true;
                }
                break;
            } else if y - point_pos[1] > expected_point_size {
                // no need to go further than point height
                break;
            } else if Self::channel(viewport, point_pos[0], y, component_ndx) == 0 {
                break;
            } else {
                widths_downwards.push(Self::scan_point_width_at(
                    [point_pos[0], y],
                    viewport,
                    expected_point_size,
                    component_ndx,
                ));
            }
            y += 1;
        }

        // bottom is clipped
        if (viewport_clipped_bottom || (point_type == ResultPointType::Partial && primitive_clipped_bottom))
            && !(widths_downwards.is_empty() && widths_upwards.is_empty())
        {
            let range = if widths_downwards.is_empty() {
                widths_upwards[0]
            } else {
                widths_downwards[widths_downwards.len() - 1]
            };
            let square_fits = (range[1] - range[0] + 1) >= expected_point_size;
            let bbox_clipped =
                point_type == ResultPointType::Partial && (range[0] <= bbox[0] || range[1] >= bbox[2] - 1);
            let viewport_clipped = range[0] <= 0 || range[1] >= viewport.get_width() - 1;

            if square_fits || bbox_clipped || viewport_clipped {
                return true;
            }
        }

        // would square point would fit into the rasterized area

        let mut widths: Vec<[i32; 2]> = widths_upwards.iter().rev().copied().collect();
        widths.extend(widths_downwards.iter().copied());

        for y in 0..(widths.len() as i32 - expected_point_size + 1) {
            let mut union_range = widths[y as usize];

            for dy in 1..expected_point_size {
                union_range[0] = union_range[0].max(widths[(y + dy) as usize][0]);
                union_range[1] = union_range[1].min(widths[(y + dy) as usize][1]);
            }

            // would a N x N block fit here?
            let square_fits = (union_range[1] - union_range[0] + 1) >= expected_point_size;
            let bbox_clipped =
                point_type == ResultPointType::Partial && (union_range[0] <= bbox[0] || union_range[1] >= bbox[2] - 1);
            let viewport_clipped = union_range[0] <= 0 || union_range[1] >= viewport.get_width() - 1;

            if square_fits || bbox_clipped || viewport_clipped {
                return true;
            }
        }

        *log_flood_counter -= 1;
        if *log_flood_counter >= 0 {
            log::debug!(
                "Missing {expected_point_size}x{expected_point_size} point near {point_pos:?}, vertex coordinates={:?}.",
                ref_point.center
            );
        }
        false
    }

    /// `scanPointWidthAt`
    fn scan_point_width_at(
        point_pos: [i32; 2],
        viewport: &Surface,
        expected_point_size: i32,
        component_ndx: usize,
    ) -> [i32; 2] {
        let mut min_x = point_pos[0];
        let mut max_x = point_pos[0];

        // search horizontally for a point edges
        let mut x = point_pos[0] - 1;
        while x >= 0 {
            if Self::channel(viewport, x, point_pos[1], component_ndx) == 0 {
                break;
            }

            // no need to go further than point width
            if point_pos[0] - x > expected_point_size {
                break;
            }

            min_x = x;
            x -= 1;
        }
        let mut x = point_pos[0] + 1;
        while x < viewport.get_width() {
            if Self::channel(viewport, x, point_pos[1], component_ndx) == 0 {
                break;
            }

            // no need to go further than point width
            if x - point_pos[0] > expected_point_size {
                break;
            }

            max_x = x;
            x += 1;
        }

        [min_x, max_x]
    }
}

impl Pattern for PointPattern {
    fn check_support(&self, case: &mut ApiCase<'_>, common: &Common) -> bool {
        if self.is_wide_point_case {
            // extensions
            if common.has_geometry_stage
                && !case
                    .context()
                    .context_info
                    .is_extension_supported("GL_EXT_geometry_point_size")
            {
                case.not_supported("Test requires GL_EXT_geometry_point_size extension");
                return false;
            }
            if common.has_tessellation_stage
                && !common.has_geometry_stage
                && !case
                    .context()
                    .context_info
                    .is_extension_supported("GL_EXT_tessellation_point_size")
            {
                case.not_supported("Test requires GL_EXT_tessellation_point_size extension");
                return false;
            }

            // point size range
            let mut point_size_range = [0.0f32; 2];
            // SAFETY: two floats out.
            unsafe {
                case.gl()
                    .get_floatv(glw::GL_ALIASED_POINT_SIZE_RANGE, point_size_range.as_mut_ptr())
            };

            if point_size_range[1] < 5.0 {
                case.not_supported("Test requires point size 5.0");
                return false;
            }
        }
        true
    }

    fn gen_vertex_source(&self, c: &Common) -> String {
        let geo = c.geo_infix();
        let mut buf = String::from(
            "${GLSL_VERSION_DECL}\n\
             in highp vec4 a_position;\n\
             in highp vec4 a_color;\n\
             out highp vec4 vtx_color;\n\
             uniform highp vec4 u_posScale;\n\
             \n",
        );
        if !c.has_tessellation_stage {
            buf.push_str(&format!(
                "uniform highp vec4 u_primitiveBBoxMin;\n\
                 uniform highp vec4 u_primitiveBBoxMax;\n\
                 \n\
                 flat out highp float v_{geo}bbox_expansionSize;\n\
                 flat out highp vec3 v_{geo}bbox_clipMin;\n\
                 flat out highp vec3 v_{geo}bbox_clipMax;\n\
                 \n"
            ));
        }

        buf.push_str(&format!(
            "void main()\n\
             {{\n\
             \x20   highp vec2 patternOffset = u_posScale.xy;\n\
             \x20   highp vec2 patternScale = u_posScale.zw;\n\
             \x20   highp float pointSize = {};\n\
             \x20   gl_Position = vec4(a_position.xy * patternScale + patternOffset, a_position.z, a_position.w);\n\
             \x20   gl_PointSize = pointSize;\n\
             \x20   vtx_color = a_color;\n",
            if self.is_wide_point_case && !c.has_tessellation_stage && !c.has_geometry_stage {
                "(a_color.g > 0.0) ? (5.0) : (3.0)"
            } else {
                "1.0"
            }
        ));

        if !c.has_tessellation_stage {
            buf.push_str(&format!(
                "\n\
                 \x20   v_{geo}bbox_expansionSize = pointSize;\n\
                 \x20   v_{geo}bbox_clipMin =\n\
                 \x20       min(vec3(u_primitiveBBoxMin.x, u_primitiveBBoxMin.y, u_primitiveBBoxMin.z) / u_primitiveBBoxMin.w,\n\
                 \x20           vec3(u_primitiveBBoxMin.x, u_primitiveBBoxMin.y, u_primitiveBBoxMin.z) / u_primitiveBBoxMax.w);\n\
                 \x20   v_{geo}bbox_clipMax =\n\
                 \x20       min(vec3(u_primitiveBBoxMax.x, u_primitiveBBoxMax.y, u_primitiveBBoxMax.z) / u_primitiveBBoxMin.w,\n\
                 \x20           vec3(u_primitiveBBoxMax.x, u_primitiveBBoxMax.y, u_primitiveBBoxMax.z) / u_primitiveBBoxMax.w);\n"
            ));
        }

        buf.push_str("}\n");
        buf
    }

    fn gen_fragment_source(&self, c: &Common) -> String {
        let color_input_name = if c.has_geometry_stage {
            "geo_color"
        } else if c.has_tessellation_stage {
            "tess_color"
        } else {
            "vtx_color"
        };

        format!(
            "${{GLSL_VERSION_DECL}}\n\
             in mediump vec4 {color_input_name};\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             {}\n\
             void main()\n\
             {{\n\
             \x20   mediump vec4 baseColor = {color_input_name};\n\
             \x20   mediump float redChannel;\n\
             \x20   if (fragmentInsideTheBBox(gl_FragCoord.z))\n\
             \x20       redChannel = 0.0;\n\
             \x20   else\n\
             \x20       redChannel = 1.0;\n\
             \x20   o_color = vec4(redChannel, baseColor.g, baseColor.b, baseColor.a);\n\
             }}\n",
            gen_shader_function(ShaderFunction::InsideBBox)
        )
    }

    fn gen_tessellation_control_source(&self, c: &Common) -> String {
        let tessellation_wide_points = self.is_wide_point_case && !c.has_geometry_stage;
        let mut buf = format!(
            "${{GLSL_VERSION_DECL}}\n\
             ${{ARB_ES32_COMPATIBILITY_REQUIRE}}\n\
             ${{TESSELLATION_SHADER_REQUIRE}}\n\
             ${{PRIMITIVE_BOUNDING_BOX_REQUIRE}}\n\
             {}layout(vertices=1) out;\
             \n\
             in highp vec4 vtx_color[];\n\
             out highp vec4 tess_ctrl_color[];\n\
             uniform highp float u_tessellationLevel;\n\
             uniform highp vec4 u_posScale;\n",
            if tessellation_wide_points {
                "${TESSELLATION_POINT_SIZE_REQUIRE}\n"
            } else {
                ""
            }
        );

        if !c.calc_per_primitive_bbox {
            buf.push_str("uniform highp vec4 u_primitiveBBoxMin;\nuniform highp vec4 u_primitiveBBoxMax;\n");
        }

        buf.push_str("patch out highp vec3 vp_bbox_clipMin;\npatch out highp vec3 vp_bbox_clipMax;\n");

        if c.calc_per_primitive_bbox {
            buf.push('\n');
            if c.has_geometry_stage {
                buf.push_str(gen_shader_function(ShaderFunction::MirrorX));
            }
            buf.push_str(gen_shader_function(ShaderFunction::MirrorY));

            buf.push_str(&format!(
                "vec4 transformVec(in highp vec4 p)\n\
                 {{\n\
                 \x20   return {};\n\
                 }}\n",
                if c.has_geometry_stage {
                    "mirrorX(mirrorY(p))"
                } else {
                    "mirrorY(p)"
                }
            ));
        }

        buf.push_str(
            "\n\
             void main()\n\
             {\n\
             \x20   // convert to nonsensical coordinates, just in case\n\
             \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position.wzxy;\n\
             \x20   tess_ctrl_color[gl_InvocationID] = vtx_color[gl_InvocationID];\n\
             \n\
             \x20   gl_TessLevelOuter[0] = u_tessellationLevel;\n\
             \x20   gl_TessLevelOuter[1] = u_tessellationLevel;\n\
             \x20   gl_TessLevelOuter[2] = u_tessellationLevel;\n\
             \x20   gl_TessLevelOuter[3] = u_tessellationLevel;\n\
             \x20   gl_TessLevelInner[0] = 0.8; // will be rounded up to 1\n\
             \x20   gl_TessLevelInner[1] = 0.8; // will be rounded up to 1\n",
        );

        if c.calc_per_primitive_bbox {
            buf.push('\n');

            if c.has_geometry_stage {
                buf.push_str(
                    "    const vec2 minExpansion = vec2(0.07 + 0.05, 0.07 + 0.02); // eval and geometry shader\n\
                     \x20   const vec2 maxExpansion = vec2(0.07 + 0.05, 0.07 + 0.03); // eval and geometry shader\n",
                );
            } else {
                buf.push_str(
                    "    const vec2 minExpansion = vec2(0.07, 0.07); // eval shader\n\
                     \x20   const vec2 maxExpansion = vec2(0.07, 0.07); // eval shader\n",
                );
            }

            buf.push_str(
                "    highp vec2 patternScale = u_posScale.zw;\n\
                 \x20   highp vec4 bboxMin = transformVec(gl_in[0].gl_Position) - vec4(minExpansion * patternScale, 0.0, 0.0);\n\
                 \x20   highp vec4 bboxMax = transformVec(gl_in[0].gl_Position) + vec4(maxExpansion * patternScale, 0.0, 0.0);\n",
            );
        } else {
            buf.push_str(
                "\n\
                 \x20   highp vec4 bboxMin = u_primitiveBBoxMin;\n\
                 \x20   highp vec4 bboxMax = u_primitiveBBoxMax;\n",
            );
        }
        if !c.use_global_state {
            buf.push_str(
                "\n\
                 \x20   ${PRIM_GL_BOUNDING_BOX}[0] = bboxMin;\n\
                 \x20   ${PRIM_GL_BOUNDING_BOX}[1] = bboxMax;\n",
            );
        }

        buf.push_str(
            "    vp_bbox_clipMin = min(vec3(bboxMin.x, bboxMin.y, bboxMin.z) / bboxMin.w,\n\
             \x20                         vec3(bboxMin.x, bboxMin.y, bboxMin.z) / bboxMax.w);\n\
             \x20   vp_bbox_clipMax = max(vec3(bboxMax.x, bboxMax.y, bboxMax.z) / bboxMin.w,\n\
             \x20                         vec3(bboxMax.x, bboxMax.y, bboxMax.z) / bboxMax.w);\n\
             }\n",
        );
        buf
    }

    fn gen_tessellation_evaluation_source(&self, c: &Common) -> String {
        let tessellation_wide_points = self.is_wide_point_case && !c.has_geometry_stage;
        let geo = c.geo_infix();
        let mut buf = format!(
            "${{GLSL_VERSION_DECL}}\n\
             ${{TESSELLATION_SHADER_REQUIRE}}\n\
             {}layout(quads, point_mode) in;\
             \n\
             in highp vec4 tess_ctrl_color[];\n\
             out highp vec4 tess_color;\n\
             uniform highp vec4 u_posScale;\n\
             \n\
             patch in highp vec3 vp_bbox_clipMin;\n\
             patch in highp vec3 vp_bbox_clipMax;\n\
             {}flat out highp vec3 v_{geo}bbox_clipMin;\n\
             flat out highp vec3 v_{geo}bbox_clipMax;\n\
             \n\
             {}void main()\n\
             {{\n\
             \x20   // non-trivial tessellation evaluation shader, convert from nonsensical coords, flip vertically\n\
             \x20   highp vec2 patternScale = u_posScale.zw;\n\
             \x20   highp vec4 offset = vec4((gl_TessCoord.xy * 2.0 - vec2(1.0)) * 0.07 * patternScale, 0.0, 0.0);\n\
             \x20   highp float pointSize = {};\n\
             \x20   gl_Position = mirrorY(gl_in[0].gl_Position.zwyx + offset);\n",
            if tessellation_wide_points {
                "${TESSELLATION_POINT_SIZE_REQUIRE}\n"
            } else {
                ""
            },
            if !c.has_geometry_stage {
                "flat out highp float v_bbox_expansionSize;\n"
            } else {
                ""
            },
            gen_shader_function(ShaderFunction::MirrorY),
            if tessellation_wide_points {
                "(tess_ctrl_color[0].g > 0.0) ? (5.0) : (3.0)"
            } else {
                "1.0"
            }
        );

        if tessellation_wide_points {
            buf.push_str("    gl_PointSize = pointSize;\n");
        }

        buf.push_str("    tess_color = tess_ctrl_color[0];\n");
        if !c.has_geometry_stage {
            buf.push_str("v_bbox_expansionSize = pointSize;\n");
        }
        buf.push_str(&format!(
            "    v_{geo}bbox_clipMin = vp_bbox_clipMin;\n\
             \x20   v_{geo}bbox_clipMax = vp_bbox_clipMax;\n\
             }}\n"
        ));
        buf
    }

    fn gen_geometry_source(&self, c: &Common) -> String {
        let color_input_name = if c.has_tessellation_stage {
            "tess_color"
        } else {
            "vtx_color"
        };
        let mut buf = format!(
            "${{GLSL_VERSION_DECL}}\n\
             ${{GEOMETRY_SHADER_REQUIRE}}\n\
             {}layout(points) in;\n\
             layout(max_vertices=3, points) out;\n\
             \n\
             in highp vec4 {color_input_name}[1];\n\
             out highp vec4 geo_color;\n\
             uniform highp vec4 u_posScale;\n\
             \n\
             flat in highp vec3 v_geo_bbox_clipMin[1];\n\
             flat in highp vec3 v_geo_bbox_clipMax[1];\n\
             flat out highp vec3 v_bbox_clipMin;\n\
             flat out highp vec3 v_bbox_clipMax;\n\
             flat out highp float v_bbox_expansionSize;\n\
             \n\
             {}\n\
             void main()\n\
             {{\n\
             \x20   // Non-trivial geometry shader: 1-to-3 amplification, mirror horizontally\n\
             \x20   highp vec4 p0 = mirrorX(gl_in[0].gl_Position);\n\
             \x20   highp vec4 pointColor = {color_input_name}[0];\n\
             \x20   highp vec2 patternScale = u_posScale.zw;\n\
             \x20   highp float pointSize = {};\n\
             \n\
             \x20   highp vec4 offsets[3] =\n\
             \x20       vec4[3](\n\
             \x20           vec4( 0.05 * patternScale.x, 0.03 * patternScale.y, 0.0, 0.0),\n\
             \x20           vec4(-0.01 * patternScale.x,-0.02 * patternScale.y, 0.0, 0.0),\n\
             \x20           vec4(-0.05 * patternScale.x, 0.02 * patternScale.y, 0.0, 0.0)\n\
             \x20       );\n\
             \x20   for (int ndx = 0; ndx < 3; ++ndx)\n\
             \x20   {{\n\
             \x20       gl_Position = p0 + offsets[ndx];\n",
            if self.is_wide_point_case {
                "${GEOMETRY_POINT_SIZE}\n"
            } else {
                ""
            },
            gen_shader_function(ShaderFunction::MirrorX),
            if self.is_wide_point_case {
                "(pointColor.g > 0.0) ? (5.0) : (3.0)"
            } else {
                "1.0"
            }
        );

        if self.is_wide_point_case {
            buf.push_str("        gl_PointSize = pointSize;\n");
        }

        buf.push_str(
            "        v_bbox_clipMin = v_geo_bbox_clipMin[0];\n\
             \x20       v_bbox_clipMax = v_geo_bbox_clipMax[0];\n\
             \x20       v_bbox_expansionSize = pointSize;\n\
             \x20       geo_color = pointColor;\n\
             \x20       EmitVertex();\n\
             \x20   }\n\
             }\n",
        );
        buf
    }

    fn generate_config(&self, common: &Common, iteration: i32, render_target_size: [i32; 2]) -> IterationConfig {
        let mut config = generate_random_config(common, 0xDEDEDEu32.wrapping_mul(iteration as u32), render_target_size);

        // equal or larger -> expand according to shader expansion
        if common.bbox_size == BBoxSizeKind::Equal || common.bbox_size == BBoxSizeKind::Larger {
            let pattern_scale = config.pattern_size;

            if common.has_tessellation_stage {
                config.bbox_min[0] -= 0.07 * pattern_scale[0];
                config.bbox_min[1] -= 0.07 * pattern_scale[1];
                config.bbox_max[0] += 0.07 * pattern_scale[0];
                config.bbox_max[1] += 0.07 * pattern_scale[1];
            }
            if common.has_geometry_stage {
                config.bbox_min[0] -= 0.05 * pattern_scale[0];
                config.bbox_min[1] -= 0.02 * pattern_scale[1];
                config.bbox_max[0] += 0.05 * pattern_scale[0];
                config.bbox_max[1] += 0.03 * pattern_scale[1];
            }
        }

        config
    }

    fn get_attribute_data(&self) -> Vec<Vec4> {
        self.generate_attribute_data()
    }

    fn render_test_pattern(
        &self,
        case: &mut ApiCase<'_>,
        common: &Common,
        res: &Resources<'_>,
        config: &IterationConfig,
    ) -> bool {
        let gl = case.gl();

        if !setup_render(case, common, res, config) {
            return false;
        }

        if common.has_tessellation_stage {
            // SAFETY: NUL-terminated name against a linked program.
            let tess_level_pos =
                unsafe { gl.get_uniform_location(res.program.program(), c"u_tessellationLevel".as_ptr()) };
            let tess_level = 0.8f32; // will be rounded up

            if tess_level_pos == -1 {
                case.fail(
                    "TCU_CHECK: u_tessellationLevel not found".to_string(),
                    "uniform not found",
                );
                return false;
            }

            log::debug!("u_tessellationLevel = {tess_level}");

            // SAFETY: a location of the bound program.
            unsafe {
                gl.uniform_1f(tess_level_pos, tess_level);
                gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1);
            }
            case.expect_no_error("patch param");
        }

        log::debug!("Rendering pattern.");

        // SAFETY: a draw through the program and attributes set up by `setup_render`.
        unsafe {
            gl.enable(glw::GL_BLEND);
            gl.blend_func(glw::GL_ONE, glw::GL_ONE);
            gl.blend_equation(glw::GL_FUNC_ADD);

            gl.draw_arrays(
                if common.has_tessellation_stage {
                    glw::GL_PATCHES
                } else {
                    glw::GL_POINTS
                },
                0,
                self.num_stripes * self.num_stripes * 2,
            );
        }
        case.expect_no_error("draw");
        true
    }

    fn verify_render_result(
        &self,
        case: &mut ApiCase<'_>,
        common: &Common,
        res: &Resources<'_>,
        config: &IterationConfig,
        _warning: &mut Warning,
    ) {
        let projected = project_bounding_box(config.bbox_min, config.bbox_max);
        let viewport_bbox_area = get_viewport_bounding_box_area(&projected, config.viewport_size, 0.0);
        let mut log_flood_counter = 8;

        if !common.calc_per_primitive_bbox {
            log::debug!(
                "Projected bounding box (clip space): {:?}..{:?}; viewport coordinates {viewport_bbox_area:?}",
                projected.min,
                projected.max
            );
        }

        let Some(viewport_surface) = read_viewport(case, res, config) else {
            return;
        };

        let ref_points = self.gen_reference_point_data(common, config);

        let any_error = if self.is_wide_point_case {
            self.verify_wide_point_pattern(&viewport_surface, &ref_points, &projected, &mut log_flood_counter)
        } else {
            Self::verify_narrow_point_pattern(&viewport_surface, &ref_points, &projected, &mut log_flood_counter)
        };

        if any_error {
            if log_flood_counter < 0 {
                log::debug!("Omitted {} error descriptions.", -log_flood_counter);
            }

            case.fail("Image verification failed.".to_string(), "Image verification failed");
        }
    }
}
