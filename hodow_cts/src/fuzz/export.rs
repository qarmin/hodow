// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Turning a finding into something that will still be runnable in six months.
//
// A finding in a campaign directory is a fact about a driver, and the moment that
// matters is the *next* driver: does this still happen? Answering it from the campaign
// means having the campaign, the same binary, a matching corpus fingerprint and someone
// who remembers what the numbers meant. None of that survives a year.
//
// So a finding is exported as a plain Rust project that depends on none of it: a
// `Cargo.toml`, the `repro_harness` files (an ES 3.1 context through `dlopen`, no
// crates), a `justfile` that runs it here or on a board and prints a verdict, and a
// `main.rs`. `cargo build` is the whole of what it needs, which is what lets one of these
// be mailed to a driver vendor or opened in a year on a machine that has never seen this
// repository.
//
// The `main.rs` is a skeleton, and deliberately so. Deciding which of a case's several
// thousand lines are the ones that matter is the work; a generator that guessed would
// produce something nobody trusts. What it can do is leave nothing else to be written -
// the harness, the verdict, the facts about where it was seen - and say exactly what is
// missing and where to find it.

use std::io::Write;
use std::path::{Path, PathBuf};

use super::store::{Finding, Store};

/// Writes the finding out as a self-contained directory, and returns where it went.
pub fn export(store: &Store, id: u32, into: &Path) -> std::io::Result<PathBuf> {
    let finding = store.read_finding(id)?;
    // The minimised list if there is one, the whole group otherwise. `repro.txt` is
    // written by every minimisation, including one that was only partly done - which is
    // still a shorter list than the group and still reproduces.
    //
    // Whether it *finished* is a separate question and has to be asked: an interrupted
    // bisection is a list that reproduces, not a list whose first element is the cause,
    // and calling it minimised would sell one as the other.
    let dir = store.finding_dir(id)?;
    let finished = super::minimize::load_state(store, id).is_some_and(|s| s.is_done());
    let (list, which) = match read_lines(&dir.join("repro.txt")) {
        Ok(lines) if !lines.is_empty() && finished => (lines, "minimised"),
        Ok(lines) if !lines.is_empty() => (lines, "part-way through minimisation, not finished"),
        _ => (store.read_finding_list(id, true)?, "the whole group, unminimised"),
    };

    let slug = slug(&finding, &list, finished);
    let name = format!("{:04}-{}", next_number(into, &slug), slug);
    let out = into.join(&name);
    std::fs::create_dir_all(&out)?;

    std::fs::create_dir_all(out.join("src"))?;
    std::fs::write(out.join("cases.txt"), list.join("\n") + "\n")?;
    std::fs::write(out.join(".gitignore"), "/target\n")?;
    write_cargo_toml(&out.join("Cargo.toml"), &format!("repro_{}", name.replace('-', "_")))?;
    write_justfile(&out.join("justfile"))?;
    write_readme(&out.join("README.md"), &finding, &list, which)?;
    write_main(&out.join("src/main.rs"), &list)?;
    // A placeholder rather than nothing: the skeleton `include_str!`s it, so the
    // directory builds from the first minute and the file that has to be filled in is
    // sitting there named.
    std::fs::write(
        out.join("shader.comp"),
        concat!(
            "// PLACEHOLDER. Replace with the GLSL this case compiles, verbatim - it is what\n",
            "// gets pasted into a bug report, and nobody should have to run a program to read\n",
            "// it. A case with more than one program gets one file each.\n",
        ),
    )?;

    // The harness, copied rather than depended on - that is what makes the directory
    // stand on its own.
    std::fs::write(out.join("src/gl.rs"), include_str!("../../repro_harness/gl.rs"))?;
    if list
        .first()
        .is_some_and(|c| c.contains("synchronization.inter_invocation."))
    {
        std::fs::write(
            out.join("src/inter_invocation.rs"),
            include_str!("../../repro_harness/inter_invocation.rs"),
        )?;
    }

    Ok(out)
}

