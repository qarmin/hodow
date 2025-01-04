use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vreinterpretq_s64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[4607182418800017408, 4611686018427387904]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, -4616189618054758400]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[4636737291354636288, 4641240890982006784]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[-4503599627370497, -4503599627370497]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[9218868437227405311, 9218868437227405311]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[9221120237041090560, 9221120237041090560]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[9218868437227405312, -4503599627370496]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[4607182418800017408, 4611686018427387904]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 13830554455654793216]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[4636737291354636288, 4641240890982006784]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[18442240474082181119, 18442240474082181119]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[9218868437227405311, 9218868437227405311]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[9221120237041090560, 9221120237041090560]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[9218868437227405312, 18442240474082181120]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[4607182418800017408, 4611686018427387904]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 13830554455654793216]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[4636737291354636288, 4641240890982006784]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[18442240474082181119, 18442240474082181119]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[9218868437227405311, 9218868437227405311]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[9221120237041090560, 9221120237041090560]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[9218868437227405312, 18442240474082181120]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s64(create_int64x2_t_from([1, 2])));
        check_float_array_equality(&result, &[5e-324, 1e-323]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s64(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s64(create_int64x2_t_from([0, -1])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s64(create_int64x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s64(create_int64x2_t_from([100, 200])));
        check_float_array_equality(&result, &[4.94e-322, 9.9e-322]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s64(create_int64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s64(create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_float_array_equality(&result, &[-0.0, -0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s64(create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s64(create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s64(create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s64(create_int64x2_t_from([0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s64(create_int64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s64(create_int64x2_t_from([-1, -1])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s64(create_int64x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s64(create_int64x2_t_from([i64::MIN, i64::MAX])));
        check_float_array_equality(&result, &[-0.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s64(create_int64x2_t_from([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_s64(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_s64(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_s64(create_int64x2_t_from([0, -1])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_s64(create_int64x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_s64(create_int64x2_t_from([100, 200])));
        check_array_equality(&result, &[100, 200]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_s64(create_int64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_s64(create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[9223372036854775808, 9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_s64(create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_s64(create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_s64(create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_s64(create_int64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_s64(create_int64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_s64(create_int64x2_t_from([-1, -1])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_s64(create_int64x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_s64(create_int64x2_t_from([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[9223372036854775808, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_s64(create_int64x2_t_from([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_s64(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u64(create_uint64x2_t_from([1, 2])));
        check_float_array_equality(&result, &[5e-324, 1e-323]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u64(create_uint64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u64(create_uint64x2_t_from([0, 18446744073709551615])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u64(create_uint64x2_t_from([0, 18446744073709551615]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u64(create_uint64x2_t_from([100, 200])));
        check_float_array_equality(&result, &[4.94e-322, 9.9e-322]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u64(create_uint64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u64(create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u64(create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u64(create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u64(create_uint64x2_t_from([0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u64(create_uint64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u64(create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u64(create_uint64x2_t_from([u64::MIN, u64::MAX])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u64(create_uint64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u64(create_uint64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_u64(create_uint64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u64(create_uint64x2_t_from([0, 18446744073709551615])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_u64(create_uint64x2_t_from([0, 18446744073709551615]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u64(create_uint64x2_t_from([100, 200])));
        check_array_equality(&result, &[100, 200]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_u64(create_uint64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u64(create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_u64(create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u64(create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u64(create_uint64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_u64(create_uint64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u64(create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_u64(create_uint64x2_t_from([u64::MIN, u64::MAX])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_u64(create_uint64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_u64(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p64(create_poly64x2_t_from([1, 2])));
        check_float_array_equality(&result, &[5e-324, 1e-323]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p64(create_poly64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p64(create_poly64x2_t_from([0, 18446744073709551615])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p64(create_poly64x2_t_from([0, 18446744073709551615]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p64(create_poly64x2_t_from([100, 200])));
        check_float_array_equality(&result, &[4.94e-322, 9.9e-322]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p64(create_poly64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p64(create_poly64x2_t_from([u64::MIN, u64::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p64(create_poly64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p64(create_poly64x2_t_from([0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p64(create_poly64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p64(create_poly64x2_t_from([u64::MIN, u64::MAX])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p64(create_poly64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p64(create_poly64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_p64(create_poly64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p64(create_poly64x2_t_from([0, 18446744073709551615])));
        check_array_equality(&result, &[0, -1]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_p64(create_poly64x2_t_from([0, 18446744073709551615]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p64(create_poly64x2_t_from([100, 200])));
        check_array_equality(&result, &[100, 200]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_p64(create_poly64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p64(create_poly64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_p64(create_poly64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p64(create_poly64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_p64(create_poly64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s64_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p64(create_poly64x2_t_from([u64::MIN, u64::MAX])));
        check_array_equality(&result, &[0, -1]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_p64(create_poly64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p64(create_poly64x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 2]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_p64(create_poly64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p64(create_poly64x2_t_from([0, 18446744073709551615])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_p64(create_poly64x2_t_from([0, 18446744073709551615]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p64(create_poly64x2_t_from([100, 200])));
        check_array_equality(&result, &[100, 200]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_p64(create_poly64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p64(create_poly64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_p64(create_poly64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p64(create_poly64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_p64(create_poly64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u64_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p64(create_poly64x2_t_from([u64::MIN, u64::MAX])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_p64(create_poly64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p128(1u128));
        check_float_array_equality(&result, &[5e-324, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.000000473111868, 512.0001225471497]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[-0.0078125, -32.00000762939453]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[1.35108011229184e16, 3.4587650943793234e18]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-1.4044477603031902e306, -1.4044477603031902e306]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.4044474254567505e306, 1.4044474254567505e306]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[2.247117487993712e307, 2.247117487993712e307]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[-1.404448428688076e306, 1.7800599356040775e-307]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[4611686019492741120, 4647714816524288000]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[13799029258263199744, 13853072454865387520]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[4848124999984742400, 4884153797017206784]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[18410715276682199039, 18410715276682199039]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[9187343237679939583, 9187343237679939583]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[9205357640488583168, 9205357640488583168]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p64_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[18410715278829682688, 18014400656965632]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p128_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vreinterpretq_p128_f64(create_float64x2_t_from([1.0, 2.0]));
        check_int_equality(result, 85070591730234615870450834276742070272).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p128_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p128_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p128_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vreinterpretq_p128_f64(create_float64x2_t_from([0.0f64, -1.0f64]));
        check_int_equality(result, 255128698440967290355474467632558637056).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p128_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p128_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p128_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vreinterpretq_p128_f64(create_float64x2_t_from([100.0f64, 200.0f64]));
        check_int_equality(result, 85615782900380772771476091263864799232).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p128_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p128_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p128_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vreinterpretq_p128_f64(create_float64x2_t_from([f64::MIN, f64::MIN]));
        check_int_equality(result, 340199290171201906221313615890873319423).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p128_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p128_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p128_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vreinterpretq_p128_f64(create_float64x2_t_from([f64::MAX, f64::MAX]));
        check_int_equality(result, 170058106710732674480402940138134437887).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p128_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p128_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p128_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vreinterpretq_p128_f64(create_float64x2_t_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p128_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p128_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p128_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vreinterpretq_p128_f64(create_float64x2_t_from([f64::NAN, f64::NAN]));
        check_int_equality(result, 170099645085600953119880179982291435520).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p128_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p128_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p128_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vreinterpretq_p128_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, 340199290171201906230536987927728095232).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p128_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p128_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_f64(create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, 1.875, 0.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, -1.875]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[0.0, 3.390625, 0.0, 3.640625]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_f64(create_float64x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[0.0, f32::NAN, 0.0, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0, f32::NAN, 0.0, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s8_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, -16, 63, 0, 0, 0, 0, 0, 0, 0, 64]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s8_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s8_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -16, -65]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s8_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s8_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 89, 64, 0, 0, 0, 0, 0, 0, 105, 64]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s8_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s8_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -17, -1, -1, -1, -1, -1, -1, -1, -17, -1]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s8_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s8_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -17, 127, -1, -1, -1, -1, -1, -1, -17, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s8_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s8_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s8_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s8_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, -8, 127, 0, 0, 0, 0, 0, 0, -8, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s8_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s8_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, -16, 127, 0, 0, 0, 0, 0, 0, -16, -1]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s8_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s16_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 16368, 0, 0, 0, 16384]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s16_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s16_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, -16400]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s16_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s16_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 0, 0, 16473, 0, 0, 0, 16489]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s16_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s16_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -17, -1, -1, -1, -17]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s16_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s16_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[-1, -1, -1, 32751, -1, -1, -1, 32751]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s16_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s16_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s16_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s16_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 32760, 0, 0, 0, 32760]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s16_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s16_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 32752, 0, 0, 0, -16]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s16_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s32_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 0, 0, -1074790400]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s32_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 1079574528, 0, 1080623104]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s32_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[-1, -1048577, -1, -1048577]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s32_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[-1, 2146435071, -1, 2146435071]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s32_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s32_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 2146959360, 0, 2146959360]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s32_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_s32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 2146435072, 0, -1048576]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u8_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 63, 0, 0, 0, 0, 0, 0, 0, 64]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u8_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u8_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 191]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u8_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u8_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 89, 64, 0, 0, 0, 0, 0, 0, 105, 64]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u8_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u8_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 239, 255, 255, 255, 255, 255, 255, 255, 239, 255]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u8_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u8_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 239, 127, 255, 255, 255, 255, 255, 255, 239, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u8_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u8_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u8_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u8_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 248, 127, 0, 0, 0, 0, 0, 0, 248, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u8_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u8_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 127, 0, 0, 0, 0, 0, 0, 240, 255]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u8_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u16_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 16368, 0, 0, 0, 16384]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u16_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u16_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 49136]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u16_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u16_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 0, 0, 16473, 0, 0, 0, 16489]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u16_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u16_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[65535, 65535, 65535, 65519, 65535, 65535, 65535, 65519]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u16_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u16_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 32751, 65535, 65535, 65535, 32751]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u16_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u16_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u16_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u16_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 32760, 0, 0, 0, 32760]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u16_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u16_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 32752, 0, 0, 0, 65520]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u16_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u32_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 0, 0, 3220176896]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u32_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 1079574528, 0, 1080623104]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u32_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[4294967295, 4293918719, 4294967295, 4293918719]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u32_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[4294967295, 2146435071, 4294967295, 2146435071]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u32_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u32_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 2146959360, 0, 2146959360]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u32_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_u32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 2146435072, 0, 4293918720]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p8_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 63, 0, 0, 0, 0, 0, 0, 0, 64]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p8_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p8_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 191]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p8_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p8_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 89, 64, 0, 0, 0, 0, 0, 0, 105, 64]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p8_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p8_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 239, 255, 255, 255, 255, 255, 255, 255, 239, 255]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p8_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p8_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 239, 127, 255, 255, 255, 255, 255, 255, 239, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p8_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p8_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p8_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p8_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 248, 127, 0, 0, 0, 0, 0, 0, 248, 127]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p8_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p8_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 240, 127, 0, 0, 0, 0, 0, 0, 240, 255]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p8_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p8_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p16_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_f64(create_float64x2_t_from([1.0, 2.0])));
        check_array_equality(&result, &[0, 0, 0, 16368, 0, 0, 0, 16384]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p16_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p16_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 49136]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p16_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p16_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_array_equality(&result, &[0, 0, 0, 16473, 0, 0, 0, 16489]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p16_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p16_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_array_equality(&result, &[65535, 65535, 65535, 65519, 65535, 65535, 65535, 65519]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p16_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p16_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 32751, 65535, 65535, 65535, 32751]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p16_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p16_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_f64(create_float64x2_t_from([0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p16_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p16_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_array_equality(&result, &[0, 0, 0, 32760, 0, 0, 0, 32760]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p16_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_p16_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_array_equality(&result, &[0, 0, 0, 32752, 0, 0, 0, 65520]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p16_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p16_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[5.447603722011605e-270, 2.500364306227096e-231]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s8(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7])));
        check_float_array_equality(&result, &[-9.94549446667078e274, -9.94549446667078e274]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s8(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s8(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64])));
        check_float_array_equality(&result, &[5.4124845484462095e-151, 29152.32326052386]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s8(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_float_array_equality(&result, &[-2.937446524422997e-306, -2.937446524422997e-306]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_float_array_equality(&result, &[1.3824172084878715e306, 1.3824172084878715e306]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s8(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s8(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s8(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s8(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s8(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_float_array_equality(&result, &[-5.656900964641977e303, -5.656900964641977e303]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s8(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s8(create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[5.56274830678932e-309, 1.1125517834184144e-308]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800])));
        check_float_array_equality(&result, &[3.73412252032966e-301, 1.253441440144609e-293]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_float_array_equality(&result, &[-6.9534619092435e-310, -6.9534619092435e-310]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s16(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s32(create_int32x4_t_from([0, -1, 2, -3])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s32(create_int32x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s32(create_int32x4_t_from([100, 200, 300, 400])));
        check_float_array_equality(&result, &[4.243991582425e-312, 8.487983165343e-312]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s32(create_int32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_float_array_equality(&result, &[-1.0609978955e-314, -1.0609978955e-314]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s32(create_int32x4_t_from([0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s32(create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s32(create_int32x4_t_from([-1, -1, -1, -1])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s32(create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[5.447603722011605e-270, 2.500364306227096e-231]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u8(create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249])));
        check_float_array_equality(&result, &[-9.94549446667078e274, -9.94549446667078e274]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u8(create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u8(create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64])));
        check_float_array_equality(&result, &[5.4124845484462095e-151, 29152.32326052386]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u8(create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u8(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u8(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u8(create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u8(create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u8(create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_float_array_equality(&result, &[-5.82767264895205e303, -5.82767264895205e303]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u8(create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u8(create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[5.56274830678932e-309, 1.1125517834184144e-308]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u16(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u16(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u16(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800])));
        check_float_array_equality(&result, &[3.73412252032966e-301, 1.253441440144609e-293]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u16(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u16(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u16(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u16(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u16(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u16(create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u32(create_uint32x4_t_from([100, 200, 300, 400])));
        check_float_array_equality(&result, &[4.243991582425e-312, 8.487983165343e-312]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u32(create_uint32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u32(create_uint32x4_t_from([0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u32(create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p8(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[5.447603722011605e-270, 2.500364306227096e-231]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p8(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p8(create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p8(create_poly8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249])));
        check_float_array_equality(&result, &[-9.94549446667078e274, -9.94549446667078e274]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p8(create_poly8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p8(create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p8(create_poly8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64])));
        check_float_array_equality(&result, &[5.4124845484462095e-151, 29152.32326052386]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p8(create_poly8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p8(create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p8(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p8(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p8(create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p8(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p8(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p8(create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p8(create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p8(create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p8(create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p8(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p8(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p8(create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p8(create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_float_array_equality(&result, &[-5.82767264895205e303, -5.82767264895205e303]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p8(create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p8(create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p16(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[5.56274830678932e-309, 1.1125517834184144e-308]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p16(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p16(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p16(create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p16(create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p16(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p16(create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800])));
        check_float_array_equality(&result, &[3.73412252032966e-301, 1.253441440144609e-293]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p16(create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p16(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p16(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p16(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p16(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p16(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p16(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p16(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p16(create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p16(create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p16(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p16(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p16(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p16(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f64_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vreinterpretq_f64_p16(create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f64_p16(create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f64_p16(create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_p64(create_poly64x2_t_from([1, 2])));
        check_float_array_equality(&result, &[1e-45, 0.0, 3e-45, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_p64(create_poly64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_p64(create_poly64x2_t_from([0, 18446744073709551615])));
        check_float_array_equality(&result, &[0.0, 0.0, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_p64(create_poly64x2_t_from([0, 18446744073709551615]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_p64(create_poly64x2_t_from([100, 200])));
        check_float_array_equality(&result, &[1.4e-43, 0.0, 2.8e-43, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_p64(create_poly64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_p64(create_poly64x2_t_from([u64::MIN, u64::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_p64(create_poly64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_p64(create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_p64(create_poly64x2_t_from([0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_p64(create_poly64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_p64(create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vreinterpretq_f32_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vreinterpretq_f32_p64(create_poly64x2_t_from([u64::MIN, u64::MAX])));
        check_float_array_equality(&result, &[0.0, 0.0, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_f32_p64(create_poly64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_f32_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
