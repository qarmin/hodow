//! CPU reference blend functions of glcBlendEquationAdvancedTests.cpp (lines 150-465), on `[f32; 4]` instead of tcu::Vec4.

use crate::glw;

pub type Vec4 = [f32; 4];

pub type BlendFunc = fn(&Vec4, &Vec4) -> Vec4;

fn mul(a: &Vec4, b: &Vec4) -> Vec4 {
    [a[0] * b[0], a[1] * b[1], a[2] * b[2], a[3] * b[3]]
}

fn scale(a: &Vec4, s: f32) -> Vec4 {
    [a[0] * s, a[1] * s, a[2] * s, a[3] * s]
}

fn add_scalar(a: &Vec4, s: f32) -> Vec4 {
    [a[0] + s, a[1] + s, a[2] + s, a[3] + s]
}

fn get_p0(src: &Vec4, dst: &Vec4) -> f32 {
    src[3] * dst[3]
}

fn get_p1(src: &Vec4, dst: &Vec4) -> f32 {
    src[3] * (1.0 - dst[3])
}

fn get_p2(src: &Vec4, dst: &Vec4) -> f32 {
    dst[3] * (1.0 - src[3])
}

fn blend(rgb: Vec4, src: &Vec4, dst: &Vec4) -> Vec4 {
    let p = [get_p0(src, dst), get_p1(src, dst), get_p2(src, dst)];
    let alpha = p[0] + p[1] + p[2];
    let channel = |i: usize| (p[0] * rgb[i]) + (p[1] * src[i]) + (p[2] * dst[i]);
    [channel(0), channel(1), channel(2), alpha]
}

fn per_channel(src: &Vec4, dst: &Vec4, f: impl Fn(f32, f32) -> f32) -> Vec4 {
    [f(src[0], dst[0]), f(src[1], dst[1]), f(src[2], dst[2]), 0.0]
}

fn blend_multiply(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(mul(src, dst), src, dst)
}

fn blend_screen(src: &Vec4, dst: &Vec4) -> Vec4 {
    let p = mul(src, dst);
    blend(
        [
            src[0] + dst[0] - p[0],
            src[1] + dst[1] - p[1],
            src[2] + dst[2] - p[2],
            src[3] + dst[3] - p[3],
        ],
        src,
        dst,
    )
}

fn overlay(s: f32, d: f32) -> f32 {
    if d <= 0.5 {
        2.0 * s * d
    } else {
        1.0 - 2.0 * (1.0 - s) * (1.0 - d)
    }
}

fn blend_overlay(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(per_channel(src, dst, overlay), src, dst)
}

fn blend_darken(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(per_channel(src, dst, f32::min), src, dst)
}

fn blend_lighten(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(per_channel(src, dst, f32::max), src, dst)
}

fn color_dodge(s: f32, d: f32) -> f32 {
    if d <= 0.0 {
        0.0
    } else if d > 0.0 && s < 1.0 {
        (d / (1.0 - s)).min(1.0)
    } else {
        1.0
    }
}

fn blend_color_dodge(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(per_channel(src, dst, color_dodge), src, dst)
}

fn color_burn(s: f32, d: f32) -> f32 {
    if d >= 1.0 {
        1.0
    } else if d < 1.0 && s > 0.0 {
        1.0 - ((1.0 - d) / s).min(1.0)
    } else {
        0.0
    }
}

fn blend_color_burn(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(per_channel(src, dst, color_burn), src, dst)
}

fn hard_light(s: f32, d: f32) -> f32 {
    if s <= 0.5 {
        2.0 * s * d
    } else {
        1.0 - 2.0 * (1.0 - s) * (1.0 - d)
    }
}

fn blend_hard_light(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(per_channel(src, dst, hard_light), src, dst)
}

fn soft_light(s: f32, d: f32) -> f32 {
    if s <= 0.5 {
        d - (1.0 - 2.0 * s) * d * (1.0 - d)
    } else if d <= 0.25 {
        d + (2.0 * s - 1.0) * d * ((16.0 * d - 12.0) * d + 3.0)
    } else {
        d + (2.0 * s - 1.0) * (d.sqrt() - d)
    }
}

fn blend_soft_light(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(per_channel(src, dst, soft_light), src, dst)
}

fn blend_difference(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(per_channel(src, dst, |s, d| (s - d).abs()), src, dst)
}

fn exclusion(s: f32, d: f32) -> f32 {
    s + d - 2.0 * s * d
}

fn blend_exclusion(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(per_channel(src, dst, exclusion), src, dst)
}

