use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vreinterpret_s64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[4607182418800017408]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[4636737291354636288]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[-4503599627370497]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[9218868437227405311]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[9221120237041090560]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[9218868437227405312]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[4607182418800017408]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[4636737291354636288]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[18442240474082181119]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[9218868437227405311]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[9221120237041090560]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[9218868437227405312]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[4607182418800017408]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[4636737291354636288]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[18442240474082181119]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[9218868437227405311]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[9221120237041090560]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[9218868437227405312]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s64(create_int64x1_t_from([1])));
        check_float_array_equality(&result, &[5e-324]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s64(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s64(create_int64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s64(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s64(create_int64x1_t_from([100])));
        check_float_array_equality(&result, &[4.94e-322]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s64(create_int64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s64(create_int64x1_t_from([i64::MIN])));
        check_float_array_equality(&result, &[-0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s64(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s64(create_int64x1_t_from([i64::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s64(create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s64(create_int64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s64(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s64(create_int64x1_t_from([-1])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s64(create_int64x1_t_from([-1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s64(create_int64x1_t_from([i64::MIN])));
        check_float_array_equality(&result, &[-0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s64(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_s64(create_int64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_s64(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_s64(create_int64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_s64(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_s64(create_int64x1_t_from([100])));
        check_array_equality(&result, &[100]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_s64(create_int64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_s64(create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_s64(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_s64(create_int64x1_t_from([i64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_s64(create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_s64(create_int64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_s64(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_s64(create_int64x1_t_from([-1])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_s64(create_int64x1_t_from([-1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_s64(create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_s64(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u64(create_uint64x1_t_from([1])));
        check_float_array_equality(&result, &[5e-324]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u64(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u64(create_uint64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u64(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u64(create_uint64x1_t_from([100])));
        check_float_array_equality(&result, &[4.94e-322]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u64(create_uint64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u64(create_uint64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u64(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u64(create_uint64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u64(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u64(create_uint64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u64(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u64(create_uint64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u64(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u64(create_uint64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u64(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u64(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_u64(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u64(create_uint64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_u64(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u64(create_uint64x1_t_from([100])));
        check_array_equality(&result, &[100]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_u64(create_uint64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u64(create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_u64(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u64(create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_u64(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u64(create_uint64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_u64(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u64(create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_u64(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_u64(create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_u64(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p64(create_poly64x1_t_from([1])));
        check_float_array_equality(&result, &[5e-324]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p64(create_poly64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p64(create_poly64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p64(create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p64(create_poly64x1_t_from([100])));
        check_float_array_equality(&result, &[4.94e-322]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p64(create_poly64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p64(create_poly64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p64(create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p64(create_poly64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p64(create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p64(create_poly64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p64(create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p64(create_poly64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p64(create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p64(create_poly64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p64(create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_p64(create_poly64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_p64(create_poly64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_p64(create_poly64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_p64(create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_p64(create_poly64x1_t_from([100])));
        check_array_equality(&result, &[100]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_p64(create_poly64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_p64(create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_p64(create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_p64(create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[-1]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_p64(create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_p64(create_poly64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_p64(create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_p64(create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[-1]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_p64(create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s64_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vreinterpret_s64_p64(create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s64_p64(create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_p64(create_poly64x1_t_from([1])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_p64(create_poly64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_p64(create_poly64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_p64(create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_p64(create_poly64x1_t_from([100])));
        check_array_equality(&result, &[100]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_p64(create_poly64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_p64(create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_p64(create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_p64(create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_p64(create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_p64(create_poly64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_p64(create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_p64(create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_p64(create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u64_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vreinterpret_u64_p64(create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u64_p64(create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u64_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_f32(create_float32x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[2.000000473111868]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_f32(create_float32x2_t_from([0.0f32, -1.0f32])));
        check_float_array_equality(&result, &[-0.0078125]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_f32(create_float32x2_t_from([100.0f32, 200.0f32])));
        check_float_array_equality(&result, &[1.35108011229184e16]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_f32(create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.4044477603031902e306]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_f32(create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.4044474254567505e306]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_f32(create_float32x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_f32(create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[2.247117487993712e307]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_float_array_equality(&result, &[-1.404448428688076e306]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f32(create_float32x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[4611686019492741120]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f32(create_float32x2_t_from([0.0f32, -1.0f32])));
        check_array_equality(&result, &[13799029258263199744]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f32(create_float32x2_t_from([100.0f32, 200.0f32])));
        check_array_equality(&result, &[4848124999984742400]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f32(create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_array_equality(&result, &[18410715276682199039]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f32(create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_array_equality(&result, &[9187343237679939583]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f32(create_float32x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f32(create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_array_equality(&result, &[9205357640488583168]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p64_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vreinterpret_p64_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_array_equality(&result, &[18410715278829682688]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p64_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_f64(create_float64x1_t_from([1.0])));
        check_float_array_equality(&result, &[0.0, 1.875]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_f64(create_float64x1_t_from([0.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_f64(create_float64x1_t_from([100.0f64])));
        check_float_array_equality(&result, &[0.0, 3.390625]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_f64(create_float64x1_t_from([f64::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_f64(create_float64x1_t_from([f64::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_f64(create_float64x1_t_from([0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_f64(create_float64x1_t_from([f64::NAN])));
        check_float_array_equality(&result, &[0.0, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_f64(create_float64x1_t_from([f64::INFINITY])));
        check_float_array_equality(&result, &[0.0, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s8_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, -16, 63]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s8_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s8_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s8_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s8_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 89, 64]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s8_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s8_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -17, -1]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s8_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s8_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -17, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s8_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s8_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s8_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s8_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, -8, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s8_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s8_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vreinterpret_s8_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, -16, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s8_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s16_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 16368]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s16_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s16_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s16_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s16_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[0, 0, 0, 16473]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s16_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s16_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -17]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s16_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s16_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[-1, -1, -1, 32751]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s16_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s16_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s16_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s16_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 32760]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s16_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s16_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vreinterpret_s16_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 32752]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s16_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 1072693248]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s32_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s32_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[0, 1079574528]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s32_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[-1, -1048577]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s32_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[-1, 2146435071]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s32_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s32_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0, 2146959360]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s32_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_s32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vreinterpret_s32_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[0, 2146435072]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_s32_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_s32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u8_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 63]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u8_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u8_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u8_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u8_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 89, 64]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u8_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u8_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 239, 255]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u8_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u8_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 239, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u8_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u8_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u8_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u8_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 248, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u8_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u8_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vreinterpret_u8_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u8_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u16_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 16368]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u16_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u16_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u16_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u16_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[0, 0, 0, 16473]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u16_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u16_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[65535, 65535, 65535, 65519]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u16_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u16_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 32751]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u16_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u16_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u16_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u16_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 32760]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u16_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u16_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vreinterpret_u16_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 32752]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u16_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 1072693248]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u32_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u32_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[0, 1079574528]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u32_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[4294967295, 4293918719]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u32_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[4294967295, 2146435071]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u32_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u32_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0, 2146959360]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u32_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_u32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vreinterpret_u32_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[0, 2146435072]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_u32_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_u32_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p8_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 63]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p8_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p8_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p8_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p8_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 89, 64]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p8_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p8_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 239, 255]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p8_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p8_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 239, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p8_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p8_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p8_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p8_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 248, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p8_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p8_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vreinterpret_p8_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p8_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p8_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p16_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[0, 0, 0, 16368]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p16_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p16_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p16_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p16_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[0, 0, 0, 16473]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p16_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p16_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[65535, 65535, 65535, 65519]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p16_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p16_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 32751]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p16_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p16_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p16_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p16_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 32760]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p16_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_p16_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vreinterpret_p16_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 32752]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_p16_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_p16_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[5.447603722011605e-270]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s8(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_float_array_equality(&result, &[-9.94549446667078e274]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s8(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s8(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32])));
        check_float_array_equality(&result, &[5.4124845484462095e-151]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s8(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_float_array_equality(&result, &[-2.937446524422997e-306]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_float_array_equality(&result, &[1.3824172084878715e306]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s8(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s8(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s8(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s8(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s8(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_float_array_equality(&result, &[-5.656900964641977e303]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s8(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s8(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s16(create_int16x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[5.56274830678932e-309]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s16(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s16(create_int16x4_t_from([0, -1, 2, -3])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s16(create_int16x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s16(create_int16x4_t_from([100, 200, 300, 400])));
        check_float_array_equality(&result, &[3.73412252032966e-301]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s16(create_int16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_float_array_equality(&result, &[-6.9534619092435e-310]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s16(create_int16x4_t_from([0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s16(create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s16(create_int16x4_t_from([-1, -1, -1, -1])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s16(create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s16(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s16(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s16(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s32(create_int32x2_t_from([1, 2])));
        check_float_array_equality(&result, &[4.2439915824e-314]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s32(create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s32(create_int32x2_t_from([0, -1])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s32(create_int32x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s32(create_int32x2_t_from([100, 200])));
        check_float_array_equality(&result, &[4.243991582425e-312]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s32(create_int32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s32(create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_float_array_equality(&result, &[-1.0609978955e-314]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s32(create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s32(create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s32(create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s32(create_int32x2_t_from([0, 0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s32(create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s32(create_int32x2_t_from([-1, -1])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s32(create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_s32(create_int32x2_t_from([i32::MIN, i32::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_s32(create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_s32(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[5.447603722011605e-270]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u8(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249])));
        check_float_array_equality(&result, &[-9.94549446667078e274]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u8(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u8(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32])));
        check_float_array_equality(&result, &[5.4124845484462095e-151]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u8(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u8(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u8(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u8(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u8(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u8(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_float_array_equality(&result, &[-5.82767264895205e303]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u8(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u8(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u16(create_uint16x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[5.56274830678932e-309]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u16(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u16(create_uint16x4_t_from([0, 65535, 2, 65533])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u16(create_uint16x4_t_from([0, 65535, 2, 65533]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u16(create_uint16x4_t_from([100, 200, 300, 400])));
        check_float_array_equality(&result, &[3.73412252032966e-301]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u16(create_uint16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u16(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u16(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u16(create_uint16x4_t_from([0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u16(create_uint16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u16(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u16(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u16(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u32(create_uint32x2_t_from([1, 2])));
        check_float_array_equality(&result, &[4.2439915824e-314]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u32(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u32(create_uint32x2_t_from([0, 4294967295])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u32(create_uint32x2_t_from([0, 4294967295]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u32(create_uint32x2_t_from([100, 200])));
        check_float_array_equality(&result, &[4.243991582425e-312]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u32(create_uint32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u32(create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u32(create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u32(create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u32(create_uint32x2_t_from([0, 0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u32(create_uint32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u32(create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_u32(create_uint32x2_t_from([u32::MIN, u32::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_u32(create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p8(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[5.447603722011605e-270]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p8(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p8(create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p8(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249])));
        check_float_array_equality(&result, &[-9.94549446667078e274]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p8(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p8(create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p8(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32])));
        check_float_array_equality(&result, &[5.4124845484462095e-151]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p8(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p8(create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p8(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p8(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p8(create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p8(create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p8(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p8(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p8(create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p8(create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p8(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_float_array_equality(&result, &[-5.82767264895205e303]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p8(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p8(create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p16(create_poly16x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[5.56274830678932e-309]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p16(create_poly16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p16(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p16(create_poly16x4_t_from([0, 65535, 2, 65533])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p16(create_poly16x4_t_from([0, 65535, 2, 65533]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p16(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p16(create_poly16x4_t_from([100, 200, 300, 400])));
        check_float_array_equality(&result, &[3.73412252032966e-301]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p16(create_poly16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p16(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p16(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p16(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p16(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p16(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p16(create_poly16x4_t_from([0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p16(create_poly16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p16(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p16(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f64_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vreinterpret_f64_p16(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f64_p16(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f64_p16(create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_p64(create_poly64x1_t_from([1])));
        check_float_array_equality(&result, &[1e-45, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_p64(create_poly64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_p64(create_poly64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_p64(create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_p64(create_poly64x1_t_from([100])));
        check_float_array_equality(&result, &[1.4e-43, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_p64(create_poly64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_p64(create_poly64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_p64(create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_p64(create_poly64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_p64(create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_p64(create_poly64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_p64(create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_p64(create_poly64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_p64(create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpret_f32_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vreinterpret_f32_p64(create_poly64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpret_f32_p64(create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpret_f32_p64(create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}
