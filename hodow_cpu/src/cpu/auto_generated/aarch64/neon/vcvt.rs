use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcvt_f32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_f64(create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f32_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f32_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f32_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vcvt_f32_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vcvt_f32_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_f64(create_float64x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f32_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vcvt_f32_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvt_f32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vcvt_f32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_f64_f32(create_float32x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_f64_f32(create_float32x2_t_from([0.0f32, -1.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_f64_f32(create_float32x2_t_from([100.0f32, 200.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_f64_f32(create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028234663852886e38, -3.4028234663852886e38]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_f64_f32(create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028234663852886e38, 3.4028234663852886e38]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_f64_f32(create_float32x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_f64_f32(create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_f64_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_s64(create_int64x1_t_from([1])));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_s64(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_s64(create_int64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_s64(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_s64(create_int64x1_t_from([100])));
        check_float_array_equality(&result, &[100.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_s64(create_int64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_s64(create_int64x1_t_from([i64::MIN])));
        check_float_array_equality(&result, &[-9.223372036854776e18]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_s64(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_s64(create_int64x1_t_from([i64::MAX])));
        check_float_array_equality(&result, &[9.223372036854776e18]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_s64(create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_s64(create_int64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_s64(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_s64(create_int64x1_t_from([-1])));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_s64(create_int64x1_t_from([-1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_s64(create_int64x1_t_from([i64::MIN])));
        check_float_array_equality(&result, &[-9.223372036854776e18]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_s64(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_s64(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_u64(create_uint64x1_t_from([1])));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_u64(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_u64(create_uint64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_u64(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_u64(create_uint64x1_t_from([100])));
        check_float_array_equality(&result, &[100.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_u64(create_uint64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_u64(create_uint64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_u64(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_u64(create_uint64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[1.8446744073709552e19]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_u64(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_u64(create_uint64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_u64(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_u64(create_uint64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[1.8446744073709552e19]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_u64(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_f64_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_f64_u64(create_uint64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_f64_u64(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_f64_u64(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvt_high_f32_f64(create_float32x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f32_f64(create_float32x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvt_high_f32_f64(create_float32x2_t_from([0.0f32, -1.0f32]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, -1.0, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f32_f64(create_float32x2_t_from([0.0f32, -1.0f32]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvt_high_f32_f64(create_float32x2_t_from([100.0f32, 200.0f32]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[100.0, 200.0, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f32_f64(create_float32x2_t_from([100.0f32, 200.0f32]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvt_high_f32_f64(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f32_f64(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvt_high_f32_f64(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f32_f64(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvt_high_f32_f64(create_float32x2_t_from([0.0, 0.0]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f32_f64(create_float32x2_t_from([0.0, 0.0]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvt_high_f32_f64(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f32_f64(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvt_high_f32_f64(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f32_f64(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f64_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_high_f64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f64_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f64_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_high_f64_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f64_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f64_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_high_f64_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f64_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f64_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_high_f64_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028234663852886e38, -3.4028234663852886e38]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f64_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f64_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_high_f64_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028234663852886e38, 3.4028234663852886e38]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f64_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f64_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_high_f64_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f64_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f64_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_high_f64_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f64_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_high_f64_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vcvt_high_f64_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[-0.0, 5.877471754111438e-39]).map_err(|e| crate::cpu::with_call(e, "vcvt_high_f64_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_high_f64_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<1>(create_int64x1_t_from([1])));
        check_float_array_equality(&result, &[0.5]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<1>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<1>(create_int64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<1>(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<1>(create_int64x1_t_from([100])));
        check_float_array_equality(&result, &[50.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<1>(create_int64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<1>(create_int64x1_t_from([i64::MIN])));
        check_float_array_equality(&result, &[-4.611686018427388e18]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<1>(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<1>(create_int64x1_t_from([i64::MAX])));
        check_float_array_equality(&result, &[4.611686018427388e18]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<1>(create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<1>(create_int64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<1>(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<1>(create_int64x1_t_from([-1])));
        check_float_array_equality(&result, &[-0.5]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<1>(create_int64x1_t_from([-1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<1>(create_int64x1_t_from([i64::MIN])));
        check_float_array_equality(&result, &[-4.611686018427388e18]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<1>(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<2>(create_int64x1_t_from([1])));
        check_float_array_equality(&result, &[0.25]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<2>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<2>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<64>(create_int64x1_t_from([1])));
        check_float_array_equality(&result, &[5.421010862427522e-20]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<64>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<64>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<63>(create_int64x1_t_from([1])));
        check_float_array_equality(&result, &[1.0842021724855044e-19]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<63>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<63>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_s64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_s64::<32>(create_int64x1_t_from([1])));
        check_float_array_equality(&result, &[2.3283064365386963e-10]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_s64::<32>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_s64::<32>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<1>(create_uint64x1_t_from([1])));
        check_float_array_equality(&result, &[0.5]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<1>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<1>(create_uint64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<1>(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<1>(create_uint64x1_t_from([100])));
        check_float_array_equality(&result, &[50.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<1>(create_uint64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<1>(create_uint64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<1>(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<1>(create_uint64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[9.223372036854776e18]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<1>(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<1>(create_uint64x1_t_from([0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<1>(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<1>(create_uint64x1_t_from([u64::MAX])));
        check_float_array_equality(&result, &[9.223372036854776e18]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<1>(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<1>(create_uint64x1_t_from([u64::MIN])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<1>(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<2>(create_uint64x1_t_from([1])));
        check_float_array_equality(&result, &[0.25]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<2>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<2>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<64>(create_uint64x1_t_from([1])));
        check_float_array_equality(&result, &[5.421010862427522e-20]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<64>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<64>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<63>(create_uint64x1_t_from([1])));
        check_float_array_equality(&result, &[1.0842021724855044e-19]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<63>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<63>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_f64_u64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcvt_n_f64_u64::<32>(create_uint64x1_t_from([1])));
        check_float_array_equality(&result, &[2.3283064365386963e-10]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_f64_u64::<32>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_f64_u64::<32>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<1>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<1>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<1>(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<1>(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<1>(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[200]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<1>(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<1>(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<1>(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<1>(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<1>(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<1>(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<1>(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<1>(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<1>(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<1>(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<1>(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<2>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<2>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<2>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<64>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<64>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<64>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<31>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[2147483648]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<31>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<31>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_s64_f64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_n_s64_f64::<32>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[4294967296]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_s64_f64::<32>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_s64_f64::<32>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<1>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<1>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<1>(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<1>(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<1>(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[200]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<1>(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<1>(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<1>(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<1>(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<1>(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<1>(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<1>(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<1>(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<1>(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<1>(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<1>(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<1>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<2>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[4]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<2>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<2>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<64>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<64>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<64>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<31>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[2147483648]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<31>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<31>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_n_u64_f64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_n_u64_f64::<32>(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[4294967296]).map_err(|e| crate::cpu::with_call(e, "vcvt_n_u64_f64::<32>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_n_u64_f64::<32>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_s64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_s64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vcvt_s64_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_s64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_s64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_s64_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_s64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_s64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[100]).map_err(|e| crate::cpu::with_call(e, "vcvt_s64_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_s64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_s64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vcvt_s64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_s64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_s64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vcvt_s64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_s64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_s64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_s64_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_s64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_s64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_s64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_s64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcvt_s64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vcvt_s64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_s64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_u64_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_u64_f64(create_float64x1_t_from([1.0])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vcvt_u64_f64(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_u64_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_u64_f64(create_float64x1_t_from([0.0f64])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_u64_f64(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_u64_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_u64_f64(create_float64x1_t_from([100.0f64])));
        check_array_equality(&result, &[100]).map_err(|e| crate::cpu::with_call(e, "vcvt_u64_f64(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_u64_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_u64_f64(create_float64x1_t_from([f64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_u64_f64(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_u64_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_u64_f64(create_float64x1_t_from([f64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcvt_u64_f64(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_u64_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_u64_f64(create_float64x1_t_from([0.0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_u64_f64(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_u64_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_u64_f64(create_float64x1_t_from([f64::NAN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcvt_u64_f64(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvt_u64_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcvt_u64_f64(create_float64x1_t_from([f64::INFINITY])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcvt_u64_f64(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvt_u64_f64(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}
