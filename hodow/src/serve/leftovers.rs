//! Jobs a previous server left running. A job is a child in its own process group, so a server that was killed (or crashed)
//! leaves it going; its run is then marked cancelled and the job stopped. Results are never deleted.

use hodow_common::{RunMeta, RunStatus, Store};

/// A run some server's job writes, as opposed to one a person started in a terminal. Runs from before `by_server` existed
/// are recognised by the `--events` every job is started with.
pub fn is_server_job(meta: &RunMeta) -> bool {
    meta.by_server || (meta.pid.is_none() && meta.args.iter().any(|a| a == "--events"))
}

/// Stops the process behind a run, when it can still be found, and marks the run cancelled. Its results stay.
pub fn stop_run(store: &Store, meta: &RunMeta) -> bool {
    match meta.pid {
        Some(pid) => stop_job(pid),
        None => stop_by_args(&meta.args),
    }
    store.finish_abandoned(&meta.id, RunStatus::Cancelled).is_ok()
}

pub fn cancel(store: &Store) {
    for meta in store
        .list()
        .into_iter()
        .filter(|m| m.status == RunStatus::Running && is_server_job(m))
    {
        if stop_run(store, &meta) {
            log::info!("Run {} was left over from an earlier server: cancelled", meta.id);
        }
    }
}

#[cfg(target_os = "linux")]
fn stop_job(pid: u32) {
    use std::time::{Duration, Instant};

    let (Ok(pid), true) = (i32::try_from(pid), is_job_leader(pid)) else {
        return;
    };
    unsafe {
        libc::kill(-pid, libc::SIGTERM);
    }
    let deadline = Instant::now() + Duration::from_secs(3);
    while std::path::Path::new(&format!("/proc/{pid}")).exists() && Instant::now() < deadline {
        std::thread::sleep(Duration::from_millis(100));
    }
    unsafe {
        libc::kill(-pid, libc::SIGKILL);
    }
}

/// A run from before the pid was recorded: its process is the one whose arguments are the run's own, after the program name.
#[cfg(target_os = "linux")]
fn stop_by_args(args: &[String]) {
    let Ok(entries) = std::fs::read_dir("/proc") else {
        return;
    };
    for pid in entries
        .filter_map(Result::ok)
        .filter_map(|e| e.file_name().to_str()?.parse::<u32>().ok())
    {
        let Ok(cmdline) = std::fs::read(format!("/proc/{pid}/cmdline")) else {
            continue;
        };
        let parts: Vec<&[u8]> = cmdline.split(|b| *b == 0).filter(|p| !p.is_empty()).collect();
        let same = parts.len() == args.len() + 1 && parts[1..].iter().zip(args).all(|(a, b)| *a == b.as_bytes());
        if same {
            stop_job(pid);
        }
    }
}

/// A pid can be reused: only a process that still looks like a job (own group, `--events`) is signalled.
#[cfg(target_os = "linux")]
fn is_job_leader(pid: u32) -> bool {
    let Ok(cmdline) = std::fs::read(format!("/proc/{pid}/cmdline")) else {
        return false;
    };
    let is_events = cmdline.split(|b| *b == 0).any(|arg| arg == b"--events");
    let leads_group = i32::try_from(pid).is_ok_and(|p| unsafe { libc::getpgid(p) } == p);
    is_events && leads_group
}

#[cfg(not(target_os = "linux"))]
fn stop_job(_pid: u32) {}

#[cfg(not(target_os = "linux"))]
fn stop_by_args(_args: &[String]) {}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_run_left_by_an_earlier_server_is_cancelled_and_kept_and_a_terminal_run_is_not_touched() {
        let dir = std::env::temp_dir().join(format!("hodow-leftovers-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        let store = Store::new(&dir);
        let meta = |id: &str, by_server| hodow_common::RunMeta {
            id: id.into(),
            module: "cts".into(),
            title: "t".into(),
            args: vec![],
            started_ms: hodow_common::time::now_ms(),
            finished_ms: None,
            status: RunStatus::Running,
            summary: None,
            version: "0".into(),
            os: "linux".into(),
            arch: "x86_64".into(),
            host: None,
            pid: None,
            by_server,
        };
        let _job = store.open_run(meta("job", true)).unwrap();
        let _terminal = store.open_run(meta("terminal", false)).unwrap();
        let (job_id, terminal_id) = ("job".to_string(), "terminal".to_string());
        let mut old = meta("old", false);
        old.args = vec!["--events".into(), "--data-dir".into(), "x".into()];
        let _old = store.open_run(old).unwrap();

        cancel(&store);

        assert_eq!(store.meta(&job_id).unwrap().status, RunStatus::Cancelled);
        assert_eq!(
            store.meta("old").unwrap().status,
            RunStatus::Cancelled,
            "a run from before the pid was recorded"
        );
        assert_eq!(store.meta(&terminal_id).unwrap().status, RunStatus::Running);
        assert!(store.run_dir(&job_id).unwrap().exists(), "results are not deleted");
        let _ = std::fs::remove_dir_all(&dir);
    }
}
