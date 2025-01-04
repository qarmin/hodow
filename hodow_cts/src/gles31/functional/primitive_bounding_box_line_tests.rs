// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fPrimitiveBoundingBoxTests.cpp (LineRenderCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `lines` and `wide_lines` groups.
// `tcu::getSubregion` + `getPixelInt(...)[component]` become a copy of the scanned pixels'
// channel values into a `Vec<i32>`; a neighbour probe in `checkLineContinuity` that falls
// outside the surface reads as "no hit" instead of upstream's out-of-bounds read.
// The QualityWarning / CompatibilityWarning verdicts go through `Warning`.

use super::primitive_bounding_box_render_tests::{
    AabbRoundDirection, Common, IterationConfig, Pattern, Resources, ShaderFunction, VA_NUM_ATTRIB_VECS, Vec4, Warning,
    gen_shader_function, generate_random_config, get_viewport_bounding_box_area, get_viewport_pattern_area,
    project_bounding_box, read_viewport, setup_render,
};
use crate::glu::ApiCase;
use crate::glw;
use crate::tcu::surface::Surface;
use crate::tcu::{Random, TestResult};

const GREEN_COMPONENT_NDX: usize = 1;
const BLUE_COMPONENT_NDX: usize = 2;
const SCAN_ROW_COMPONENT_NDX: usize = GREEN_COMPONENT_NDX; // scans are orthogonal to the line
const SCAN_COL_COMPONENT_NDX: usize = BLUE_COMPONENT_NDX;

const SCANRESULT_NUM_LINES_OK_BIT: u8 = 1 << 0;
const SCANRESULT_LINE_WIDTH_OK_BIT: u8 = 1 << 1;
const SCANRESULT_LINE_WIDTH_WARN_BIT: u8 = 1 << 2;
const SCANRESULT_LINE_WIDTH_ERR_BIT: u8 = 1 << 3;
const SCANRESULT_LINE_CONT_OK_BIT: u8 = 1 << 4;
const SCANRESULT_LINE_CONT_ERR_BIT: u8 = 1 << 5;
const SCANRESULT_LINE_CONT_WARN_BIT: u8 = 1 << 6;

const NUM_LINES_ERR: usize = 0;
const LINE_WIDTH_MSAA: usize = 1;
const LINE_WIDTH_WARN: usize = 2;
const LINE_WIDTH_ERR: usize = 3;
const LINE_CONT_ERR: usize = 4;
const LINE_CONT_WARN: usize = 5;

#[derive(Clone, Copy, PartialEq, Eq)]
enum QueryDirection {
    Horizontal,
    Vertical,
}

pub struct LinePattern {
    pattern_side: i32,
    is_wide_line_case: bool,
    wide_line_line_width: i32,
    multisample: bool,
}

impl LinePattern {
    pub fn new(wide: bool) -> Self {
        Self {
            pattern_side: 12,
            is_wide_line_case: wide,
            wide_line_line_width: 5,
            multisample: false,
        }
    }

    fn channel(surface: &Surface, x: i32, y: i32, component_ndx: usize) -> i32 {
        if x < 0 || y < 0 || x >= surface.get_width() || y >= surface.get_height() {
            return 0;
        }
        let pixel = surface.get_pixel(x, y);
        match component_ndx {
            0 => pixel.get_red(),
            1 => pixel.get_green(),
            2 => pixel.get_blue(),
            _ => pixel.get_alpha(),
        }
    }

    /// `getNumberOfLinesRange`
    #[allow(clippy::too_many_arguments)]
    fn get_number_of_lines_range(
        &self,
        c: &Common,
        query_area_begin: i32,
        query_area_end: i32,
        pattern_start: f32,
        pattern_size: f32,
        viewport_area: i32,
        query_dir: QueryDirection,
    ) -> [i32; 2] {
        // pattern is not symmetric due to mirroring
        let pattern_start_ndx = if query_dir == QueryDirection::Horizontal {
            i32::from(c.has_geometry_stage)
        } else {
            i32::from(c.has_tessellation_stage)
        };
        let pattern_end_ndx = pattern_start_ndx + self.pattern_side;

        let mut num_lines_min = 0;
        let mut num_lines_max = 0;

        for line_ndx in pattern_start_ndx..pattern_end_ndx {
            let line_pos = (pattern_start + (line_ndx as f32 / self.pattern_side as f32) * pattern_size) * 0.5 + 0.5;
            let line_width = if self.is_wide_line_case {
                self.wide_line_line_width as f32
            } else {
                1.0
            };

            if line_pos * viewport_area as f32 > query_area_begin as f32 + 1.0
                && line_pos * (viewport_area as f32) < query_area_end as f32 - 1.0
            {
                // line center is within the area
                num_lines_min += 1;
                num_lines_max += 1;
            } else if line_pos * viewport_area as f32 > query_area_begin as f32 - line_width * 0.5 - 1.0
                && line_pos * (viewport_area as f32) < query_area_end as f32 + line_width * 0.5 + 1.0
            {
                // line could leak into area
                num_lines_max += 1;
            }
        }

        [num_lines_min, num_lines_max]
    }