/// A directory name that says what the thing is without anyone opening it.
///
/// Named after the *first* case of the sequence rather than the one that died: the
/// trigger is what the finding is about, and the casualty is whatever happened to run
/// next (see `quarantine.rs`). Falls back to the casualty when there is no list, and
/// when the minimisation never finished - until it does, the head of the list is
/// whichever case a half-done bisection left there, and naming a directory after it
/// points at a case nothing has been shown about.
fn slug(finding: &Finding, list: &[String], minimised: bool) -> String {
    let head = list.first().map(String::as_str).filter(|_| minimised);
    let case = head
        .or(finding.culprit.as_deref())
        .or(list.first().map(String::as_str))
        .unwrap_or("unknown");
    // The tail of the case name carries the meaning; the `dEQP-GLESxx.functional.` head
    // is the same for every one of them.
    let tail: Vec<&str> = case.split('.').rev().take(3).collect();
    let tail = tail.into_iter().rev().collect::<Vec<_>>().join("-");
    // Underscores kept: they are part of the case names, and a directory that can be
    // grepped for the case it came from is worth more than a tidier slug.
    let cleaned: String = tail
        .chars()
        .map(|c| {
            if c.is_ascii_alphanumeric() || c == '-' || c == '_' {
                c
            } else {
                '-'
            }
        })
        .collect();
    format!(
        "{}-{}---{}",
        finding.api.to_lowercase().replace("deqp-", ""),
        cleaned.trim_matches('-'),
        symptom(finding)
    )
}

/// What goes after the `---`: what a person browsing `findings/` wants to know first,
/// which is what the driver *did*, not which case did it.
///
/// Deliberately a small closed set, so the directory listing sorts into kinds of defect
/// rather than into a list of phrasings. What the campaign records is the shape of the
/// death, and these are the shapes it can tell apart on its own; anything it cannot is
/// `wrong-result`, which is where a person renaming the directory starts from. The two
/// that need a human eye are a compile or link that should have gone the other way -
/// `compile-wrong` and `link-fail` - because to the fuzzer those are simply a case that
/// failed.
fn symptom(finding: &Finding) -> &'static str {
    // A hang that needed a reboot is the one fact a person supplied by hand, and it
    // outranks everything else the record says.
    if finding.severity.as_deref() == Some("gpu-hang") || finding.kind == "machine-died" {
        return "gpu-crash";
    }
    match finding.kind.as_str() {
        // The worker stopped making progress and the machine was still there afterwards:
        // the client is stuck, the driver is not.
        "timeout" => "client-freeze",
        "crash" => "client-crash",
        _ => "wrong-result",
    }
}

/// The number the directory is called, which belongs to the *collection* and not to the
/// campaign.
///
/// A finding id is only unique inside one campaign, and a board that has run four of them
/// has four finding 1s - so naming the directory after the id collides, and the manual
/// renumber that used to avoid it is the sort of step that gets forgotten once and then
/// overwrites a finding somebody had already written up. The campaign's own id is not
/// lost: it is the first line of the README.
///
/// Re-exporting the same finding reuses its own directory rather than adding another,
/// which is what makes `export` safe to re-run after a minimisation shortened the list.
fn next_number(into: &Path, slug: &str) -> u32 {
    let mut highest = 0;
    let mut existing = None;
    for entry in std::fs::read_dir(into).into_iter().flatten().flatten() {
        let name = entry.file_name().to_string_lossy().into_owned();
        let Some((digits, rest)) = name.split_once('-') else {
            continue;
        };
        let Ok(number) = digits.parse::<u32>() else { continue };
        highest = highest.max(number);
        if rest == slug {
            existing = Some(number);
        }
    }
    existing.unwrap_or(highest + 1)
}

fn read_lines(path: &Path) -> std::io::Result<Vec<String>> {
    Ok(std::fs::read_to_string(path)?
        .lines()
        .filter(|l| !l.trim().is_empty())
        .map(str::to_string)
        .collect())
}

