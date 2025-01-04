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

pub(super) fn test_arm_shared_neon_vcvtq_f32_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_s32(create_int32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_s32(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_s32(create_int32x4_t_from([0, -1, 2, -3])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_s32(create_int32x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_s32(create_int32x4_t_from([100, 200, 300, 400])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_s32(create_int32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_float_array_equality(&result, &[-2147483600.0, -2147483600.0, -2147483600.0, -2147483600.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_float_array_equality(&result, &[2147483600.0, 2147483600.0, 2147483600.0, 2147483600.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_s32(create_int32x4_t_from([0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_s32(create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_s32(create_int32x4_t_from([-1, -1, -1, -1])));
        check_float_array_equality(&result, &[-1.0, -1.0, -1.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_s32(create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_float_array_equality(&result, &[-2147483600.0, 2147483600.0, 0.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_s32(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_u32(create_uint32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_u32(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293])));
        check_float_array_equality(&result, &[0.0, 4294967300.0, 2.0, 4294967300.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_u32(create_uint32x4_t_from([100, 200, 300, 400])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_u32(create_uint32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_float_array_equality(&result, &[4294967300.0, 4294967300.0, 4294967300.0, 4294967300.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_u32(create_uint32x4_t_from([0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_u32(create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_float_array_equality(&result, &[4294967300.0, 4294967300.0, 4294967300.0, 4294967300.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_f32_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_f32_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_float_array_equality(&result, &[0.0, 4294967300.0, 0.0, 4294967300.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_f32_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_f32_u32(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<1>(create_int32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.5, 1.0, 1.5, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<1>(create_int32x4_t_from([0, -1, 2, -3])));
        check_float_array_equality(&result, &[0.0, -0.5, 1.0, -1.5]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<1>(create_int32x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<1>(create_int32x4_t_from([100, 200, 300, 400])));
        check_float_array_equality(&result, &[50.0, 100.0, 150.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<1>(create_int32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<1>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_float_array_equality(&result, &[-1073741800.0, -1073741800.0, -1073741800.0, -1073741800.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<1>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<1>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_float_array_equality(&result, &[1073741800.0, 1073741800.0, 1073741800.0, 1073741800.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<1>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<1>(create_int32x4_t_from([0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<1>(create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<1>(create_int32x4_t_from([-1, -1, -1, -1])));
        check_float_array_equality(&result, &[-0.5, -0.5, -0.5, -0.5]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<1>(create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<1>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_float_array_equality(&result, &[-1073741800.0, 1073741800.0, 0.0, -0.5]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<1>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<2>(create_int32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.25, 0.5, 0.75, 1.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<2>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<2>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<32>(create_int32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[2.3283064e-10, 4.656613e-10, 6.9849193e-10, 9.313226e-10]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<32>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<32>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<31>(create_int32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[4.656613e-10, 9.313226e-10, 1.3969839e-9, 1.8626451e-9]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<31>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<31>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_s32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_s32::<16>(create_int32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.5258789e-5, 3.0517578e-5, 4.5776367e-5, 6.1035156e-5]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_s32::<16>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_s32::<16>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.5, 1.0, 1.5, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<1>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293])));
        check_float_array_equality(&result, &[0.0, 2147483600.0, 1.0, 2147483600.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<1>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([100, 200, 300, 400])));
        check_float_array_equality(&result, &[50.0, 100.0, 150.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<1>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<1>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_float_array_equality(&result, &[2147483600.0, 2147483600.0, 2147483600.0, 2147483600.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<1>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([0, 0, 0, 0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<1>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_float_array_equality(&result, &[2147483600.0, 2147483600.0, 2147483600.0, 2147483600.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<1>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_float_array_equality(&result, &[0.0, 2147483600.0, 0.0, 2147483600.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<1>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<1>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<2>(create_uint32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[0.25, 0.5, 0.75, 1.0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<2>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<2>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<32>(create_uint32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[2.3283064e-10, 4.656613e-10, 6.9849193e-10, 9.313226e-10]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<32>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<32>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<31>(create_uint32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[4.656613e-10, 9.313226e-10, 1.3969839e-9, 1.8626451e-9]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<31>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<31>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_f32_u32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vcvtq_n_f32_u32::<16>(create_uint32x4_t_from([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1.5258789e-5, 3.0517578e-5, 4.5776367e-5, 6.1035156e-5]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_f32_u32::<16>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_f32_u32::<16>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[2, 4, 6, 8]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<1>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, -2, 4, -6]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<1>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<1>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[200, 400, 600, 800]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<1>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<1>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<1>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<1>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<1>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<1>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<1>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<1>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<1>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<1>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE])));
        check_array_equality(&result, &[2147483647, -2147483648, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<1>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<2>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[4, 8, 12, 16]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<2>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<2>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<32>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<32>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<32>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<31>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<31>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<31>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_s32_f32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_n_s32_f32::<16>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[65536, 131072, 196608, 262144]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_s32_f32::<16>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_s32_f32::<16>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[2, 4, 6, 8]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<1>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<1>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<1>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[200, 400, 600, 800]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<1>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<1>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<1>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<1>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<1>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<1>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<1>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<1>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<1>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<1>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE])));
        check_array_equality(&result, &[4294967295, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<1>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<2>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[4, 8, 12, 16]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<2>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<2>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<32>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<32>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<32>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<31>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[2147483648, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<31>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<31>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vcvtq_n_u32_f32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_n_u32_f32::<16>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[65536, 131072, 196608, 262144]).map_err(|e| crate::cpu::with_call(e, "vcvtq_n_u32_f32::<16>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_n_u32_f32::<16>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_s32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_s32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vcvtq_s32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_s32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_s32_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_s32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "vcvtq_s32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_s32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_s32_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_s32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vcvtq_s32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_s32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_s32_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_s32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vcvtq_s32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_s32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_s32_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_s32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcvtq_s32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_s32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_s32_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_s32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_s32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_s32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_s32_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_s32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_s32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_s32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_s32_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vcvtq_s32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE])));
        check_array_equality(&result, &[2147483647, -2147483648, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_s32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_s32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_u32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vcvtq_u32_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_u32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_u32_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_u32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_u32_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_u32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_u32_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_u32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vcvtq_u32_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_u32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_u32_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_u32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_u32_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_u32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_u32_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_u32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcvtq_u32_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_u32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_u32_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_u32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_u32_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_u32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_u32_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_u32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_u32_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_u32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcvtq_u32_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vcvtq_u32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE])));
        check_array_equality(&result, &[4294967295, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcvtq_u32_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtq_u32_f32(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
