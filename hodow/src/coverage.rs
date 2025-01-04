//! `hodow coverage` - how much of what stdarch declares this binary can actually test.
//!
//! Three different numbers get confused with each other, so this prints all three:
//!   - *discovered*: intrinsics stdarch declares for an architecture, whatever the host is;
//!   - *tested*: the ones a test was generated for (the rest are listed with a reason);
//!   - *would run here*: tests whose CPU feature this machine actually reports at runtime.
//!
//! The table covers every architecture, not just the one this binary was built for - the
//! counts come from the generator, which reads all of stdarch, so "how much of ARM32 NEON
//! would a build cover" is answerable without an ARM board. Only the last number is about
//! this machine.

use std::collections::BTreeMap;

use hodow_cpu::{ExtensionCoverage, all_tests, coverage, coverage_source, drop_reasons, extension_status};

use crate::cli::CoverageArgs;

/// stdarch source buckets whose code a given `target_arch` actually compiles.
fn native_buckets() -> &'static [&'static str] {
    match std::env::consts::ARCH {
        "x86_64" => &["x86", "x86_64"],
        "x86" => &["x86"],
        "aarch64" => &["aarch64", "arm_shared"],
        "arm" => &["arm", "arm_shared"],
        "riscv64" => &["riscv64", "riscv_shared"],
        "riscv32" => &["riscv32", "riscv_shared"],
        "loongarch64" => &["loongarch64", "loongarch_shared"],
        other => match other {
            "powerpc" => &["powerpc"],
            "powerpc64" => &["powerpc64"],
            "s390x" => &["s390x"],
            "mips" => &["mips"],
            "wasm32" => &["wasm32"],
            _ => &[],
        },
    }
}

#[derive(Default)]
struct Totals {
    discovered: usize,
    generated: usize,
    tests: usize,
}

impl Totals {
    fn add(&mut self, e: &ExtensionCoverage) {
        self.discovered += e.discovered;
        self.generated += e.generated;
        self.tests += e.tests;
    }

    fn dropped(&self) -> usize {
        self.discovered - self.generated
    }

    fn percent(&self) -> f64 {
        if self.discovered == 0 {
            0.0
        } else {
            100.0 * self.generated as f64 / self.discovered as f64
        }
    }
}

fn row(label: &str, t: &Totals, native: bool) {
    println!(
        "  {:<20}{:>11}{:>9}{:>9}{:>10}{:>8.1}%",
        format!("{label}{}", if native { " *" } else { "" }),
        t.discovered,
        t.generated,
        t.dropped(),
        t.tests,
        t.percent()
    );
}

fn header(first: &str) {
    println!(
        "  {:<20}{:>11}{:>9}{:>9}{:>10}{:>9}",
        first, "discovered", "tested", "dropped", "tests", "covered"
    );
}

fn selected(args: &CoverageArgs) -> Vec<&'static ExtensionCoverage> {
    coverage()
        .iter()
        .filter(|e| args.arch.as_deref().is_none_or(|a| a == e.arch))
        .collect()
}

fn print_table(args: &CoverageArgs, rows: &[&'static ExtensionCoverage]) {
    let natives = native_buckets();
    let mut groups: BTreeMap<String, Totals> = BTreeMap::new();
    let mut grand = Totals::default();
    for e in rows {
        let key = if args.extensions {
            format!("{}::{}", e.arch, e.ext)
        } else {
            e.arch.to_string()
        };
        groups.entry(key).or_default().add(e);
        grand.add(e);
    }

    header(if args.extensions {
        "architecture::ext"
    } else {
        "architecture"
    });
    for (name, totals) in &groups {
        let arch = name.split("::").next().unwrap_or(name);
        row(name, totals, natives.contains(&arch));
    }
    println!("  {}", "-".repeat(66));
    row("TOTAL", &grand, false);
    if !natives.is_empty() {
        println!("  * this build's own architecture ({})", std::env::consts::ARCH);
    }
}

/// Wrap `text` at `width` on word boundaries, indenting every line by `indent` spaces.
fn wrapped(text: &str, indent: usize, width: usize) -> String {
    let mut out = String::new();
    let mut column = width; // force the first word onto a fresh, indented line
    for word in text.split_whitespace() {
        if column + word.len() + 1 > width {
            out.push_str(&format!("\n{:indent$}", "", indent = indent));
            column = indent;
        } else {
            out.push(' ');
            column += 1;
        }
        out.push_str(word);
        column += word.len();
    }
    out
}

fn print_reasons(rows: &[&'static ExtensionCoverage]) {
    let mut counts: BTreeMap<&'static str, usize> = BTreeMap::new();
    for e in rows {
        for d in e.dropped {
            *counts.entry(d.reason).or_insert(0) += 1;
        }
    }
    if counts.is_empty() {
        return;
    }
    let descriptions: BTreeMap<&str, &str> = drop_reasons().iter().copied().collect();
    let mut sorted: Vec<_> = counts.into_iter().collect();
    sorted.sort_by_key(|(reason, count)| (usize::MAX - count, *reason));
    println!("\nWhy a function has no test:");
    for (reason, count) in sorted {
        println!(
            "  {:<36}{:>7}{}",
            reason,
            count,
            wrapped(descriptions.get(reason).unwrap_or(&""), 6, 96)
        );
    }
}

/// The runtime half: of the tests that exist, how many this machine can actually execute.
fn print_runnable() {
    let status = extension_status();
    let compiled: usize = status.iter().map(|e| e.test_count).sum();
    let supported = status.iter().filter(|e| e.supported && e.test_count > 0).count();
    println!("\nOn this machine:");
    println!(
        "  {:<24}{} test(s) in {} extension(s) compiled into this binary",
        "Built for this target",
        compiled,
        status.iter().filter(|e| e.test_count > 0).count()
    );
    println!(
        "  {:<24}{} test(s) in {} extension(s) would run here",
        "Detected at runtime",
        all_tests().len(),
        supported
    );
}

fn print_dropped_functions(args: &CoverageArgs, rows: &[&'static ExtensionCoverage]) {
    println!("\nFunctions with no test:");
    let mut shown = 0usize;
    for e in rows {
        let matching: Vec<_> = e
            .dropped
            .iter()
            .filter(|d| args.reason.as_deref().is_none_or(|r| d.reason == r))
            .collect();
        if matching.is_empty() {
            continue;
        }
        println!("  {}::{} ({})", e.arch, e.ext, matching.len());
        for d in matching {
            println!("    {:<44}{}", d.name, d.reason);
            shown += 1;
        }
    }
    if shown == 0 {
        println!("  (none)");
    }
}

pub fn process_coverage(args: &CoverageArgs) {
    let rows = selected(args);
    if rows.is_empty() {
        println!(
            "No coverage data for architecture {:?}.",
            args.arch.as_deref().unwrap_or("")
        );
        println!("Known architectures: {}", {
            let mut names: Vec<_> = coverage().iter().map(|e| e.arch).collect();
            names.sort_unstable();
            names.dedup();
            names.join(", ")
        });
        return;
    }

    println!("CPU intrinsic coverage");
    println!("  Source: {}", coverage_source());
    println!();
    print_table(args, &rows);
    print_reasons(&rows);
    if args.arch.is_none() {
        print_runnable();
    }
    if args.verbose || args.reason.is_some() {
        print_dropped_functions(args, &rows);
    }
}