fn write_justfile(path: &Path) -> std::io::Result<()> {
    let mut f = std::fs::File::create(path)?;
    f.write_all(
        br##"# Does this still happen? Run it here, or on a board, and get an answer.
#
# A plain Rust project: `cargo build` needs nothing but a toolchain, and `just arm` needs
# zig and cargo-zigbuild on top. Nothing from the repository this came out of.

ARM_TARGET := "armv7-unknown-linux-gnueabihf"
ARM_ZIG_TARGET := "armv7-unknown-linux-gnueabihf.2.28"
TIMEOUT := "120"
# Named after this finding, so two of them on the same board cannot run each other's
# binary - and so a stale one is obvious.
REMOTE := "repro-" + file_stem(justfile_directory())

_default:
    @just --list --unsorted

# Build and run here, on whatever GPU this machine has.
[group('run')]
run:
    cargo run --release

# Build, deploy and run on the board, then say whether it still happens.
# Usage: just arm 192.168.1.50 [user] [ssh-opts...]
[group('run')]
arm ip user="root" *ssh_opts:
    #!/usr/bin/env bash
    set -uo pipefail
    just arm-build
    echo "=== deploying to {{user}}@{{ip}} ==="
    # Via a second name and a rename: a previous run stuck in the driver still holds the
    # old binary open, and scp onto it fails with "Text file busy" where a rename does not.
    scp {{ssh_opts}} -O target/{{ARM_TARGET}}/release/repro {{user}}@{{ip}}:~/{{REMOTE}}.new || exit 1
    ssh {{ssh_opts}} {{user}}@{{ip}} 'mv ~/{{REMOTE}}.new ~/{{REMOTE}}' || exit 1

    # What the kernel had said before this run, so the verdict is about this run and not
    # about a hang somebody left behind.
    before=$(ssh {{ssh_opts}} -o ConnectTimeout=10 {{user}}@{{ip}} 'dmesg | grep -cE "Stop driver to keep scene|FE not idle|SH not idle"' 2>/dev/null | tail -1)
    before=${before:-0}

    echo "=== running (up to {{TIMEOUT}}s) ==="
    # `timeout -s KILL` on the far side and one here as well: a process stuck in the GPU
    # driver is in state D, where SIGKILL is recorded and not delivered, so the remote
    # timeout cannot return either and the session has to be cut from this end.
    #
    # The board reports its own exit code in a marker line, because ssh's tells us
    # nothing once that happens - a cut session is 255 whatever the program did.
    log=$(mktemp)
    timeout $(( {{TIMEOUT}} + 30 )) ssh {{ssh_opts}} {{user}}@{{ip}} \
        'XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/0} WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-wayland-0} timeout -s KILL {{TIMEOUT}} ./{{REMOTE}}; echo "REMOTE_EXIT=$?"' 2>&1 | tee "$log"
    rc=$(sed -n 's/^REMOTE_EXIT=//p' "$log" | tail -1)
    # No marker means the session never got to print one: the client is still in there.
    rc=${rc:-137}
    rm -f "$log"

    echo
    echo "=== what the kernel says ==="
    after=$(ssh {{ssh_opts}} -o ConnectTimeout=10 {{user}}@{{ip}} 'dmesg | grep -cE "Stop driver to keep scene|FE not idle|SH not idle"' 2>/dev/null | tail -1)
    ssh {{ssh_opts}} -o ConnectTimeout=10 {{user}}@{{ip}} \
        'dmesg | grep -aE "Stop driver to keep scene|not idle|GPU DRV CONFIG" | tail -5' 2>/dev/null
    case "${after:-}" in ''|*[!0-9]*) after="" ;; esac
    hung=0
    [ -n "$after" ] && hung=$((after - before))

    echo
    echo "=== verdict ==="
    # The kernel decides first: a stopped driver is unambiguous, while a client the driver
    # will not let die only ever reports being killed.
    if [ "$hung" -gt 0 ] 2>/dev/null; then
        echo "HANG - the GPU hung. This finding is STILL PRESENT."
        echo "       The board needs a reboot before anything else will run on the GPU."
        exit 1
    fi
    case "$rc" in
        0) echo "PASS - it ran to the end and the driver reported no hang. FIXED on this build." ;;
        1) echo "FAIL - it ran but the results are wrong. Not the hang; a correctness bug." ;;
        2) echo "NO DRIVER - nothing was tested. Is a compositor running, and are XDG_RUNTIME_DIR/WAYLAND_DISPLAY right?" ;;
        124|137) echo "CLIENT HANG - it never returned and the kernel said nothing. Either slower than"
           echo "       {{TIMEOUT}}s, or stuck somewhere galcore does not notice - which is a finding of"
           echo "       its own shape: the board stays usable and needs no reboot." ;;
        *) echo "exit $rc - see above" ;;
    esac
    exit $rc

