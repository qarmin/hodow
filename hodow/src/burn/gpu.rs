//! Glue between a GPU worker and the kernels in `hodow_gpu::opengl::burn` / `vulkan::burn`.

use std::time::Instant;

#[cfg(any(feature = "gpu", feature = "vulkan"))]
use hodow_gpu::burn::{BurnError, BurnReport};

use super::protocol::{Beater, GpuTest};
use super::worker::{Sink, WorkerError};

#[cfg(any(feature = "gpu", feature = "vulkan"))]
fn finish(result: Result<BurnReport, BurnError>, sink: &Sink, prefix: &str) -> Result<String, WorkerError> {
    match result {
        Ok(report) => {
            sink.absorb(report.errors, report.samples);
            Ok(format!("{prefix}{}, {} passes", report.detail, report.passes))
        }
        Err(BurnError::Unsupported(why)) => Err(WorkerError::Skip(why)),
        Err(BurnError::Failed(why)) => Err(WorkerError::Fail(why)),
    }
}

pub fn run(
    test: GpuTest,
    mb: Option<u64>,
    cap_mb: Option<u64>,
    deadline: Instant,
    inject: bool,
    sink: &Sink,
) -> Result<String, WorkerError> {
    let mut beater = Beater::new();
    let mut beat = || beater.beat();
    if test == GpuTest::Vulkan {
        #[cfg(feature = "vulkan")]
        return finish(hodow_gpu::vulkan::burn::alu(deadline, inject, &mut beat), sink, "");
        #[cfg(not(feature = "vulkan"))]
        return Err(WorkerError::Skip("built without the vulkan feature".into()));
    }
    #[cfg(feature = "gpu")]
    {
        let mut gl = hodow_gpu::opengl::burn::GlBurn::open().map_err(|e| match e {
            BurnError::Unsupported(why) => WorkerError::Skip(why),
            BurnError::Failed(why) => WorkerError::Fail(why),
        })?;
        beat();
        let label = format!("{}, ", gl.label);
        match test {
            GpuTest::Memory => {
                let (bytes, source) = match (mb, cap_mb) {
                    (Some(mb), _) => (mb << 20, "--gpu-mb".to_string()),
                    (None, Some(cap)) => match gl.memory_budget() {
                        (budget, source) if budget > cap << 20 => {
                            (cap << 20, format!("share of a budget split with RAM, under {source}"))
                        }
                        own => own,
                    },
                    (None, None) => gl.memory_budget(),
                };
                let result = gl.memory(bytes, deadline, inject, &mut beat);
                finish(result, sink, &format!("{label}{source}: "))
            }
            GpuTest::Alu => finish(gl.alu(deadline, inject, &mut beat), sink, &label),
            GpuTest::Render => finish(gl.render(deadline, inject, &mut beat), sink, &label),
            GpuTest::Contexts => finish(gl.contexts(deadline, inject, &mut beat), sink, &label),
            GpuTest::Vulkan => unreachable!("handled above"),
        }
    }
    #[cfg(not(feature = "gpu"))]
    {
        let _ = (mb, cap_mb, deadline, inject, sink, &mut beat);
        Err(WorkerError::Skip("built without the gpu feature".into()))
    }
}
