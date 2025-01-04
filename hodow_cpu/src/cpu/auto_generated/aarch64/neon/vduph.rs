use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vduph_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<0>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<0>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<0>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result, -32768).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<0>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result, 32767).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<0>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<0>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<0>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result, -32768).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<0>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<1>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 8).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<7>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_s16::<3>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<0>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<0>(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<0>(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<0>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<0>(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<0>(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<0>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<0>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<0>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<0>(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<0>(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<0>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<0>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<0>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<1>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<7>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 8).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<7>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<7>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_u16::<3>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_u16::<3>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_u16::<3>(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<0>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<0>(create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<0>(create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<0>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<0>(create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<0>(create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<0>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<0>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<0>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<0>(create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<0>(create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<0>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<0>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<0>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<1>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<7>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 8).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<7>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<7>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_laneq_p16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_laneq_p16::<3>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vduph_laneq_p16::<3>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_laneq_p16::<3>(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<0>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<0>(create_int16x4_t_from([0, -1, 2, -3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<0>(create_int16x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<0>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<0>(create_int16x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<0>(create_int16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<0>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result, -32768).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<0>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result, 32767).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<0>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<0>(create_int16x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<0>(create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<0>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<0>(create_int16x4_t_from([-1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<0>(create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<0>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result, -32768).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<0>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<1>(create_int16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<1>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<1>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_s16::<3>(create_int16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vduph_lane_s16::<3>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_s16::<3>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<0>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<0>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<0>(create_uint16x4_t_from([0, 65535, 2, 65533]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<0>(create_uint16x4_t_from([0, 65535, 2, 65533]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<0>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<0>(create_uint16x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<0>(create_uint16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<0>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<0>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<0>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<0>(create_uint16x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<0>(create_uint16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<0>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<0>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<0>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<0>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<0>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<1>(create_uint16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<1>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<1>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_u16::<3>(create_uint16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vduph_lane_u16::<3>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_u16::<3>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<0>(create_poly16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<0>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<0>(create_poly16x4_t_from([0, 65535, 2, 65533]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<0>(create_poly16x4_t_from([0, 65535, 2, 65533]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<0>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<0>(create_poly16x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<0>(create_poly16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<0>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<0>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<0>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<0>(create_poly16x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<0>(create_poly16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<0>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<0>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<0>(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<0>(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<0>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<1>(create_poly16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<1>(create_poly16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<1>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vduph_lane_p16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vduph_lane_p16::<3>(create_poly16x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vduph_lane_p16::<3>(create_poly16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vduph_lane_p16::<3>(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}
