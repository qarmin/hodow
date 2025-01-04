#!/usr/bin/env python3
"""
Cross-arch counterpart to capture_expected.py: cross-builds hodow for a non-x86
target, runs it under qemu-user, and captures failures into data/cpu/expected/ the
same way - reuses that script's FAIL_RE/to_rust_value/load_ev/merge-and-write logic
verbatim rather than duplicating it.

Needs the project's pinned nightly toolchain (arm/aarch64/riscv detection macros and
some intrinsics are still unstable - see hodow_core/src/lib.rs's cfg_attr) with the
target added (`rustup target add <triple> --toolchain <nightly>`), `qemu-<arch>` (in
`qemu-user`), and a linker - either a matching `<prefix>-gcc` cross-toolchain, or the
literal `zig`.

`zig` needs no distro cross-packages at all: it links against a musl target, which makes
the binary static, and a static binary needs no `-L <sysroot>` under qemu either. Use it
with a `*-musl*` triple. That is the only way this works on a host without
`gcc-aarch64-linux-gnu`/`gcc-arm-linux-gnueabihf` installed, which is most containers.

A qemu-derived "expected" value is not a real-silicon one - worth a distinct header
note in the affected data/cpu/expected/ files if this is ever done at scale (see CLAUDE.md's
"Non-x86 architectures" section).

Usage:
    python3 scripts/cpu/capture_expected_cross.py <target-triple> <cross-gcc|zig> <qemu-binary> [-- extra cpu args]

Examples:
    python3 scripts/cpu/capture_expected_cross.py aarch64-unknown-linux-musl zig qemu-aarch64
    python3 scripts/cpu/capture_expected_cross.py armv7-unknown-linux-musleabihf zig qemu-arm
    python3 scripts/cpu/capture_expected_cross.py aarch64-unknown-linux-gnu aarch64-linux-gnu-gcc qemu-aarch64
    python3 scripts/cpu/capture_expected_cross.py riscv64gc-unknown-linux-gnu riscv64-linux-gnu-gcc qemu-riscv64
"""

import os
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import capture_expected as base  # noqa: E402

def pinned_nightly(default: str = "nightly") -> str:
    """The toolchain from the justfile's `NIGHTLY :=` line, so bumping it in one place moves
    this script too - arm/aarch64 detection macros and several intrinsics are unstable, so
    running on whatever toolchain happens to be default does not compile."""
    justfile = Path.cwd() / "justfile"
    if justfile.exists():
        for line in justfile.read_text().splitlines()[:20]:
            if line.startswith("NIGHTLY"):
                return line.split('"')[1]
    return default


def zig_target(rust_triple: str) -> str:
    """Rust target triple -> the `zig cc -target` one. Zig names an architecture and a libc
    and nothing else, so the vendor field goes and armv7's `arm` spelling differs."""
    arch, _vendor, rest = rust_triple.split("-", 2)
    if arch.startswith("armv7"):
        arch = "arm"
    return f"{arch}-{rest}"


def find_sysroot(cross_gcc: str) -> str:
    """The cross-compiler's own sysroot, derived by asking for crt1.o's real path and stripping the
    trailing /lib/crt1.o. Works for the Debian/Ubuntu gcc-<arch>-linux-gnu* packages, which each ship their own self-contained
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
    using_zig = cross_gcc == "zig"
    if using_zig:
        env = {**os.environ,
               env_var: str(Path(__file__).parent / "zig_cross_linker.sh"),
               "ZIG_CC_TARGET": zig_target(target),
               # zig brings its own crt objects; letting rustc add musl's self-contained ones
               # too makes `_start` multiply defined.
               "RUSTFLAGS": "-C link-self-contained=no"}
    else:
        env = {**os.environ, env_var: cross_gcc}

    print(f"Cross-building for {target} (linker: {cross_gcc})...")
    build = subprocess.run(
        # `cpu_suite` is the point of the build; `gpu` as in `just arm`, `serve` off. hodow's GPU modules are
        # compiled unconditionally and call hodow_core's `gl_test_*`, which only exist behind
        # `gpu`, so a genuinely feature-less build does not compile at all. Nothing here
        # touches a GPU - the binary is only ever run as `hodow cpu` under qemu.
        ["cargo", f"+{pinned_nightly()}", "build", "--release", "-p", "hodow",
         "--no-default-features", "--features", "cpu_suite,gpu", "--target", target],
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

    binary = base_dir / "target" / target / "release" / "hodow"
    # A static (musl) binary carries its own libc, so qemu needs no sysroot to find one.
    qemu_prefix = [qemu_bin] if using_zig else [qemu_bin, "-L", find_sysroot(cross_gcc)]
    print(f"Running under {' '.join(qemu_prefix)}...")
    result = subprocess.run(
        [*qemu_prefix, str(binary), "cpu", *extra],
        cwd=base_dir,
        capture_output=True,
        text=True,
    )
    output = result.stdout + result.stderr
    print(output)

    # parse_output, not a FAIL_RE loop of its own: since Verdict::Unverified replaced the zero
    # placeholder, most values a fresh architecture has to capture are reported as "unverified:
    # ... got X" rather than as a failure, and a FAIL-only scan silently captured none of them.
    captured = base.parse_output(output)

    if not captured:
        print("Nothing to capture — no expected-value file modified.")
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
