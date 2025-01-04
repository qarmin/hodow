use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vtstq_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551615, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([0, -1]), create_int64x2_t_from([10, 9])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([0, -1]), create_int64x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([100, 200]), create_int64x2_t_from([110, 210])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([100, 200]), create_int64x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([0, 0]), create_int64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([0, 0]), create_int64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([-1, -1]), create_int64x2_t_from([-1, -1])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([-1, -1]), create_int64x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_s64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_s64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_s64(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_s64(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_s64(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([1, 2]), create_poly64x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551615, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([1, 2]), create_poly64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([0, 18446744073709551615]), create_poly64x2_t_from([10, 9])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([0, 18446744073709551615]), create_poly64x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([100, 200]), create_poly64x2_t_from([110, 210])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([100, 200]), create_poly64x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([u64::MIN, u64::MIN]), create_poly64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([u64::MIN, u64::MIN]), create_poly64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]), create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]), create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([0, 0]), create_poly64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([0, 0]), create_poly64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]), create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]), create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([u64::MIN, u64::MAX]), create_poly64x2_t_from([u64::MIN, u64::MAX])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([u64::MIN, u64::MAX]), create_poly64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([u64::MIN, u64::MIN]), create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([u64::MIN, u64::MIN]), create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_p64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]), create_poly64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_p64(create_poly64x2_t_from([u64::MAX, u64::MAX]), create_poly64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_p64(create_random_poly64x2_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551615, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([0, 18446744073709551615]), create_uint64x2_t_from([10, 9])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([0, 18446744073709551615]), create_uint64x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([100, 200]), create_uint64x2_t_from([110, 210])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([100, 200]), create_uint64x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([0, 0]), create_uint64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([0, 0]), create_uint64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MAX])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstq_u64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vtstq_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vtstq_u64(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstq_u64(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
