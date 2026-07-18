use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_prefetch() -> Result<(), String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i8; 64]);
        _prefetch::<0, 0>(ptr_p.0.as_ptr());
    }
    Ok(())
}