fn luminance(rgba: &Vec4) -> f32 {
    0.30 * rgba[0] + 0.59 * rgba[1] + 0.11 * rgba[2]
}

fn min_rgb(rgba: &Vec4) -> f32 {
    rgba[0].min(rgba[1]).min(rgba[2])
}

fn max_rgb(rgba: &Vec4) -> f32 {
    rgba[0].max(rgba[1]).max(rgba[2])
}

fn saturation(rgba: &Vec4) -> f32 {
    max_rgb(rgba) - min_rgb(rgba)
}

fn set_lum(cbase: &Vec4, clum: &Vec4) -> Vec4 {
    let lbase = luminance(cbase);
    let llum = luminance(clum);
    let ldiff = llum - lbase;
    let color = add_scalar(cbase, ldiff);
    let vllum = [llum; 4];
    if min_rgb(&color) < 0.0 {
        let k = llum / (llum - min_rgb(&color));
        let d = [
            color[0] - vllum[0],
            color[1] - vllum[1],
            color[2] - vllum[2],
            color[3] - vllum[3],
        ];
        let s = scale(&d, k);
        [vllum[0] + s[0], vllum[1] + s[1], vllum[2] + s[2], vllum[3] + s[3]]
    } else if max_rgb(&color) > 1.0 {
        let k = (1.0 - llum) / (max_rgb(&color) - llum);
        let d = [
            color[0] - vllum[0],
            color[1] - vllum[1],
            color[2] - vllum[2],
            color[3] - vllum[3],
        ];
        let s = scale(&d, k);
        [vllum[0] + s[0], vllum[1] + s[1], vllum[2] + s[2], vllum[3] + s[3]]
    } else {
        color
    }
}

fn set_lum_sat(cbase: &Vec4, csat: &Vec4, clum: &Vec4) -> Vec4 {
    let minbase = min_rgb(cbase);
    let sbase = saturation(cbase);
    let ssat = saturation(csat);
    let color = if sbase > 0.0 {
        let shifted = add_scalar(cbase, -minbase);
        [
            shifted[0] * ssat / sbase,
            shifted[1] * ssat / sbase,
            shifted[2] * ssat / sbase,
            shifted[3] * ssat / sbase,
        ]
    } else {
        [0.0; 4]
    };
    set_lum(&color, clum)
}

fn blend_hsl_hue(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(set_lum_sat(src, dst, dst), src, dst)
}

fn blend_hsl_saturation(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(set_lum_sat(dst, src, dst), src, dst)
}

fn blend_hsl_color(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(set_lum(src, dst), src, dst)
}

fn blend_hsl_luminosity(src: &Vec4, dst: &Vec4) -> Vec4 {
    blend(set_lum(dst, src), src, dst)
}

pub fn get_blend_func(mode: glw::GLenum) -> BlendFunc {
    match mode {
        glw::GL_MULTIPLY_KHR => blend_multiply,
        glw::GL_SCREEN_KHR => blend_screen,
        glw::GL_OVERLAY_KHR => blend_overlay,
        glw::GL_DARKEN_KHR => blend_darken,
        glw::GL_LIGHTEN_KHR => blend_lighten,
        glw::GL_COLORDODGE_KHR => blend_color_dodge,
        glw::GL_COLORBURN_KHR => blend_color_burn,
        glw::GL_HARDLIGHT_KHR => blend_hard_light,
        glw::GL_SOFTLIGHT_KHR => blend_soft_light,
        glw::GL_DIFFERENCE_KHR => blend_difference,
        glw::GL_EXCLUSION_KHR => blend_exclusion,
        glw::GL_HSL_HUE_KHR => blend_hsl_hue,
        glw::GL_HSL_SATURATION_KHR => blend_hsl_saturation,
        glw::GL_HSL_COLOR_KHR => blend_hsl_color,
        glw::GL_HSL_LUMINOSITY_KHR => blend_hsl_luminosity,
        _ => panic!("Blend mode not from GL_KHR_blend_equation_advanced."),
    }
}

fn to_normal(v: &Vec4) -> Vec4 {
    let a = v[3];
    if a == 0.0 {
        return [0.0; 4];
    }
    [v[0] / a, v[1] / a, v[2] / a, a]
}

/// Blend premultiplied src and dst with the given blend mode.
pub fn blend_mode(mode: glw::GLenum, src: &Vec4, dst: &Vec4) -> Vec4 {
    let func = get_blend_func(mode);
    func(&to_normal(src), &to_normal(dst))
}
