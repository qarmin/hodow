#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_arm_shared_neon_vrsqrte_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrte_f32(create_float32x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[0.9980469, 0.7050781]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_f32(create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrte_f32(create_float32x2_t_from([0.0f32, -1.0f32])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_f32(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrte_f32(create_float32x2_t_from([100.0f32, 200.0f32])));
        check_float_array_equality(&result, &[0.099853516, 0.07055664]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_f32(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrte_f32(create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_f32(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrte_f32(create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[5.421011e-20, 5.421011e-20]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_f32(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrte_f32(create_float32x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_f32(create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrte_f32(create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_f32(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vrsqrte_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_float_array_equality(&result, &[0.0, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_f32(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsqrte_u32(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_u32(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsqrte_u32(create_uint32x2_t_from([0, 4294967295])));
        check_array_equality(&result, &[4294967295, 2147483648]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_u32(create_uint32x2_t_from([0, 4294967295]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsqrte_u32(create_uint32x2_t_from([100, 200])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_u32(create_uint32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsqrte_u32(create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_u32(create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsqrte_u32(create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2147483648, 2147483648]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsqrte_u32(create_uint32x2_t_from([0, 0])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_u32(create_uint32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsqrte_u32(create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2147483648, 2147483648]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vrsqrte_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vrsqrte_u32(create_uint32x2_t_from([u32::MIN, u32::MAX])));
        check_array_equality(&result, &[4294967295, 2147483648]).map_err(|e| crate::cpu::with_call(e, "vrsqrte_u32(create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrsqrte_u32(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}
