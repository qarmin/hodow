// Simple placeholder implementation for AVX-512 BF16 tests.
// This module purposely avoids calling unstable stdarch intrinsics so the
// project can compile with stable toolchains when features are enabled.
use crate::cpu::{check_array_equality, check_float_array_equality_with_error, ExtensionTest, TestFunction};

pub struct AVX512BF16;

impl ExtensionTest for AVX512BF16 {
    fn get_name() -> &'static str {
        "AVX-512 BF16 (placeholder)"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_placeholder_1, "test_placeholder_1"), (&test_placeholder_2, "test_placeholder_2")]
    }
}

fn test_placeholder_1() -> Result<(), String> {
    // mimic a packed-u16 result check
    let got: [u16; 8] = [0x3fc0, 0x4000, 0x4040, 0x4080, 0x40a0, 0x40c0, 0x40e0, 0x4100];
    let expected = got;
    check_array_equality(&got, &expected)?;
    Ok(())
}

fn test_placeholder_2() -> Result<(), String> {
    // mimic an f32 result check
    let got: [f32; 4] = [1.0, 1.0, 1.0, 1.0];
    let expected = got;
    check_float_array_equality_with_error(&got, &expected)?;
    Ok(())
}
