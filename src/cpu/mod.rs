use log::{error, info};

use crate::cpu::sse1::SSE1;

mod sse1;
mod sse4_1;

pub const DEFAULT_TEST_ITERATIONS: usize = 10000;

pub trait ExtensionTest {
    fn get_name() -> &'static str;
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)];
    fn test() -> Result<(), String> {
        info!("Checking {} support", Self::get_name());
        for (fun, name) in Self::get_tests() {
            info!("Running {}", name);
            match fun() {
                Ok(_) => info!("{} passed", name),
                Err(e) => error!("{} failed: {}", name, e),
            }
        }
        info!("{} test passed", Self::get_name());
        Ok(())
    }
}

pub fn test_all_extensions() -> Result<(), String> {
    if std::arch::is_x86_feature_detected!("sse") {
        SSE1::test()?;
    }
    // if std::arch::is_x86_feature_detected!("sse4.1") {
    //     test_sse4_1();
    // }

    Ok(())
}

fn check_array_equality(a: &[f32], b: &[f32]) -> Result<(), String> {
    if a.len() != b.len() {
        return Err(format!("Arrays have different lengths: {} and {}", a.len(), b.len()));
    }

    for i in 0..a.len() {
        if a[i].is_infinite() && !b[i].is_infinite() {
            return Err(format!("Expected {a:?}, got {b:?} (One is infinite, other is not)"));
        } else if a[i].is_nan() && !b[i].is_nan() {
            return Err(format!("Expected {a:?}, got {b:?} (One is NaN, other is not)"));
        } else if (a[i] - b[i]).abs() > 0.001 {
            return Err(format!("Expected {a:?}, got {b:?} (Difference is too big)"));
        }
    }

    Ok(())
}
