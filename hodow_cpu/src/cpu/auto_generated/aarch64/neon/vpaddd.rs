use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vpaddd_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_f64(create_float64x2_t_from([1.0, 2.0]));
        check_float_equality(result, 3.0).map_err(|e| crate::cpu::with_call(e, "vpaddd_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_f64(create_float64x2_t_from([0.0f64, -1.0f64]));
        check_float_equality(result, -1.0).map_err(|e| crate::cpu::with_call(e, "vpaddd_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_f64(create_float64x2_t_from([100.0f64, 200.0f64]));
        check_float_equality(result, 300.0).map_err(|e| crate::cpu::with_call(e, "vpaddd_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_f64(create_float64x2_t_from([f64::MIN, f64::MIN]));
        check_float_equality(result, -f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "vpaddd_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_f64(create_float64x2_t_from([f64::MAX, f64::MAX]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "vpaddd_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_f64(create_float64x2_t_from([0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vpaddd_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_f64(create_float64x2_t_from([f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "vpaddd_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "vpaddd_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_s64(create_int64x2_t_from([1, 2]));
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "vpaddd_s64(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_s64(create_int64x2_t_from([0, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vpaddd_s64(create_int64x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_s64(create_int64x2_t_from([100, 200]));
        check_int_equality(result, 300).map_err(|e| crate::cpu::with_call(e, "vpaddd_s64(create_int64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_s64(create_int64x2_t_from([i64::MIN, i64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vpaddd_s64(create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_s64(create_int64x2_t_from([i64::MAX, i64::MAX]));
        check_int_equality(result, -2).map_err(|e| crate::cpu::with_call(e, "vpaddd_s64(create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_s64(create_int64x2_t_from([0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vpaddd_s64(create_int64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_s64(create_int64x2_t_from([-1, -1]));
        check_int_equality(result, -2).map_err(|e| crate::cpu::with_call(e, "vpaddd_s64(create_int64x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_s64(create_int64x2_t_from([i64::MIN, i64::MAX]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vpaddd_s64(create_int64x2_t_from([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_u64(create_uint64x2_t_from([1, 2]));
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "vpaddd_u64(create_uint64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_u64(create_uint64x2_t_from([0, 18446744073709551615]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vpaddd_u64(create_uint64x2_t_from([0, 18446744073709551615]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_u64(create_uint64x2_t_from([100, 200]));
        check_int_equality(result, 300).map_err(|e| crate::cpu::with_call(e, "vpaddd_u64(create_uint64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_u64(create_uint64x2_t_from([u64::MIN, u64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vpaddd_u64(create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]));
        check_int_equality(result, 18446744073709551614).map_err(|e| crate::cpu::with_call(e, "vpaddd_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_u64(create_uint64x2_t_from([0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vpaddd_u64(create_uint64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]));
        check_int_equality(result, 18446744073709551614).map_err(|e| crate::cpu::with_call(e, "vpaddd_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vpaddd_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vpaddd_u64(create_uint64x2_t_from([u64::MIN, u64::MAX]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vpaddd_u64(create_uint64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vpaddd_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
