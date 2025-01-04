// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Execution. Three layers:
//   `run_case_loop`   the API-agnostic bookkeeping around one case: timing, the log
//                     prefix, the summary, the result stream, the device-lost abort.
//   `vulkan` / `gles` bring the API up, then drive that loop.
//   `isolate`         runs one of those in a child process and supervises it, with
//                     `reap` for the worker a wedged driver will not let die.
//
// Cases run serially inside a batch, which is what upstream does. Overlapping GPU
// work would change timings and can both hide and manufacture failures, and the
// thing under test here is the driver, so the execution order has to stay boring.

pub mod gles;
pub mod isolate;
pub mod kmsg;
pub mod reap;
pub mod sysinfo;
pub mod vulkan;

use crate::report::{CaseResult, JsonlWriter, Summary};
use crate::tcu::{FlatCase, TestResult, TestStatus};

pub const UPSTREAM_REVISION: &str = include_str!("../../upstream/COMMIT");

/// Which API a case belongs to, decided by the root of its name.
///
/// Upstream ships one binary per API (`deqp-vk`, `deqp-gles31`) and each builds a
/// single-root hierarchy. This binary holds several, so the root prefix - which is
/// part of the case name either way - is what says which driver to bring up.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Api {
    Vulkan,
    Gles2,
    Gles3,
    Gles31,
    /// Khronos GL CTS root for one desktop version, `30` (3.0) to `46` (4.6): `KHR-GL<version>`. Upstream has one mustpass list per version, and a driver
    /// offering 4.5 runs `KHR-GL45` and below, never `KHR-GL46`.
    GlKhr(u8),
}

/// `GlKhr` versions and the core context each one runs on, index for index.
const KHR_VERSIONS: [u8; 11] = [30, 31, 32, 33, 40, 41, 42, 43, 44, 45, 46];
static KHR_CONTEXTS: [crate::glu::ApiType; 11] = [
    crate::glu::ApiType::core(3, 0),
    crate::glu::ApiType::core(3, 1),
    crate::glu::ApiType::core(3, 2),
    crate::glu::ApiType::core(3, 3),
    crate::glu::ApiType::core(4, 0),
    crate::glu::ApiType::core(4, 1),
    crate::glu::ApiType::core(4, 2),
    crate::glu::ApiType::core(4, 3),
    crate::glu::ApiType::core(4, 4),
    crate::glu::ApiType::core(4, 5),
    crate::glu::ApiType::core(4, 6),
];

impl Api {
    /// Lowest version first, which is the order a run executes them in - a driver that
    /// fails to bring up ES 3.1 has usually already told you something on ES 2.0.
    pub const ALL: [Api; 15] = [
        Api::Vulkan,
        Api::Gles2,
        Api::Gles3,
        Api::Gles31,
        Api::GlKhr(30),
        Api::GlKhr(31),
        Api::GlKhr(32),
        Api::GlKhr(33),
        Api::GlKhr(40),
        Api::GlKhr(41),
        Api::GlKhr(42),
        Api::GlKhr(43),
        Api::GlKhr(44),
        Api::GlKhr(45),
        Api::GlKhr(46),
    ];

    /// The root group name, i.e. the first component of every case name.
    pub fn root(self) -> &'static str {
        match self {
            Self::Vulkan => "dEQP-VK",
            Self::Gles2 => "dEQP-GLES2",
            Self::Gles3 => "dEQP-GLES3",
            Self::Gles31 => "dEQP-GLES31",
            Self::GlKhr(30) => "KHR-GL30",
            Self::GlKhr(31) => "KHR-GL31",
            Self::GlKhr(32) => "KHR-GL32",
            Self::GlKhr(33) => "KHR-GL33",
            Self::GlKhr(40) => "KHR-GL40",
            Self::GlKhr(41) => "KHR-GL41",
            Self::GlKhr(42) => "KHR-GL42",
            Self::GlKhr(43) => "KHR-GL43",
            Self::GlKhr(44) => "KHR-GL44",
            Self::GlKhr(45) => "KHR-GL45",
            Self::GlKhr(46) => "KHR-GL46",
            Self::GlKhr(other) => unreachable!("no Khronos GL CTS list for version {other}"),
        }
    }

    /// What to call the API in a message meant for a person.
    pub fn label(self) -> &'static str {
        match self {
            Self::Vulkan => "Vulkan",
            Self::Gles2 => "OpenGL ES 2.0",
            Self::Gles3 => "OpenGL ES 3.0",
            Self::Gles31 => "OpenGL ES 3.1",
            Self::GlKhr(30) => "OpenGL 3.0 (Khronos CTS)",
            Self::GlKhr(31) => "OpenGL 3.1 (Khronos CTS)",
            Self::GlKhr(32) => "OpenGL 3.2 (Khronos CTS)",
            Self::GlKhr(33) => "OpenGL 3.3 (Khronos CTS)",
            Self::GlKhr(40) => "OpenGL 4.0 (Khronos CTS)",
            Self::GlKhr(41) => "OpenGL 4.1 (Khronos CTS)",
            Self::GlKhr(42) => "OpenGL 4.2 (Khronos CTS)",
            Self::GlKhr(43) => "OpenGL 4.3 (Khronos CTS)",
            Self::GlKhr(44) => "OpenGL 4.4 (Khronos CTS)",
            Self::GlKhr(45) => "OpenGL 4.5 (Khronos CTS)",
            Self::GlKhr(46) => "OpenGL 4.6 (Khronos CTS)",
            Self::GlKhr(other) => unreachable!("no Khronos GL CTS list for version {other}"),
        }
    }

    /// The context versions this API's cases may run on, most preferred first, or
    /// `None` for Vulkan.
    ///
    /// Exactly one of these versions, not any newer one - see `RenderContext::create`.
    /// `tes31TestPackage.cpp` asks for ES 3.2 before ES 3.1 ("some of the tests will
    /// test ES3.2 functionality if supported"), and several `state_query` cases only
    /// run at all on a 3.2 context, so the ES 3.1 root has to make the same two
    /// attempts or it reports 232 cases NotSupported that upstream passes.
    pub fn gl_api_types(self) -> Option<&'static [crate::glu::ApiType]> {
        const GLES2: &[crate::glu::ApiType] = &[crate::glu::ApiType::es(2, 0)];
        const GLES3: &[crate::glu::ApiType] = &[crate::glu::ApiType::es(3, 0)];
        const GLES31: &[crate::glu::ApiType] = &[crate::glu::ApiType::es(3, 2), crate::glu::ApiType::es(3, 1)];

        match self {
            Self::Vulkan => None,
            Self::Gles2 => Some(GLES2),
            Self::Gles3 => Some(GLES3),
            Self::Gles31 => Some(GLES31),
            // Exactly the version the list is named after: KHR-GL45 on a 4.6 driver still asks for 4.5.
            Self::GlKhr(version) => {
                let index = KHR_VERSIONS
                    .iter()
                    .position(|v| *v == version)
                    .unwrap_or_else(|| unreachable!("no Khronos GL CTS list for version {version}"));
                Some(std::slice::from_ref(&KHR_CONTEXTS[index]))
            }
        }
    }

    /// The first component of a case name is the whole root, so `dEQP-GLES3` and
    /// `dEQP-GLES31` cannot be confused for one another.
    pub fn from_case_name(name: &str) -> Option<Self> {
        Self::ALL
            .into_iter()
            .find(|api| name.split('.').next() == Some(api.root()))
    }
}

