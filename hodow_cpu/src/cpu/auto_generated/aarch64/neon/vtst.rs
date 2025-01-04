use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vtst_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([1]), create_int64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([0]), create_int64x1_t_from([10])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([0]), create_int64x1_t_from([10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([100]), create_int64x1_t_from([110])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([100]), create_int64x1_t_from([110]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([i64::MAX]), create_int64x1_t_from([i64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([i64::MAX]), create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([0]), create_int64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([0]), create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([-1]), create_int64x1_t_from([-1])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([-1]), create_int64x1_t_from([-1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_s64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MAX])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_s64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_s64(create_int64x1_t_from([i64::MAX]), create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_s64(create_int64x1_t_from([i64::MAX]), create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_s64(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([1]), create_poly64x1_t_from([2])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([1]), create_poly64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([0]), create_poly64x1_t_from([10])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([0]), create_poly64x1_t_from([10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([100]), create_poly64x1_t_from([110])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([100]), create_poly64x1_t_from([110]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([0]), create_poly64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([0]), create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_p64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([0]), create_uint64x1_t_from([10])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([0]), create_uint64x1_t_from([10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([100]), create_uint64x1_t_from([110])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([100]), create_uint64x1_t_from([110]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([0]), create_uint64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([0]), create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtst_u64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vtst_u64(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vtst_u64(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtst_u64(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}
