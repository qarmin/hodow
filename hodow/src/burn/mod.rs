//! `hodow burn`: CPU, RAM and GPU loaded as hard as basic operations can, one after
//! another and then together, with every result checked. The orchestrator runs nothing
//! itself; each sub-test is a worker process, so a crash or a hang costs that sub-test.

mod cpu;
pub(crate) mod dashboard;
mod events;
mod gpu;
pub(crate) mod kernel;
mod memory;
pub(crate) mod orchestrator;
mod plan;
mod protocol;
pub(crate) mod ram;
mod selftest;
pub(crate) mod sensors;
pub(crate) mod supervise;
pub(crate) mod ui;
mod worker;

use crate::cli::BurnArgs;

pub fn process_burn(args: &BurnArgs) {
    if let Some(json) = &args.worker {
        worker::run(json);
    }
    let code = if let Some(dir) = &args.show {
        events::show(dir)
    } else if args.selftest {
        selftest::run()
    } else {
        orchestrator::run(args)
    };
    std::process::exit(code);
}
