use std::fmt::Debug;

pub trait FloatLike: PartialEq + Debug + std::ops::Sub<Output = Self> + PartialOrd + Copy {
    fn is_infinite(self) -> bool;
    fn is_nan(self) -> bool;
    fn abs(self) -> Self;
    fn from_f64(f: f64) -> Self;
}

impl FloatLike for f32 {
    fn is_infinite(self) -> bool {
        f32::is_infinite(self)
    }
    fn is_nan(self) -> bool {
        f32::is_nan(self)
    }
    fn abs(self) -> Self {
        f32::abs(self)
    }
    fn from_f64(f: f64) -> Self {
        f as f32
    }
}

impl FloatLike for f64 {
    fn is_infinite(self) -> bool {
        f64::is_infinite(self)
    }
    fn is_nan(self) -> bool {
        f64::is_nan(self)
    }
    fn abs(self) -> Self {
        f64::abs(self)
    }
    fn from_f64(f: f64) -> Self {
        f
    }
}

pub fn check_float_array_equality_with_error<T: FloatLike + Debug>(a: &[T], b: &[T]) -> Result<(), String> {
    if a == b {
        return Ok(());
    }
    if a.len() != b.len() {
        return Err(format!("Got {a:?}, expected {b:?} (Arrays have different lengths: {} and {})", a.len(), b.len()));
    }

    let eps = T::from_f64(0.001);

    for i in 0..a.len() {
        if a[i].is_infinite() && !b[i].is_infinite() {
            return Err(format!("Got {a:?}, expected {b:?} (One is infinite, other is not)"));
        } else if a[i].is_nan() && !b[i].is_nan() {
            return Err(format!("Got {a:?}, expected {b:?} (One is NaN, other is not)"));
        } else if (a[i] - b[i]).abs() > eps {
            return Err(format!("Got {a:?}, expected {b:?} (Difference is too big)"));
        }
    }

    Ok(())
}

pub fn check_array_equality<T: PartialEq + Debug>(a: &[T], b: &[T]) -> Result<(), String> {
    if a != b {
        return Err(format!("Got {a:?}, expected {b:?}"));
    }

    Ok(())
}

#[allow(dead_code)]
pub const DEFAULT_FLOAT_DIFF: f32 = 0.001;

#[allow(dead_code)]
pub fn check_float_equality(a: f32, b: f32, max_diff: f32) -> Result<(), String> {
    if a.is_infinite() && !b.is_infinite() {
        return Err(format!("Got {a:?}, expected {b:?} (One is infinite, other is not)"));
    } else if a.is_nan() && !b.is_nan() {
        return Err(format!("Got {a:?}, expected {b:?} (One is NaN, other is not)"));
    } else if (a - b).abs() > max_diff {
        return Err(format!("Got {a:?}, expected {b:?} (Difference is too big)"));
    }

    Ok(())
}

pub fn check_int_equality<T: PartialEq + Debug>(a: T, b: T) -> Result<(), String> {
    if a != b {
        return Err(format!("Got {a:?}, expected {b:?}"));
    }

    Ok(())
}

#[allow(unused)]
pub fn check_int_equality_with_error(a: i32, b: i32, error: i32) -> Result<(), String> {
    if (a != b) && ((a > b && a - error > b) || (a < b && a + error < b)) {
        return Err(format!("Got {a:?}, expected {b:?}"));
    }

    Ok(())
}
