use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcvtx_f32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_f32_f64(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_f32_f64(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[100.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_f32_f64(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcvtx_f32_f64(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcvtx_f32_f64(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_f32_f64(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vcvtx_f32_f64(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_f32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcvtx_f32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vcvtx_f32_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_f32_f64(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_high_f32_f64(create_float32x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([0.0f32, -1.0f32]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, -1.0, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_high_f32_f64(create_float32x2_t_from([0.0f32, -1.0f32]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([100.0f32, 200.0f32]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[100.0, 200.0, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_high_f32_f64(create_float32x2_t_from([100.0f32, 200.0f32]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_high_f32_f64(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_high_f32_f64(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([0.0, 0.0]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_high_f32_f64(create_float32x2_t_from([0.0, 0.0]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_high_f32_f64(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtx_high_f32_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtx_high_f32_f64(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, 1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtx_high_f32_f64(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtx_high_f32_f64(create_random_float32x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
