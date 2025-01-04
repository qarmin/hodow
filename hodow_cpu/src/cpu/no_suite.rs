//! Stands in for `auto_generated` when the `cpu_suite` feature is off: the same API with no
//! tests behind it, so a build that only needs the rest of the crate (`hodow bench`)
//! skips compiling 120 MB of generated code.

pub mod registry {
    use crate::cpu::{ExtensionStatus, ProgressCallback, TestFunction, TestStatistics};

    pub fn count_available_features() -> usize {
        0
    }

    pub fn available_modes() -> Vec<String> {
        Vec::new()
    }

    pub fn test_all_extensions(_: Option<&ProgressCallback>) -> Result<TestStatistics, String> {
        Err("built without the `cpu_suite` feature".into())
    }

    pub fn list_all_functions() -> Vec<String> {
        Vec::new()
    }

    pub fn extension_status() -> Vec<ExtensionStatus> {
        Vec::new()
    }

    pub fn all_tests() -> Vec<(&'static str, &'static str, TestFunction)> {
        Vec::new()
    }
}

pub mod coverage {
    use crate::cpu::ExtensionCoverage;

    pub fn coverage_source() -> &'static str {
        "built without the `cpu_suite` feature"
    }

    pub fn drop_reasons() -> &'static [(&'static str, &'static str)] {
        &[]
    }

    pub fn coverage() -> &'static [ExtensionCoverage] {
        &[]
    }
}
