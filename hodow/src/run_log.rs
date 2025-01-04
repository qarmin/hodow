use std::fs::File;
use std::path::{Path, PathBuf};

use crate::cli::{Cli, Commands};

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

/// The subcommands that run tests here and so leave a log behind; a worker, a list or a
/// `--submit-to` runs nothing worth keeping.
fn logged_command(command: &Commands) -> Option<&'static str> {
    match command {
        Commands::Cpu(a) if a.worker_start.is_none() && !a.list_modes && !a.list_functions => {
            Some(if a.stress { "stress" } else { "cpu" })
        }
        Commands::Gpu(a) if a.gpu_worker.is_none() => Some(if a.memtest { "memtest" } else { "gpu" }),
        Commands::Vulkan(_) => Some("vulkan"),
        _ => None,
    }
}

/// Opens the file the run's log is copied into: `--log-file`, else
/// `<data dir>/logs/<command>/<time>.log` with `<data dir>/logs/<command>-last.log` pointing at it.
/// Unbuffered, because the commands that write it leave through `process::exit`.
pub fn open(cli: &Cli, command: &Commands) -> Option<(File, PathBuf)> {
    if cli.no_log_file {
        return None;
    }
    #[cfg(feature = "serve")]
    if cli.submit_to.is_some() {
        return None;
    }
    let name = logged_command(command)?;
    let path = match &cli.log_file {
        Some(p) => p.clone(),
        None => unused_path(&crate::session::data_dir().logs().join(name), &timestamp()),
    };
    if let Some(dir) = path.parent().filter(|d| !d.as_os_str().is_empty())
        && let Err(e) = std::fs::create_dir_all(dir)
    {
        eprintln!(
            "Cannot create {}: {e} - this run is not logged to a file",
            dir.display()
        );
        return None;
    }
    let file = match File::create(&path) {
        Ok(f) => f,
        Err(e) => {
            eprintln!(
                "Cannot create {}: {e} - this run is not logged to a file",
                path.display()
            );
            return None;
        }
    };
    if cli.log_file.is_none() {
        point_last_at(
            &path,
            &crate::session::data_dir().logs().join(format!("{name}-last.log")),
        );
    }
    Some((file, path))
}

fn unused_path(dir: &Path, stem: &str) -> PathBuf {
    let first = dir.join(format!("{stem}.log"));
    if !first.exists() {
        return first;
    }
    (2..)
        .map(|n| dir.join(format!("{stem}-{n}.log")))
        .find(|p| !p.exists())
        .expect("unbounded range")
}

fn point_last_at(target: &Path, link: &Path) {
    let Ok(relative) = target.strip_prefix(link.parent().unwrap_or(Path::new("."))) else {
        return;
    };
    let _ = std::fs::remove_file(link);
    #[cfg(unix)]
    let _ = std::os::unix::fs::symlink(relative, link);
    #[cfg(not(unix))]
    let _ = std::fs::write(link, relative.display().to_string());
}
