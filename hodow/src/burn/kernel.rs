//! Follows the kernel log for the whole run. A GPU driver reports its resets there and to
//! nothing else, so without this a hang reads as the program's fault.

use std::fs::File;
use std::io::{BufRead, BufReader, Write};
use std::path::Path;
use std::process::{Child, Command, Stdio};
use std::time::Duration;

use super::dashboard::Dash;

const FOLLOWERS: &[&[&str]] = &[
    &["journalctl", "-kf", "-n", "0", "--no-pager", "-o", "short-monotonic"],
    &["dmesg", "-W"],
    &["dmesg", "-w"],
];

/// The first follower that starts and keeps running, copying into `path` and the
/// dashboard. `None` when the kernel log cannot be read here (not root, no journal).
pub fn follow(path: &Path, dash: Dash) -> Option<Child> {
    let mut file = File::create(path).ok()?;
    let mut refused = Vec::new();
    for argv in FOLLOWERS {
        let Ok(mut child) = Command::new(argv[0])
            .args(&argv[1..])
            .stdin(Stdio::null())
            .stdout(Stdio::piped())
            .stderr(Stdio::null())
            .spawn()
        else {
            refused.push(format!("{}: not found", argv.join(" ")));
            continue;
        };
        std::thread::sleep(Duration::from_millis(300));
        if let Ok(Some(status)) = child.try_wait() {
            refused.push(format!("{}: {status}", argv.join(" ")));
            continue;
        }
        let stdout = child.stdout.take()?;
        std::thread::spawn(move || {
            for line in BufReader::new(stdout).lines().map_while(Result::ok) {
                let _ = writeln!(file, "{line}");
                let _ = file.sync_data();
                dash.update(|d| d.push_kernel(line));
            }
        });
        return Some(child);
    }
    let _ = writeln!(file, "kernel log unavailable: {}", refused.join("; "));
    None
}