    /// `getNumMinimaMaxima` over the values of a one-pixel-wide strip.
    fn get_num_minima_maxima(values: &[i32]) -> [i32; 2] {
        let mut previous_value = -1;
        let mut previous_sign = 0;
        let mut num_minima = 0;
        let mut num_maxima = 0;

        for &component_value in values {
            if previous_value != -1 {
                let sign = match component_value.cmp(&previous_value) {
                    std::cmp::Ordering::Greater => 1,
                    std::cmp::Ordering::Less => -1,
                    std::cmp::Ordering::Equal => 0,
                };

                // local minima/maxima in sign changes (zero signless)
                if sign != 0 && sign == -previous_sign {
                    previous_sign = sign;
                    if sign > 0 {
                        num_minima += 1;
                    } else {
                        num_maxima += 1;
                    }
                } else if sign != 0 && previous_sign == 0 {
                    previous_sign = sign;

                    // local extreme at the start boundary
                    if sign > 0 {
                        num_minima += 1;
                    } else {
                        num_maxima += 1;
                    }
                }
            }

            previous_value = component_value;
        }

        // local extreme at the end boundary
        if previous_sign > 0 {
            num_maxima += 1;
        } else if previous_sign < 0 {
            num_minima += 1;
        } else {
            num_maxima += 1;
            num_minima += 1;
        }

        [num_minima, num_maxima]
    }

    /// `checkAreaNumLines`. `area` is (x, y, width, height).
    fn check_area_num_lines(
        &self,
        surface: &Surface,
        area: [i32; 4],
        message_limit_counter: &mut i32,
        component_ndx: usize,
        num_lines: [i32; 2],
    ) -> bool {
        let mut values = Vec::new();
        for y in area[1]..area[1] + area[3] {
            for x in area[0]..area[0] + area[2] {
                values.push(Self::channel(surface, x, y, component_ndx));
            }
        }
        let num_maxima = Self::get_num_minima_maxima(&values)[1];

        // In valid range
        if num_maxima >= num_lines[0] && num_maxima <= num_lines[1] {
            return true;
        }

        *message_limit_counter -= 1;
        if *message_limit_counter < 0 {
            return false;
        }

        if area[2] == 1 {
            log::debug!(
                "On column {}, y: [{},{}): expected [{}, {}] lines but the number of lines in the area is {num_maxima}",
                area[0],
                area[1],
                area[1] + area[3],
                num_lines[0],
                num_lines[1]
            );
        } else {
            log::debug!(
                "On row {}, x: [{},{}): expected [{}, {}] lines but the number of lines in the area is {num_maxima}",
                area[1],
                area[0],
                area[0] + area[2],
                num_lines[0],
                num_lines[1]
            );
        }

        false
    }

    /// `checkLineContinuity`
    fn check_line_continuity(
        surface: &Surface,
        begin: [i32; 2],
        end: [i32; 2],
        component_ndx: usize,
        message_limit_counter: &mut i32,
    ) -> u8 {
        let mut line = false;
        let advance = if begin[0] == end[0] { [0, 1] } else { [1, 0] };
        let mut missed_pixels = 0;
        let mut total_pixels = 0;
        let mut error_mask = 0u8;
        let mut cursor = begin;

        while cursor != end {
            let hit = Self::channel(surface, cursor[0], cursor[1], component_ndx) != 0;

            if hit {
                line = true;
            } else if line {
                // non-continuous line detected
                let advance_neighbor = [1 - advance[0], 1 - advance[1]];
                let cursor_neighbor_pos = [cursor[0] + advance_neighbor[0], cursor[1] + advance_neighbor[1]];
                let cursor_neighbor_neg = [cursor[0] - advance_neighbor[0], cursor[1] - advance_neighbor[1]];
                // hw precision issues may lead to a line being non-straight -> check neighboring pixels
                if Self::channel(surface, cursor_neighbor_pos[0], cursor_neighbor_pos[1], component_ndx) == 0
                    && Self::channel(surface, cursor_neighbor_neg[0], cursor_neighbor_neg[1], component_ndx) == 0
                {
                    missed_pixels += 1;
                }
            }
            total_pixels += 1;
            cursor = [cursor[0] + advance[0], cursor[1] + advance[1]];
        }

        if missed_pixels > 0 {
            *message_limit_counter -= 1;
            if *message_limit_counter >= 0 {
                log::debug!(
                    "Found non-continuous {} line near {begin:?}. Missed pixels: {missed_pixels}",
                    if advance[0] == 1 { "horizontal" } else { "vertical" }
                );
            }
            // allow 10% missing pixels for warning
            if missed_pixels <= (total_pixels as f32 * 0.1).round() as i32 {
                error_mask = SCANRESULT_LINE_CONT_WARN_BIT;
            } else {
                error_mask = SCANRESULT_LINE_CONT_ERR_BIT;
            }
        }

        error_mask
    }

