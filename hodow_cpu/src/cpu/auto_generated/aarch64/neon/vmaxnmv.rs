use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vmaxnmv_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxnmv_f32(create_float32x2_t_from([1.0, 2.0]));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vmaxnmv_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxnmv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxnmv_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxnmv_f32(create_float32x2_t_from([0.0f32, -1.0f32]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmaxnmv_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxnmv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxnmv_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxnmv_f32(create_float32x2_t_from([100.0f32, 200.0f32]));
        check_float_equality(result, 200.0).map_err(|e| crate::cpu::with_call(e, "vmaxnmv_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxnmv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxnmv_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxnmv_f32(create_float32x2_t_from([f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vmaxnmv_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxnmv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxnmv_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxnmv_f32(create_float32x2_t_from([f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vmaxnmv_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxnmv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxnmv_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxnmv_f32(create_float32x2_t_from([0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmaxnmv_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxnmv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxnmv_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxnmv_f32(create_float32x2_t_from([f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "vmaxnmv_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxnmv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmaxnmv_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmaxnmv_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vmaxnmv_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmaxnmv_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}
