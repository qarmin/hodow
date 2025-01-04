#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "adx")]
fn test_x86_adx_addcarryx_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let c_in = 1u8;
        let a = 2u32;
        let b = 3u32;
        let mut ref_out = 4u32;
        let ret_value = _addcarryx_u32(c_in, a, b, &mut ref_out);
        let _ = core::hint::black_box(&mut ref_out);
        let out_out = ref_out;
        let result = (ret_value, out_out);
        let expected = (0, 6);
        check_int_equality(result.0, expected.0).map_err(|e| crate::cpu::with_call(e, "_addcarryx_u32(c_in, a, b, &mut ref_out)"))?;
        check_int_equality(result.1, expected.1).map_err(|e| crate::cpu::with_call(e, "_addcarryx_u32(c_in, a, b, &mut ref_out)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_adx_addcarryx_u32() -> Result<Verdict, String> {
    unsafe { test_x86_adx_addcarryx_u32_impl() }
}
