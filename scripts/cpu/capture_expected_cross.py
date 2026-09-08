#!/usr/bin/env python3
"""
Cross-arch counterpart to capture_expected.py: cross-builds hodow_cli for a non-x86
target, runs it under qemu-user, and captures failures into data/cpu/expected/ the
same way - reuses that script's FAIL_RE/to_rust_value/load_ev/merge-and-write logic
verbatim rather than duplicating it.

Needs the project's pinned nightly toolchain (arm/aarch64/riscv detection macros and
some intrinsics are still unstable - see hodow_core/src/lib.rs's cfg_attr) with the
target added (`rustup target add <triple> --toolchain <nightly>`), a matching
`<prefix>-gcc` cross-linker, and `qemu-<arch>` (all in `qemu-user`).

A qemu-derived "expected" value is not a real-silicon one - worth a distinct header
note in the affected data/cpu/expected/ files if this is ever done at scale (see CLAUDE.md's
"Non-x86 architectures" section).

Usage:
    python3 scripts/cpu/capture_expected_cross.py <target-triple> <cross-gcc> <qemu-binary> [-- extra cpu args]

Examples:
    python3 scripts/cpu/capture_expected_cross.py aarch64-unknown-linux-gnu aarch64-linux-gnu-gcc qemu-aarch64
    python3 scripts/cpu/capture_expected_cross.py riscv64gc-unknown-linux-gnu riscv64-linux-gnu-gcc qemu-riscv64
    python3 scripts/cpu/capture_expected_cross.py armv7-unknown-linux-gnueabihf arm-linux-gnueabihf-gcc qemu-arm
"""

import os
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import capture_expected as base  # noqa: E402

NIGHTLY = "nightly-2026-08-21"


def find_sysroot(cross_gcc: str) -> str:
    """The cross-compiler's own sysroot, derived the same way box64_repro's justfile
    does: ask for crt1.o's real path, then strip the trailing /lib/crt1.o. Works for the
    Debian/Ubuntu gcc-<arch>-linux-gnu* packages, which each ship their own self-contained
    sysroot at /usr/<triple> - no `dpkg --add-architecture`/foreign-arch apt repo needed."""
    crt1 = subprocess.run([cross_gcc, "-print-file-name=crt1.o"], capture_output=True, text=True, check=True).stdout.strip()
    real = os.path.realpath(crt1)
    return os.path.dirname(os.path.dirname(real))


def main() -> None:
    if len(sys.argv) < 4:
        print(__doc__)
        sys.exit(2)

    target, cross_gcc, qemu_bin = sys.argv[1:4]
    extra = sys.argv[5:] if len(sys.argv) > 4 and sys.argv[4] == "--" else []

    base_dir = Path.cwd()

    env_var = f"CARGO_TARGET_{target.upper().replace('-', '_')}_LINKER"
    env = {**os.environ, env_var: cross_gcc}

    print(f"Cross-building for {target} (linker: {cross_gcc})...")
    build = subprocess.run(
        ["cargo", f"+{NIGHTLY}", "build", "--release", "-p", "hodow_cli", "--no-default-features", "--target", target],
        cwd=base_dir,
        env=env,
        capture_output=True,
        text=True,
    )
    if build.returncode != 0:
        print(build.stdout)
        print(build.stderr)
        print(f"Build failed for {target} - no values captured.")
        sys.exit(1)

    sysroot = find_sysroot(cross_gcc)
    binary = base_dir / "target" / target / "release" / "hodow_cli"
    print(f"Running under {qemu_bin} -L {sysroot}...")
    result = subprocess.run(
        [qemu_bin, "-L", sysroot, str(binary), "cpu", *extra],
        cwd=base_dir,
        capture_output=True,
        text=True,
    )
    output = result.stdout + result.stderr
    print(output)

    captured: dict[str, str] = {}
    for line in output.splitlines():
        m = base.FAIL_RE.search(line)
        if not m:
            continue
        test_name = m.group(1)
        got_val = base.to_rust_value(m.group(2).strip())
        captured[test_name] = got_val

    if not captured:
        print("No test failures found — no expected-value file modified.")
        return

    written = base.merge_and_write(captured)
    print(f"Captured {len(captured)} value(s) → {len(written)} file(s):")
    for path in written:
        print(f"  {path}")
    print()
    for name, val in sorted(captured.items()):
        print(f"  {name} - {val}")


if __name__ == "__main__":
    main()
