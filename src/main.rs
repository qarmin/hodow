use once_cell::sync::OnceCell;
use rand::random;

use crate::cpu::test_all_extensions;

mod cpu;

static FUZZING: OnceCell<bool> = OnceCell::new();

pub fn get_fuzzing() -> bool {
    if FUZZING.get().is_none() {
        FUZZING.set(true).unwrap();
    }

    *FUZZING.get().expect("FUZZING not initialized")
}
pub fn get_random_float() -> f32 {
    match random::<u8>() % 12 {
        0 => f32::INFINITY,
        1 => f32::NEG_INFINITY,
        2 => f32::NAN,
        3..8 => random::<f32>() * 10000000.0,
        _ => random::<f32>() * 100000.0,
    }
}
pub fn get_four_random_floats() -> [f32; 4] {
    [
        get_random_float(),
        get_random_float(),
        get_random_float(),
        get_random_float(),
    ]
}

fn main() {
    handsome_logger::init().unwrap();
    test_all_extensions().unwrap();
}
