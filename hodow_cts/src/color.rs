// SPDX-License-Identifier: Apache-2.0
//
// Not derived from VK-GL-CTS - upstream logs to a .qpa file and colours nothing.

//! ANSI colouring, and the name of the case that is currently running.
//!
//! Colours are on unless `NO_COLOR` is set, rather than only when stdout is a
//! terminal: every way of running this goes through `run_cts.sh`, which tees, and a
//! pipe would turn them off exactly when they are wanted. `hodow` colours through
//! a pipe for the same reason.

use std::sync::RwLock;
use std::sync::atomic::{AtomicBool, Ordering};

static COLORS_ENABLED: AtomicBool = AtomicBool::new(true);

/// The case being executed, so a log line from inside a test says which one it came
/// from. Tests log through the plain `log` macros and know nothing about this.
static CURRENT_CASE: RwLock<String> = RwLock::new(String::new());

pub const RESET: &str = "\x1b[0m";
pub const RED: &str = "\x1b[31m";
pub const GREEN: &str = "\x1b[32m";
pub const YELLOW: &str = "\x1b[33m";
pub const BLUE: &str = "\x1b[34m";
pub const MAGENTA: &str = "\x1b[35m";
pub const CYAN: &str = "\x1b[36m";
pub const DIM: &str = "\x1b[2m";
pub const BOLD_RED: &str = "\x1b[1;31m";

pub fn set_enabled(enabled: bool) {
    COLORS_ENABLED.store(enabled, Ordering::Relaxed);
}

pub fn enabled() -> bool {
    COLORS_ENABLED.load(Ordering::Relaxed)
}

/// Wraps `text` in `code`, or leaves it alone when colours are off.
pub fn paint(code: &str, text: &str) -> String {
    if enabled() {
        format!("{code}{text}{RESET}")
    } else {
        text.to_string()
    }
}

pub fn set_current_case(name: &str) {
    if let Ok(mut current) = CURRENT_CASE.write() {
        current.clear();
        current.push_str(name);
    }
}

pub fn clear_current_case() {
    if let Ok(mut current) = CURRENT_CASE.write() {
        current.clear();
    }
}

pub fn current_case() -> String {
    CURRENT_CASE.read().map(|c| c.clone()).unwrap_or_default()
}
