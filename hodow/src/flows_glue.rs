//! The `--flows` tests, which need `hodow_bench` and so cannot live in the crates whose registries they join.
//! `register` hands each registry a provider; both the parent and an isolated worker call it from `main`, so their
//! test lists (and indices) agree. Wiring only - the kernels and the comparison are `hodow_bench`'s.

use hodow_bench::bench::Cache;
use hodow_bench::flows::{self, Device, Flow, Outcome};
use hodow_cpu::{TestEntry, TestFunction, Verdict};

pub fn register() {
    hodow_cpu::set_extra_tests(cpu_tests);
    #[cfg(feature = "bench_gles")]
    hodow_gpu::set_extra_gl_tests(gl::tests);
}

fn cpu_tests() -> Vec<TestEntry> {
    if flows::enabled() {
        cpu_flow_tests().to_vec()
    } else {
        Vec::new()
    }
}

fn cpu_flow_tests() -> &'static [TestEntry] {
    static TESTS: std::sync::OnceLock<Vec<TestEntry>> = std::sync::OnceLock::new();
    TESTS.get_or_init(|| {
        Flow::ALL
            .iter()
            .zip(CPU_FLOW_FNS)
            .map(|(&flow, test)| (flow.cpu_test_name(), "flows", test))
            .collect()
    })
}

fn cpu_flow<const I: usize>() -> Result<Verdict, String> {
    run_cpu_flow(Flow::ALL[I])
}

macro_rules! cpu_flow_table {
    ($($i:literal),*) => { [$(cpu_flow::<$i> as TestFunction),*] };
}

const CPU_FLOW_FNS: [TestFunction; 15] = cpu_flow_table!(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14);
const _: () = assert!(Flow::ALL.len() == CPU_FLOW_FNS.len());

fn run_cpu_flow(flow: Flow) -> Result<Verdict, String> {
    match flows::run(flow, Device::Cpu, &mut Cache::default()) {
        Outcome::Passed(msg) => {
            log::info!("{msg}");
            Ok(Verdict::Checked)
        }
        Outcome::Unsupported(why) => {
            log::info!("flow {} not supported here: {why}", flow.name());
            Ok(Verdict::Skipped("the flow has no implementation for this CPU"))
        }
        Outcome::Failed(e) => Err(e),
    }
}

#[cfg(feature = "bench_gles")]
mod gl {
    use std::error::Error;

    use hodow_bench::bench::gles::Session;
    use hodow_gpu::{GLTest, GLVersion};

    use super::{Cache, Device, Flow, Outcome, flows};

    pub fn tests() -> Vec<&'static dyn GLTest> {
        if flows::enabled() {
            TESTS.iter().map(|t| t as &'static dyn GLTest).collect()
        } else {
            Vec::new()
        }
    }

    pub struct FlowGles(Flow);

    macro_rules! flow_tests {
        ($($flow:ident),*) => {
            static TESTS: &[FlowGles] = &[$(FlowGles(Flow::$flow)),*];
        };
    }

    flow_tests!(
        Eye,
        Camera,
        Debayer,
        Morph,
        Sobel,
        Histogram,
        Moments,
        GemmI32,
        Reduce,
        Mandelbrot,
        AluU32,
        Sort,
        TiledEye,
        TiledHistogram,
        TiledMoments
    );

    impl GLTest for FlowGles {
        fn name(&self) -> &'static str {
            self.0.gl_test_name()
        }

        fn gl_version(&self) -> GLVersion {
            GLVersion::new(3, 1)
        }

        fn run(&self) -> Result<String, Box<dyn Error>> {
            let session = match Session::on_current_context() {
                Ok(s) => s,
                Err(e) => return Ok(format!("skipped: {e}")),
            };
            match flows::run(self.0, Device::Gles, &mut Cache::with_gles(session)) {
                Outcome::Passed(msg) => Ok(msg),
                Outcome::Unsupported(why) => Ok(format!("skipped: {why}")),
                Outcome::Failed(e) => Err(e.into()),
            }
        }
    }
}