# Cross-build for the board. Needs zig and cargo-zigbuild, no sysroot and no distro
# cross-toolchain.
[group('dev')]
arm-build:
    rustup target add {{ARM_TARGET}}
    RUSTFLAGS="-A linker_messages" cargo zigbuild --release --target {{ARM_ZIG_TARGET}}

[group('dev')]
clean:
    cargo clean
"##,
    )
}

fn write_cargo_toml(path: &Path, name: &str) -> std::io::Result<()> {
    let mut f = std::fs::File::create(path)?;
    write!(
        f,
        "[package]\nname = \"{name}\"\nversion = \"0.1.0\"\nedition = \"2024\"\n\
         # No dependencies, on purpose: this has to build on any machine with a Rust\n\
         # toolchain and nothing else, including one that has never seen the project it\n\
         # came from.\n\n\
         [[bin]]\nname = \"repro\"\npath = \"src/main.rs\"\n\n\
         [profile.release]\nopt-level = 2\n\n\
         # Standalone: this must not be pulled into whatever workspace it is copied next to.\n\
         [workspace]\n"
    )
}

/// The one file a person still has to write, with everything around it already there.
fn write_main(path: &Path, list: &[String]) -> std::io::Result<()> {
    let mut f = std::fs::File::create(path)?;
    let family = list.first().map(String::as_str).unwrap_or("");
    let inter_invocation = family.contains("synchronization.inter_invocation.");

    writeln!(f, "// SKELETON - this does not reproduce anything yet.")?;
    writeln!(f, "//")?;
    writeln!(
        f,
        "// Keep it short. `gl.rs` is boilerplate nobody reads; what a person opens this"
    )?;
    writeln!(
        f,
        "// directory for is this file and the `.comp` beside it, and twenty lines of each"
    )?;
    writeln!(f, "// is worth more than a thousand. Put the GLSL in `shader.comp` and")?;
    writeln!(
        f,
        "// `include_str!` it rather than building strings here - it is what gets pasted"
    )?;
    writeln!(
        f,
        "// into a bug report, and a driver vendor should not have to run a program to"
    )?;
    writeln!(
        f,
        "// read it. findings/0001-* is thirty-three lines including comments."
    )?;
    writeln!(f, "//")?;
    writeln!(
        f,
        "// Everything around this file is done: `gl.rs` brings an ES 3.1 context up through"
    )?;
    writeln!(
        f,
        "// dlopen with no crates, and the justfile turns a run into a verdict. What is missing"
    )?;
    writeln!(
        f,
        "// is the case itself - the shaders and the calls that make the driver fall over."
    )?;
    writeln!(f, "//")?;
    writeln!(f, "// The sequence this finding is about, in order:")?;
    for case in list.iter().take(20) {
        writeln!(f, "//   {case}")?;
    }
    if list.len() > 20 {
        writeln!(f, "//   ... and {} more", list.len() - 20)?;
    }
    writeln!(f, "//")?;
    writeln!(
        f,
        "// Each is implemented in hodow_cts under src/gles31/ or src/gles3/ - find it by the"
    )?;
    writeln!(
        f,
        "// part of the name after `functional.`, and port just that case's initPrograms and"
    )?;
    writeln!(f, "// iterate into `run()` below.")?;
    writeln!(f, "//")?;
    writeln!(
        f,
        "// Two things the first attempt at this got wrong, both found by running it:"
    )?;
    writeln!(
        f,
        "//   - a surfaceless context does not reproduce what a 256x256 pbuffer with depth and"
    )?;
    writeln!(
        f,
        "//     stencil does; `gl.rs` asks for the pbuffer, so do not take it back out,"
    )?;
    writeln!(
        f,
        "//   - a reproducer is worth nothing until it has reproduced: run `just arm <ip>` and"
    )?;
    writeln!(f, "//     see HANG before writing a README that says it does.")?;
    writeln!(f)?;
    writeln!(f, "mod gl;")?;
    if inter_invocation {
        writeln!(f, "mod inter_invocation;")?;
    }
    writeln!(f)?;
    writeln!(f, "use gl::*;")?;
    if inter_invocation {
        writeln!(f, "use inter_invocation::*;")?;
        writeln!(f)?;
        writeln!(
            f,
            "// This family is already generated - `inter_invocation.rs` has all twenty variants."
        )?;
        let variant = family.rsplit('.').next().unwrap_or("");
        writeln!(f, "const VARIANT: &str = \"{variant}\";")?;
    }
    writeln!(f)?;
    writeln!(f, "fn main() {{")?;
    writeln!(f, "    let gl = gl::init();")?;
    if inter_invocation {
        writeln!(
            f,
            "    let variant = by_name(VARIANT).expect(\"a variant of this family\");"
        )?;
        writeln!(f, "    step(\"building the compute shader\");")?;
        writeln!(f, "    gl.build_compute(&variant.shader());")?;
        writeln!(f, "    variant.bind_storage(&gl);")?;
        writeln!(
            f,
            "    // TODO: the result SSBO at binding 0, dispatch, glFinish, count what came back."
        )?;
        writeln!(
            f,
            "    //       findings/0003-* is this family done; copy its main.rs if it is to hand."
        )?;
    } else {
        writeln!(f, "    let _ = &gl;")?;
        writeln!(
            f,
            "    // TODO: build the case's programs, set its buffers and images up, dispatch or"
        )?;
        writeln!(
            f,
            "    //       draw, then glFinish - which is where a broken driver stops returning."
        )?;
    }
    writeln!(
        f,
        "    eprintln!(\"this reproducer is still a skeleton - see the comment at the top\");"
    )?;
    writeln!(f, "    std::process::exit(EXIT_FAIL);")?;
    writeln!(f, "}}")?;
    Ok(())
}