    fn print_line_width_error(
        pos: [i32; 2],
        detected_line_width: i32,
        line_width_range: [i32; 2],
        is_horizontal: bool,
        message_limit_counter: &mut i32,
    ) {
        *message_limit_counter -= 1;
        if *message_limit_counter < 0 {
            return;
        }

        log::debug!(
            "Found incorrect line width near {pos:?}: ({} line) expected line width in range [{}, {}] but found {detected_line_width}",
            if is_horizontal { "horizontal" } else { "vertical" },
            line_width_range[0],
            line_width_range[1]
        );
    }

    /// `checkLineWidths`
    fn check_line_widths(
        &self,
        surface: &Surface,
        begin: [i32; 2],
        end: [i32; 2],
        component_ndx: usize,
        message_limit_counter: &mut i32,
    ) -> u8 {
        let line_render_width = if self.is_wide_line_case {
            self.wide_line_line_width
        } else {
            1
        };
        // multisampled "smooth" lines may spread to neighboring pixel
        let line_width_range = if self.multisample {
            [line_render_width, line_render_width + 1]
        } else {
            [line_render_width, line_render_width]
        };
        let relaxed_line_width_range = [line_render_width - 1, line_render_width + 1];

        let mut line_width = 0;
        let mut bbox_limited_line = false;
        let mut error_mask = 0u8;

        let advance = if begin[0] == end[0] { [0, 1] } else { [1, 0] };

        // fragments before begin?
        if Self::channel(surface, begin[0], begin[1], component_ndx) != 0 {
            bbox_limited_line = true;

            let mut cursor = [begin[0] - advance[0], begin[1] - advance[1]];
            loop {
                if cursor[0] < 0 || cursor[1] < 0 {
                    break;
                } else if Self::channel(surface, cursor[0], cursor[1], component_ndx) != 0 {
                    line_width += 1;
                } else {
                    break;
                }
                cursor = [cursor[0] - advance[0], cursor[1] - advance[1]];
            }
        }

        let mut cursor = begin;
        while cursor != end {
            let hit = Self::channel(surface, cursor[0], cursor[1], component_ndx) != 0;

            if hit {
                line_width += 1;
            } else if line_width != 0 {
                // Line is allowed to be be thinner if it borders the bbox boundary (since part of the line might have been discarded).
                let incorrect_line_width =
                    (line_width < line_width_range[0] && !bbox_limited_line) || line_width > line_width_range[1];

                if incorrect_line_width {
                    let incorrect_relaxed = (line_width < relaxed_line_width_range[0] && !bbox_limited_line)
                        || line_width > relaxed_line_width_range[1];

                    if incorrect_relaxed {
                        error_mask |= SCANRESULT_LINE_WIDTH_ERR_BIT;
                    } else {
                        error_mask |= SCANRESULT_LINE_WIDTH_WARN_BIT;
                    }

                    Self::print_line_width_error(
                        cursor,
                        line_width,
                        line_width_range,
                        advance[0] == 0,
                        message_limit_counter,
                    );
                }

                line_width = 0;
                bbox_limited_line = false;
            }
            cursor = [cursor[0] + advance[0], cursor[1] + advance[1]];
        }

        // fragments after end?
        if line_width != 0 {
            let mut cursor = end;
            loop {
                if cursor[0] >= surface.get_width() || cursor[1] >= surface.get_height() {
                    if line_width > line_width_range[1] {
                        if line_width > relaxed_line_width_range[1] {
                            error_mask |= SCANRESULT_LINE_WIDTH_ERR_BIT;
                        } else {
                            error_mask |= SCANRESULT_LINE_WIDTH_WARN_BIT;
                        }

                        Self::print_line_width_error(
                            cursor,
                            line_width,
                            line_width_range,
                            advance[0] == 0,
                            message_limit_counter,
                        );
                    }

                    break;
                } else if Self::channel(surface, cursor[0], cursor[1], component_ndx) != 0 {
                    line_width += 1;
                } else if line_width != 0 {
                    // only check that line width is not larger than expected. Line width may be smaller
                    // since the scanning 'cursor' is now outside the bounding box.
                    let incorrect_line_width = line_width > line_width_range[1];

                    if incorrect_line_width {
                        let incorrect_relaxed = line_width > relaxed_line_width_range[1];

                        if incorrect_relaxed {
                            error_mask |= SCANRESULT_LINE_WIDTH_ERR_BIT;
                        } else {
                            error_mask |= SCANRESULT_LINE_WIDTH_WARN_BIT;
                        }

                        Self::print_line_width_error(
                            cursor,
                            line_width,
                            line_width_range,
                            advance[0] == 0,
                            message_limit_counter,
                        );
                    }

                    line_width = 0;
                }
                cursor = [cursor[0] + advance[0], cursor[1] + advance[1]];
            }
        }

        error_mask
    }

