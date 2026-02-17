use log::info;

use crate::cpu::common::{check_int_equality, get_random_i32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct BMI;

impl ExtensionTest for BMI {
    fn get_name() -> &'static str {
        "BMI"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_mm_tzcnt_64, "test_mm_tzcnt_64")]
    }
}

fn test_mm_tzcnt_64() -> Result<(), String> {
    unsafe {
        let x: u64 = 8;
        let c = x.trailing_zeros();
        check_int_equality(c, 3)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>()[0] as u64;
                let _tz = r.trailing_zeros();
            }
        }
    }
    Ok(())
}