fn write_readme(path: &Path, finding: &Finding, list: &[String], which: &str) -> std::io::Result<()> {
    let mut f = std::fs::File::create(path)?;
    writeln!(f, "# finding {} - {}\n", finding.id, finding.kind)?;
    writeln!(
        f,
        "**Status: skeleton.** The harness and the verdict are here; the case itself is not"
    )?;
    writeln!(
        f,
        "written yet - see the comment at the top of `src/main.rs`. Until `just arm <ip>`"
    )?;
    writeln!(
        f,
        "prints HANG, this directory records what was seen rather than reproducing it.\n"
    )?;
    if let Some(severity) = &finding.severity {
        writeln!(f, "Severity as recorded by whoever was there: **{severity}**.\n")?;
    }
    writeln!(f, "{}\n", finding.message)?;
    writeln!(f, "| | |")?;
    writeln!(f, "|---|---|")?;
    writeln!(f, "| API | {} |", finding.api)?;
    writeln!(f, "| Reproduced | {} |", finding.repro.summary())?;
    writeln!(f, "| Sequence | {} case(s), {which} |", list.len())?;
    writeln!(
        f,
        "| Group it came from | epoch {}, group {}, {} cases |",
        finding.epoch, finding.group, finding.size
    )?;
    if let Some(culprit) = &finding.culprit {
        writeln!(f, "| Case that died | `{culprit}` |")?;
    }
    writeln!(f)?;
    writeln!(f, "## Running it\n")?;
    writeln!(f, "```bash")?;
    writeln!(
        f,
        "just run                    # here, on whatever GPU this machine has"
    )?;
    writeln!(
        f,
        "just arm 192.168.1.50       # cross-build, deploy, run there, print a verdict"
    )?;
    writeln!(f, "```\n")?;
    writeln!(
        f,
        "`HANG` means still present, `PASS` means fixed on that build. The verdict comes from"
    )?;
    writeln!(
        f,
        "the kernel rather than the exit code: a client stuck in a dead driver cannot be"
    )?;
    writeln!(f, "killed, so ssh returns whatever it likes.\n")?;
    writeln!(
        f,
        "No dependencies - `cargo build` needs a toolchain and nothing else, and `just arm`"
    )?;
    writeln!(
        f,
        "needs zig and cargo-zigbuild on top. Nothing from the project this came out of.\n"
    )?;
    writeln!(f, "## The sequence\n")?;
    writeln!(f, "In this order, in one process - the order is the finding:\n")?;
    writeln!(f, "```")?;
    for case in list.iter().take(40) {
        writeln!(f, "{case}")?;
    }
    if list.len() > 40 {
        writeln!(f, "... and {} more, see cases.txt", list.len() - 40)?;
    }
    writeln!(f, "```\n")?;
    if which.starts_with("the whole") {
        writeln!(
            f,
            "This is the whole group: the minimisation has not been run, or did not finish."
        )?;
        writeln!(
            f,
            "`hodow_cts fuzz minimize {} --full` shortens it, and the shorter it is the more",
            finding.id
        )?;
        writeln!(f, "it says.\n")?;
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::fuzz::triage::ReproReport;

    fn finding(culprit: &str) -> Finding {
        Finding {
            id: 7,
            kind: "machine-died".to_string(),
            severity: Some("gpu-hang".to_string()),
            detected_epoch: 0,
            api: "dEQP-GLES31".to_string(),
            epoch: 1,
            epoch_seed: 0,
            group: 2,
            size: 1000,
            culprit: Some(culprit.to_string()),
            message: "the machine did not come back".to_string(),
            completed: 0,
            completed_exact: false,
            repro: ReproReport {
                attempts: 2,
                reproduced: 2,
                kinds: vec!["machine-died".to_string()],
            },
        }
    }

    #[test]
    fn the_directory_name_says_what_it_is() {
        let list = ["dEQP-GLES31.functional.synchronization.inter_invocation.ssbo_atomic_read_write".to_string()];
        let name = slug(
            &finding("dEQP-GLES31.functional.shaders.sample_variables.sample_mask.whatever"),
            &list,
            true,
        );
        assert_eq!(
            name,
            "gles31-synchronization-inter_invocation-ssbo_atomic_read_write---gpu-crash"
        );
    }

    #[test]
    fn a_finding_with_no_culprit_still_gets_a_name() {
        let mut f = finding("x");
        f.culprit = None;
        assert!(!slug(&f, &[], true).is_empty());
    }

    /// What a person browsing the directory reads first is what the driver did, so the
    /// suffix has to follow the record rather than the case name.
    #[test]
    fn the_suffix_says_what_the_driver_did() {
        let mut f = finding("dEQP-GLES31.a.b.c");
        assert_eq!(symptom(&f), "gpu-crash", "a hang a person tagged outranks the kind");

        f.severity = None;
        f.kind = "timeout".to_string();
        assert_eq!(
            symptom(&f),
            "client-freeze",
            "no hang reported, so the client is what stopped"
        );

        f.kind = "order-dependent-fail".to_string();
        assert_eq!(symptom(&f), "wrong-result");
    }

    /// The trigger is the finding; the casualty is whichever case happened to be next.
    #[test]
    fn the_name_comes_from_the_trigger_not_the_casualty() {
        let list = [
            "dEQP-GLES31.a.b.trigger_case".to_string(),
            "dEQP-GLES31.c.d.casualty_case".to_string(),
        ];
        let name = slug(&finding("dEQP-GLES31.c.d.casualty_case"), &list, true);
        assert!(name.contains("trigger_case"), "{name}");
        assert!(!name.contains("casualty"), "{name}");
    }

    /// Two campaigns on one board both have a finding 1, so the directory number is the
    /// collection's rather than the campaign's - and re-exporting one keeps its place.
    #[test]
    fn the_directory_number_is_the_next_free_one() {
        let dir = std::env::temp_dir().join(format!("hodow-export-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        std::fs::create_dir_all(dir.join("0001-gles31-a-b-first")).expect("temp dir");
        std::fs::create_dir_all(dir.join("0007-gles31-a-b-seventh")).expect("temp dir");
        std::fs::write(dir.join("README.md"), "not a finding").expect("temp file");

        assert_eq!(next_number(&dir, "gles31-a-b-new"), 8);
        assert_eq!(next_number(&dir, "gles31-a-b-first"), 1);
        assert_eq!(next_number(&dir.join("nothing-here"), "gles31-a-b-new"), 1);
        std::fs::remove_dir_all(&dir).expect("temp dir");
    }

    /// Half-done bisection: the head of the list is where a chunk boundary fell, and
    /// nothing has been shown about it. The case that died is the one fact there is.
    #[test]
    fn an_unfinished_minimisation_is_named_after_the_case_that_died() {
        let list = [
            "dEQP-GLES31.a.b.whatever_was_left".to_string(),
            "dEQP-GLES31.c.d.casualty_case".to_string(),
        ];
        let name = slug(&finding("dEQP-GLES31.c.d.casualty_case"), &list, false);
        assert!(name.contains("casualty_case"), "{name}");
        assert!(!name.contains("whatever_was_left"), "{name}");
    }
}