    fn combine(num_lines_ok: bool, line_width_res: u8, line_continuity_res: u8) -> u8 {
        let mut result = 0u8;

        if num_lines_ok {
            result |= SCANRESULT_NUM_LINES_OK_BIT;
        }
        if line_continuity_res == 0 {
            result |= SCANRESULT_LINE_CONT_OK_BIT;
        } else {
            result |= line_continuity_res;
        }
        if line_width_res == 0 {
            result |= SCANRESULT_LINE_WIDTH_OK_BIT;
        } else {
            result |= line_width_res;
        }

        result
    }

    /// `scanRow`
    #[allow(clippy::too_many_arguments)]
    fn scan_row(
        &self,
        surface: &Surface,
        row: i32,
        row_begin: i32,
        row_end: i32,
        row_viewport_begin: i32,
        row_viewport_end: i32,
        num_lines: [i32; 2],
        counter: &mut i32,
    ) -> u8 {
        let num_lines_ok = self.check_area_num_lines(
            surface,
            [row_begin, row, row_end - row_begin, 1],
            counter,
            SCAN_ROW_COMPONENT_NDX,
            num_lines,
        );
        let line_width_res = self.check_line_widths(
            surface,
            [row_begin, row],
            [row_end, row],
            SCAN_ROW_COMPONENT_NDX,
            counter,
        );
        let line_continuity_res = Self::check_line_continuity(
            surface,
            [row_viewport_begin, row],
            [row_viewport_end, row],
            SCAN_COL_COMPONENT_NDX,
            counter,
        );

        Self::combine(num_lines_ok, line_width_res, line_continuity_res)
    }

    /// `scanColumn`
    #[allow(clippy::too_many_arguments)]
    fn scan_column(
        &self,
        surface: &Surface,
        column: i32,
        column_begin: i32,
        column_end: i32,
        column_viewport_begin: i32,
        column_viewport_end: i32,
        num_lines: [i32; 2],
        counter: &mut i32,
    ) -> u8 {
        let num_lines_ok = self.check_area_num_lines(
            surface,
            [column, column_begin, 1, column_end - column_begin],
            counter,
            SCAN_COL_COMPONENT_NDX,
            num_lines,
        );
        let line_width_res = self.check_line_widths(
            surface,
            [column, column_begin],
            [column, column_end],
            SCAN_COL_COMPONENT_NDX,
            counter,
        );
        let line_continuity_res = Self::check_line_continuity(
            surface,
            [column, column_viewport_begin],
            [column, column_viewport_end],
            SCAN_ROW_COMPONENT_NDX,
            counter,
        );

        Self::combine(num_lines_ok, line_width_res, line_continuity_res)
    }

    /// The tally `verifyRenderResult` keeps per scan direction.
    fn tally(&self, result: u8, is_msaa: bool, scan: &mut [i32; 6]) {
        if result & SCANRESULT_NUM_LINES_OK_BIT == 0 {
            scan[NUM_LINES_ERR] += 1;
        }
        if result & SCANRESULT_LINE_CONT_OK_BIT == 0 {
            if result & SCANRESULT_LINE_CONT_WARN_BIT != 0 {
                scan[LINE_CONT_WARN] += 1;
            } else {
                scan[LINE_CONT_ERR] += 1;
            }
        } else if result & SCANRESULT_LINE_WIDTH_OK_BIT == 0 {
            if self.is_wide_line_case && is_msaa {
                // multisampled wide lines might not be supported
                scan[LINE_WIDTH_MSAA] += 1;
            } else if result & SCANRESULT_LINE_WIDTH_ERR_BIT == 0 && result & SCANRESULT_LINE_WIDTH_WARN_BIT != 0 {
                scan[LINE_WIDTH_WARN] += 1;
            } else {
                scan[LINE_WIDTH_ERR] += 1;
            }
        }
    }
}

