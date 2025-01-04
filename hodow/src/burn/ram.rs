//! How much RAM the memory phase may take. Memory tests want as much as they can get, but a machine that is
//! also somebody's computer must stay usable, and in a container the limit is not in /proc/meminfo at all.

use std::path::{Path, PathBuf};

use super::sensors::meminfo_mb;

/// What `plan` decides from; separate so the decision can be tested.
#[derive(Clone, Copy, Debug, Default)]
pub struct Inputs {
    /// MemAvailable: free memory plus what can be reclaimed (page cache). Swap is not in it.
    pub available_mb: u64,
    /// MemFree: memory nobody holds at all, not even as cache.
    pub free_mb: u64,
    /// Room left under a cgroup limit (a container), when there is one.
    pub cgroup_headroom_mb: Option<u64>,
    /// Whether the test can pin its buffer with mlock.
    pub can_lock: bool,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Plan {
    pub budget_mb: u64,
    /// What the budget was taken from, for the person reading the header.
    pub available_mb: u64,
    pub reason: &'static str,
}

const FLOOR_MB: u64 = 16;

/// Half of what is available. What is available is already what the other programs left, so on a machine that is in
/// use the test takes half of the rest and the machine stays usable; `--ram-mb` asks for more. Two things lower it: a
/// container's limit, which /proc/meminfo does not show, and the lack of mlock - without it the buffer can be swapped
/// out, and a test that makes the system swap tests the disk, so then it stays within memory that is free right now
/// and nothing else is pushed out.
pub fn plan(i: Inputs) -> Plan {
    let available = i.cgroup_headroom_mb.map_or(i.available_mb, |h| h.min(i.available_mb));
    let mut budget = available / 2;
    let mut reason = "half of what is available";
    if i.cgroup_headroom_mb.is_some_and(|h| h < i.available_mb) {
        reason = "half of what the container's memory limit leaves";
    }
    if !i.can_lock && i.free_mb < budget {
        budget = i.free_mb;
        reason = "only memory that is free right now (this process may not lock memory)";
    }
    Plan {
        budget_mb: budget.max(FLOOR_MB),
        available_mb: available,
        reason,
    }
}

#[cfg(unix)]
fn can_lock() -> bool {
    let mut limit = libc::rlimit {
        rlim_cur: 0,
        rlim_max: 0,
    };
    let known = unsafe { libc::getrlimit(libc::RLIMIT_MEMLOCK, &mut limit) } == 0;
    let root = unsafe { libc::geteuid() } == 0;
    root || (known && limit.rlim_cur == libc::RLIM_INFINITY)
}

#[cfg(not(unix))]
fn can_lock() -> bool {
    false
}

fn read_number(path: &Path) -> Option<u64> {
    let text = std::fs::read_to_string(path).ok()?;
    let text = text.trim();
    (text != "max").then(|| text.parse().ok()).flatten()
}

/// The tightest `limit - usage` on the way from this process's cgroup up to the root, in MB.
fn cgroup_headroom_mb() -> Option<u64> {
    let own = std::fs::read_to_string("/proc/self/cgroup").ok()?;
    let relative = own.lines().find_map(|l| l.strip_prefix("0::"))?.trim_start_matches('/');
    let mut dir: PathBuf = Path::new("/sys/fs/cgroup").join(relative);
    let mut tightest: Option<u64> = None;
    loop {
        if let (Some(max), Some(used)) = (
            read_number(&dir.join("memory.max")),
            read_number(&dir.join("memory.current")),
        ) {
            let room = max.saturating_sub(used) >> 20;
            tightest = Some(tightest.map_or(room, |t| t.min(room)));
        }
        if dir == Path::new("/sys/fs/cgroup") || !dir.pop() {
            break;
        }
    }
    tightest
}

pub fn plan_here() -> Plan {
    plan(Inputs {
        available_mb: meminfo_mb("MemAvailable").unwrap_or(0),
        free_mb: meminfo_mb("MemFree").unwrap_or(0),
        cgroup_headroom_mb: cgroup_headroom_mb(),
        can_lock: can_lock(),
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    fn inputs(_total: u64, available: u64) -> Inputs {
        Inputs {
            available_mb: available,
            free_mb: available,
            cgroup_headroom_mb: None,
            can_lock: true,
        }
    }

    #[test]
    fn a_desktop_with_a_lot_free_is_not_emptied() {
        // 32 GB, 6 GB in use: the old rule took 22 GB of the 26 that were available.
        let plan = plan(inputs(32_000, 26_000));
        assert_eq!(plan.budget_mb, 13_000);
        assert_eq!(plan.reason, "half of what is available");
    }

    #[test]
    fn a_busy_machine_gets_half_of_the_little_that_is_left() {
        assert_eq!(plan(inputs(32_000, 9_000)).budget_mb, 4_500);
    }

    #[test]
    fn a_small_board_gets_a_useful_share_and_never_less_than_the_floor() {
        assert_eq!(plan(inputs(1_000, 700)).budget_mb, 350);
        assert_eq!(plan(inputs(256, 10)).budget_mb, FLOOR_MB);
    }

    #[test]
    fn a_container_limit_wins_over_what_proc_meminfo_says() {
        let plan = plan(Inputs {
            cgroup_headroom_mb: Some(1_500),
            ..inputs(32_000, 26_000)
        });
        assert_eq!((plan.budget_mb, plan.available_mb), (750, 1_500));
        assert!(plan.reason.contains("container"));
        let roomy = super::plan(Inputs {
            cgroup_headroom_mb: Some(100_000),
            ..inputs(32_000, 26_000)
        });
        assert_eq!(roomy.budget_mb, 13_000);
    }

    #[test]
    fn without_mlock_it_stays_inside_memory_that_is_free_right_now() {
        // Plenty is reclaimable cache, little is actually free: taking half would push other programs to swap.
        let plan = plan(Inputs {
            free_mb: 4_000,
            can_lock: false,
            ..inputs(32_000, 26_000)
        });
        assert_eq!(plan.budget_mb, 4_000);
        assert!(plan.reason.contains("free right now"));
        let roomy = super::plan(Inputs {
            free_mb: 20_000,
            can_lock: false,
            ..inputs(32_000, 26_000)
        });
        assert_eq!(roomy.budget_mb, 13_000);
    }

    #[test]
    fn this_machine_gets_a_plan() {
        let plan = plan_here();
        assert!(plan.budget_mb >= FLOOR_MB);
    }
}