/// Selects cases by the same glob rules deqp uses for `--deqp-case`: `*` matches any
/// run of characters, everything else is literal.
pub fn matches_filter(name: &str, pattern: &str) -> bool {
    fn go(name: &[u8], pat: &[u8]) -> bool {
        match pat.first() {
            None => name.is_empty(),
            Some(b'*') => (0..=name.len()).any(|i| go(&name[i..], &pat[1..])),
            Some(&c) => !name.is_empty() && name[0] == c && go(&name[1..], &pat[1..]),
        }
    }
    go(name.as_bytes(), pattern.as_bytes())
}

pub struct RunOptions {
    pub device_id: usize,
    pub validation: bool,
    /// Workers leave this off: the parent owns the header, and a second one in the
    /// middle of the stream would corrupt the file it is assembling.
    pub write_header: bool,
}

/// Runs `cases` through `run_one`, doing everything around a case that does not
/// depend on which API it tests.
///
/// The API-misuse message count (validation layer, `GL_KHR_debug`) is folded in by
/// `run_one` rather than here: what counts as misuse and how it is observed is the
/// one part of this that is not shared.
pub fn run_case_loop<C: ?Sized>(
    cases: &[&FlatCase<C>],
    writer: &mut JsonlWriter,
    on_start: &mut dyn FnMut(&str),
    on_result: &mut dyn FnMut(&CaseResult),
    mut run_one: impl FnMut(&FlatCase<C>) -> TestStatus,
) -> Result<Summary, Box<dyn std::error::Error>> {
    let mut summary = Summary::default();

    for flat in cases {
        let started = std::time::Instant::now();
        // Anything a test logs from here on is prefixed with this name. Upstream logs
        // into a per-case .qpa section, which does the same job; a bare line in a
        // terminal has nothing to tell you which of 20000 cases it came from.
        crate::color::set_current_case(&flat.full_name);
        // Before the case runs, so a case that never returns still named itself.
        on_start(&flat.full_name);
        // Where `fuzz selftest` makes a case misbehave on purpose. Inert - one
        // `OnceLock` read - unless the environment variable is set, and only
        // `selftest` sets it. It lives here rather than behind a cfg so the gate can
        // run against the release build, which is the one that gets deployed.
        let status = match crate::fuzz::fault::before_case(&flat.full_name) {
            Some(injected) => injected,
            None => run_one(flat),
        };

        crate::color::clear_current_case();
        let result = CaseResult::from_status(&flat.full_name, &status, started.elapsed().as_micros() as u64);
        summary.record(result.status);
        writer.write_case(&result)?;
        on_result(&result);

        // The device is unusable after this; carrying on would report every remaining
        // case as failing for a reason that has nothing to do with it.
        if result.status == TestResult::DeviceLost {
            log::error!("device lost - aborting this batch");
            break;
        }
    }

    Ok(summary)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn desktop_root_is_not_confused_with_the_es_ones() {
        assert_eq!(Api::from_case_name("KHR-GL46.info.vendor"), Some(Api::GlKhr(46)));
        assert_eq!(Api::from_case_name("KHR-GL45.info.vendor"), Some(Api::GlKhr(45)));
        assert_eq!(Api::from_case_name("dEQP-GLES2.info.vendor"), Some(Api::Gles2));
        assert_eq!(Api::from_case_name("dEQP-GLES31.info.vendor"), Some(Api::Gles31));
    }

    #[test]
    fn desktop_contexts_are_core_and_exactly_the_named_version() {
        for api in Api::ALL.into_iter().filter(|a| matches!(a, Api::GlKhr(_))) {
            let Api::GlKhr(version) = api else { unreachable!() };
            let types = api.gl_api_types().unwrap();
            assert!(types[0].desktop);
            assert_eq!(
                (types.len(), types[0].major * 10 + types[0].minor),
                (1, version as i32),
                "{}",
                api.root()
            );
        }
        assert!(Api::Gles31.gl_api_types().unwrap().iter().all(|t| !t.desktop));
    }
}