impl Pattern for LinePattern {
    fn check_support(&self, case: &mut ApiCase<'_>, _common: &Common) -> bool {
        if self.is_wide_line_case {
            let mut line_width_range = [0.0f32; 2];
            // SAFETY: two floats out.
            unsafe {
                case.gl()
                    .get_floatv(glw::GL_ALIASED_LINE_WIDTH_RANGE, line_width_range.as_mut_ptr())
            };

            if line_width_range[1] < self.wide_line_line_width as f32 {
                case.not_supported(format!("Test requires line width {}", self.wide_line_line_width));
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
             uniform highp float u_lineWidth;\n\
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
        buf.push_str(
            "void main()\n\
             {\n\
             \x20   highp vec2 patternOffset = u_posScale.xy;\n\
             \x20   highp vec2 patternScale = u_posScale.zw;\n\
             \x20   gl_Position = vec4(a_position.xy * patternScale + patternOffset, a_position.z, a_position.w);\n\
             \x20   vtx_color = a_color;\n",
        );
        if !c.has_tessellation_stage {
            buf.push_str(&format!(
                "\n\
                 \x20   v_{geo}bbox_expansionSize = u_lineWidth;\n\
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
        let mut buf = String::from(
            "${GLSL_VERSION_DECL}\n\
             ${ARB_ES32_COMPATIBILITY_REQUIRE}\n\
             ${TESSELLATION_SHADER_REQUIRE}\n\
             ${PRIMITIVE_BOUNDING_BOX_REQUIRE}\n\
             layout(vertices=2) out;\
             \n\
             in highp vec4 vtx_color[];\n\
             out highp vec4 tess_ctrl_color[];\n\
             uniform highp float u_tessellationLevel;\n\
             uniform highp vec4 u_posScale;\n\
             uniform highp float u_lineWidth;\n",
        );

        if !c.calc_per_primitive_bbox {
            buf.push_str("uniform highp vec4 u_primitiveBBoxMin;\nuniform highp vec4 u_primitiveBBoxMax;\n");
        }

        buf.push_str("patch out highp float vp_bbox_expansionSize;\npatch out highp vec3 vp_bbox_clipMin;\npatch out highp vec3 vp_bbox_clipMax;\n");

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
             \x20   gl_TessLevelOuter[0] = 0.8; // will be rounded up to 1\n\
             \x20   gl_TessLevelOuter[1] = u_tessellationLevel;\n",
        );

        if c.calc_per_primitive_bbox {
            buf.push_str(
                "\n\
                 \x20   highp vec4 bboxMin = min(transformVec(gl_in[0].gl_Position),\n\
                 \x20                            transformVec(gl_in[1].gl_Position));\n\
                 \x20   highp vec4 bboxMax = max(transformVec(gl_in[0].gl_Position),\n\
                 \x20                            transformVec(gl_in[1].gl_Position));\n",
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
            "    vp_bbox_expansionSize = u_lineWidth;\n\
             \x20   vp_bbox_clipMin = min(vec3(bboxMin.x, bboxMin.y, bboxMin.z) / bboxMin.w,\n\
             \x20                         vec3(bboxMin.x, bboxMin.y, bboxMin.z) / bboxMax.w);\n\
             \x20   vp_bbox_clipMax = max(vec3(bboxMax.x, bboxMax.y, bboxMax.z) / bboxMin.w,\n\
             \x20                         vec3(bboxMax.x, bboxMax.y, bboxMax.z) / bboxMax.w);\n\
             }\n",
        );
        buf
    }

    fn gen_tessellation_evaluation_source(&self, c: &Common) -> String {
        let geo = c.geo_infix();
        format!(
            "${{GLSL_VERSION_DECL}}\n\
             ${{TESSELLATION_SHADER_REQUIRE}}\n\
             layout(isolines) in;\
             \n\
             in highp vec4 tess_ctrl_color[];\n\
             out highp vec4 tess_color;\n\
             uniform highp vec4 u_posScale;\n\
             \n\
             patch in highp float vp_bbox_expansionSize;\n\
             patch in highp vec3 vp_bbox_clipMin;\n\
             patch in highp vec3 vp_bbox_clipMax;\n\
             flat out highp float v_{geo}bbox_expansionSize;\n\
             flat out highp vec3 v_{geo}bbox_clipMin;\n\
             flat out highp vec3 v_{geo}bbox_clipMax;\n\
             {}void main()\n\
             {{\n\
             \x20   // non-trivial tessellation evaluation shader, convert from nonsensical coords, flip vertically\n\
             \x20   gl_Position = mirrorY(mix(gl_in[0].gl_Position.zwyx, gl_in[1].gl_Position.zwyx, gl_TessCoord.x));\n\
             \x20   tess_color = tess_ctrl_color[0];\n\
             \x20   v_{geo}bbox_expansionSize = vp_bbox_expansionSize;\n\
             \x20   v_{geo}bbox_clipMin = vp_bbox_clipMin;\n\
             \x20   v_{geo}bbox_clipMax = vp_bbox_clipMax;\n\
             }}\n",
            gen_shader_function(ShaderFunction::MirrorY)
        )
    }

    fn gen_geometry_source(&self, c: &Common) -> String {
        let color_input_name = if c.has_tessellation_stage {
            "tess_color"
        } else {
            "vtx_color"
        };

        format!(
            "${{GLSL_VERSION_DECL}}\n\
             ${{GEOMETRY_SHADER_REQUIRE}}\n\
             layout(lines) in;\n\
             layout(max_vertices=5, line_strip) out;\n\
             \n\
             in highp vec4 {color_input_name}[2];\n\
             out highp vec4 geo_color;\n\
             uniform highp vec4 u_posScale;\n\
             \n\
             \n\
             flat in highp float v_geo_bbox_expansionSize[2];\n\
             flat in highp vec3 v_geo_bbox_clipMin[2];\n\
             flat in highp vec3 v_geo_bbox_clipMax[2];\n\
             flat out highp vec3 v_bbox_clipMin;\n\
             flat out highp vec3 v_bbox_clipMax;\n\
             flat out highp float v_bbox_expansionSize;\n\
             {}\n\
             void setVisualizationVaryings()\n\
             {{\n\
             \x20   v_bbox_expansionSize = v_geo_bbox_expansionSize[0];\n\
             \x20   v_bbox_clipMin = v_geo_bbox_clipMin[0];\n\
             \x20   v_bbox_clipMax = v_geo_bbox_clipMax[0];\n\
             }}\n\
             void main()\n\
             {{\n\
             \x20   // Non-trivial geometry shader: 1-to-3 amplification, mirror horizontally\n\
             \x20   highp vec4 p0 = mirrorX(gl_in[0].gl_Position);\n\
             \x20   highp vec4 p1 = mirrorX(gl_in[1].gl_Position);\n\
             \x20   highp vec4 lineColor = {color_input_name}[0];\n\
             \n\
             \x20   // output two separate primitives, just in case\n\
             \x20   gl_Position = mix(p0, p1, 0.00); geo_color = lineColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   gl_Position = mix(p0, p1, 0.33); geo_color = lineColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   EndPrimitive();\n\
             \n\
             \x20   gl_Position = mix(p0, p1, 0.33); geo_color = lineColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   gl_Position = mix(p0, p1, 0.67); geo_color = lineColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   gl_Position = mix(p0, p1, 1.00); geo_color = lineColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   EndPrimitive();\n\
             }}\n",
            gen_shader_function(ShaderFunction::MirrorX)
        )
    }

    fn generate_config(&self, common: &Common, iteration: i32, render_target_size: [i32; 2]) -> IterationConfig {
        let num_max_attempts = 128u32;

        // Avoid too narrow viewports, lines could merge together. Require viewport is at least 2.5x the size of the line bodies.
        for attempt_ndx in 0..num_max_attempts {
            let config = generate_random_config(
                common,
                0xDEDEDEu32.wrapping_mul(iteration as u32) ^ 0xABAB13u32.wrapping_mul(attempt_ndx),
                render_target_size,
            );

            if config.viewport_size[0] as f32 * (config.pattern_size[0] * 0.5)
                > 2.5 * self.pattern_side as f32 * self.wide_line_line_width as f32
                && config.viewport_size[1] as f32 * (config.pattern_size[1] * 0.5)
                    > 2.5 * self.pattern_side as f32 * self.wide_line_line_width as f32
            {
                return config;
            }
        }

        // Upstream asserts here; fall back to the first draw so the case still runs.
        generate_random_config(common, 0xDEDEDEu32.wrapping_mul(iteration as u32), render_target_size)
    }

    fn get_attribute_data(&self) -> Vec<Vec4> {
        let green: Vec4 = [0.0, 1.0, 0.0, 1.0];
        let blue: Vec4 = [0.0, 0.0, 1.0, 1.0];
        let side = self.pattern_side;
        let mut cell_order: Vec<i32> = (0..side * side * 2).collect();
        let mut rnd = Random::new(0xDE12345);

        // generate crosshatch pattern with segments in random order
        rnd.shuffle(&mut cell_order);

        let mut data: Vec<Vec4> = vec![[0.0; 4]; cell_order.len() * 4];
        let s = side as f32;
        for (ndx, &segment_id) in cell_order.iter().enumerate() {
            let direction = segment_id & 0x01;
            let major_coord = (segment_id >> 1) / side;
            let minor_coord = (segment_id >> 1) % side;

            let (p0, p1, color) = if direction != 0 {
                (
                    [minor_coord as f32 / s, major_coord as f32 / s, 0.0, 1.0],
                    [minor_coord as f32 / s, (major_coord + 1) as f32 / s, 0.0, 1.0],
                    green,
                )
            } else {
                (
                    [major_coord as f32 / s, minor_coord as f32 / s, 0.0, 1.0],
                    [(major_coord + 1) as f32 / s, minor_coord as f32 / s, 0.0, 1.0],
                    blue,
                )
            };

            // position then colour per vertex (VA_POS_VEC_NDX = 0, VA_COL_VEC_NDX = 1)
            data[(ndx * 2) * VA_NUM_ATTRIB_VECS] = p0;
            data[(ndx * 2) * VA_NUM_ATTRIB_VECS + 1] = color;
            data[(ndx * 2 + 1) * VA_NUM_ATTRIB_VECS] = p1;
            data[(ndx * 2 + 1) * VA_NUM_ATTRIB_VECS + 1] = color;
        }
        data
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
            let tess_level = 2.8f32; // will be rounded up

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
                gl.patch_parameteri(glw::GL_PATCH_VERTICES, 2);
            }
            case.expect_no_error("patch param");
        }

        if self.is_wide_line_case {
            // SAFETY: state setter.
            unsafe { gl.line_width(self.wide_line_line_width as f32) };
        }

        // SAFETY: a location of the bound program.
        unsafe {
            gl.uniform_1f(
                gl.get_uniform_location(res.program.program(), c"u_lineWidth".as_ptr()),
                if self.is_wide_line_case {
                    self.wide_line_line_width as f32
                } else {
                    1.0
                },
            );
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
                    glw::GL_LINES
                },
                0,
                self.pattern_side * self.pattern_side * 2 * 2,
            );
        }
        case.expect_no_error("draw");
        true
    }

    #[allow(clippy::if_same_then_else)]
    fn verify_render_result(
        &self,
        case: &mut ApiCase<'_>,
        common: &Common,
        res: &Resources<'_>,
        config: &IterationConfig,
        warning: &mut Warning,
    ) {
        let is_msaa = case.context().render_target().num_samples > 1;
        let projected = project_bounding_box(config.bbox_min, config.bbox_max);
        let line_width = if self.is_wide_line_case {
            self.wide_line_line_width as f32
        } else {
            1.0
        };
        let viewport_bbox_area = get_viewport_bounding_box_area(&projected, config.viewport_size, line_width);
        let viewport_pattern_area = get_viewport_pattern_area(
            config.pattern_pos,
            config.pattern_size,
            config.viewport_size,
            AabbRoundDirection::Inwards,
        );
        let expected_horizontal_lines = self.get_number_of_lines_range(
            common,
            viewport_bbox_area[1],
            viewport_bbox_area[3],
            config.pattern_pos[1],
            config.pattern_size[1],
            config.viewport_size[1],
            QueryDirection::Vertical,
        );
        let expected_vertical_lines = self.get_number_of_lines_range(
            common,
            viewport_bbox_area[0],
            viewport_bbox_area[2],
            config.pattern_pos[0],
            config.pattern_size[0],
            config.viewport_size[0],
            QueryDirection::Horizontal,
        );
        let verification_area = [
            viewport_bbox_area[0].max(0),
            viewport_bbox_area[1].max(0),
            viewport_bbox_area[2].min(config.viewport_size[0]),
            viewport_bbox_area[3].min(config.viewport_size[1]),
        ];

        let mut message_limit_counter = 8;
        let mut row_scan_result = [0i32; 6];
        let mut column_scan_result = [0i32; 6];
        let mut any_error = false;
        let mut msaa_relaxation_required = false;
        let mut hw_issue_relaxation_required = false;

        if !common.calc_per_primitive_bbox {
            log::debug!(
                "Projected bounding box (clip space) x: [{},{}] y: [{},{}] z: [{},{}]; viewport coordinates x: [{}, {}] y: [{}, {}]",
                projected.min[0],
                projected.max[0],
                projected.min[1],
                projected.max[1],
                projected.min[2],
                projected.max[2],
                viewport_bbox_area[0],
                viewport_bbox_area[2],
                viewport_bbox_area[1],
                viewport_bbox_area[3]
            );
        }
        log::debug!(
            "Expecting [{}, {}] horizontal lines and [{}, {}] vertical lines within the bounding box",
            expected_horizontal_lines[0],
            expected_horizontal_lines[1],
            expected_vertical_lines[0],
            expected_vertical_lines[1]
        );

        let Some(viewport_surface) = read_viewport(case, res, config) else {
            return;
        };

        // `checkLineWidths` reads the case's multisample state through the context.
        let this = Self {
            multisample: is_msaa,
            ..Self::new(self.is_wide_line_case)
        };

        // scan rows
        for y in verification_area[1].max(viewport_pattern_area[1])..verification_area[3].min(viewport_pattern_area[3])
        {
            let result = this.scan_row(
                &viewport_surface,
                y,
                verification_area[0],
                verification_area[2],
                verification_area[0].max(viewport_pattern_area[0]),
                verification_area[2].min(viewport_pattern_area[2]),
                expected_vertical_lines,
                &mut message_limit_counter,
            );
            this.tally(result, is_msaa, &mut row_scan_result);
        }

        // scan columns
        for x in verification_area[0].max(viewport_pattern_area[0])..verification_area[2].min(viewport_pattern_area[2])
        {
            let result = this.scan_column(
                &viewport_surface,
                x,
                verification_area[1],
                verification_area[3],
                verification_area[1].min(viewport_pattern_area[1]),
                verification_area[3].min(viewport_pattern_area[3]),
                expected_horizontal_lines,
                &mut message_limit_counter,
            );
            this.tally(result, is_msaa, &mut column_scan_result);
        }

        if column_scan_result[LINE_WIDTH_ERR] != 0 || row_scan_result[LINE_WIDTH_ERR] != 0 {
            any_error = true;
        } else if column_scan_result[LINE_CONT_ERR] != 0 || row_scan_result[LINE_CONT_ERR] != 0 {
            any_error = true;
        } else if column_scan_result[LINE_WIDTH_MSAA] != 0 || row_scan_result[LINE_WIDTH_MSAA] != 0 {
            msaa_relaxation_required = true;
        } else if column_scan_result[LINE_WIDTH_WARN] != 0 || row_scan_result[LINE_WIDTH_WARN] != 0 {
            hw_issue_relaxation_required = true;
        } else if column_scan_result[NUM_LINES_ERR] != 0 {
            // found missing lines in a column and row line continuity check reported a warning (not an error) -> line width precision issue
            if row_scan_result[LINE_CONT_ERR] == 0 && row_scan_result[LINE_CONT_WARN] != 0 {
                hw_issue_relaxation_required = true;
            } else {
                any_error = true;
            }
        } else if row_scan_result[NUM_LINES_ERR] != 0 {
            // found missing lines in a row and column line continuity check reported a warning (not an error) -> line width precision issue
            if column_scan_result[LINE_CONT_ERR] == 0 && column_scan_result[LINE_CONT_WARN] != 0 {
                hw_issue_relaxation_required = true;
            } else {
                any_error = true;
            }
        }

        if any_error || msaa_relaxation_required || hw_issue_relaxation_required {
            if message_limit_counter < 0 {
                log::debug!("Omitted {} row/column error descriptions.", -message_limit_counter);
            }

            log::debug!("Image verification failed.");

            if any_error {
                case.fail("Image verification failed.".to_string(), "Image verification failed");
            } else if hw_issue_relaxation_required {
                // Line width hw issue
                warning.get_or_insert((TestResult::QualityWarning, "Line width verification failed"));
            } else {
                // MSAA wide lines are optional
                warning.get_or_insert((
                    TestResult::CompatibilityWarning,
                    "Multisampled wide line verification failed",
                ));
            }
        }
    }
}
