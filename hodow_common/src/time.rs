use std::time::{SystemTime, UNIX_EPOCH};

pub fn now_ms() -> u64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_millis() as u64
}

/// Local time as `YYYYMMDD-HHMMSS`.
pub fn timestamp() -> String {
    let (year, month, day, hour, minute, second) = local_time();
    format!("{year:04}{month:02}{day:02}-{hour:02}{minute:02}{second:02}")
}

#[cfg(unix)]
fn local_time() -> (i32, i32, i32, i32, i32, i32) {
    let now = unsafe { libc::time(std::ptr::null_mut()) };
    let mut tm: libc::tm = unsafe { std::mem::zeroed() };
    unsafe { libc::localtime_r(&now, &mut tm) };
    (
        tm.tm_year + 1900,
        tm.tm_mon + 1,
        tm.tm_mday,
        tm.tm_hour,
        tm.tm_min,
        tm.tm_sec,
    )
}

#[cfg(windows)]
fn local_time() -> (i32, i32, i32, i32, i32, i32) {
    #[repr(C)]
    #[derive(Default)]
    struct SystemTime {
        year: u16,
        month: u16,
        day_of_week: u16,
        day: u16,
        hour: u16,
        minute: u16,
        second: u16,
        milliseconds: u16,
    }
    unsafe extern "system" {
        fn GetLocalTime(out: *mut SystemTime);
    }
    let mut t = SystemTime::default();
    unsafe { GetLocalTime(&mut t) };
    (
        t.year.into(),
        t.month.into(),
        t.day.into(),
        t.hour.into(),
        t.minute.into(),
        t.second.into(),
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn timestamp_has_the_documented_shape() {
        let t = timestamp();
        assert_eq!(t.len(), 15);
        assert_eq!(t.as_bytes()[8], b'-');
        assert!(t.bytes().enumerate().all(|(i, b)| i == 8 || b.is_ascii_digit()));
    }
}
