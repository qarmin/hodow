//! `hodow bench`: image-processing kernels and their building blocks timed on the CPU
//! and on every GPU API there is, end to end, with each result checked against a CPU
//! reference. The question it answers is where a task belongs on this machine.

mod compare;
mod html;
mod plan;
mod pool;
mod protocol;
mod report;
mod results;
mod run;
mod worker;

use crate::cli::BenchArgs;

pub fn process_bench(args: &BenchArgs) {
    if args.worker {
        worker::run();
    }
    let code = if let Some(paths) = &args.compare {
        compare::run(&paths[0], &paths[1])
    } else if let Some(dir) = &args.report {
        run::rerender(dir)
    } else if args.list {
        run::list(args)
    } else {
        run::run(args)
    };
    std::process::exit(code);
}
