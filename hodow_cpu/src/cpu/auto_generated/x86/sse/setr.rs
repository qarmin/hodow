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

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_setr_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_setr_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_setr_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_setr_ps(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_setr_ps() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_setr_ps_impl() }
}
