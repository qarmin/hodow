#!/usr/bin/env python3
"""Compile the hodow_cts shader manifests into generated Rust.

This is the only place a test-case parameter is written down. For every case in
`shaders/manifest/*.toml` this script:

  1. evaluates the `derived` formulas (which restate the upstream initPrograms()
     arithmetic verbatim),
  2. substitutes params + derived values into the GLSL template,
  3. compiles the result to SPIR-V with glslang - the same compiler upstream uses,
  4. emits `src/generated/shaders.rs` containing the SPIR-V words *and* the params as
     Rust constants.

The test code reads the params off the generated constant and never restates them, so
the shader and the host cannot drift apart.

glslang is needed only here. It is not a build or runtime dependency of the crate:
the generated Rust is committed, and a normal `cargo build` never invokes this script.
Vulkan drivers consume SPIR-V, never GLSL, so moving the GLSL->SPIR-V step to
generation time costs nothing in driver coverage.

Usage:
    python3 hodow_cts/scripts/compile_shaders.py --glslang <path-to-glslang>
"""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
import tomllib
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
MANIFEST_DIR = CRATE_DIR / "shaders" / "manifest"
TEMPLATE_DIR = CRATE_DIR / "shaders" / "src"
EXPANDED_DIR = CRATE_DIR / "shaders" / "expanded"
GENERATED = CRATE_DIR / "src" / "generated" / "shaders.rs"

STAGE_TO_GLSLANG = {"comp": "comp", "vert": "vert", "frag": "frag", "tesc": "tesc", "tese": "tese", "geom": "geom"}

SUBST_RE = re.compile(r"\$\{([^}]+)\}")


def camel_to_upper_snake(name: str) -> str:
    return re.sub(r"(?<!^)(?=[A-Z])", "_", name).upper()


def prod(v):
    """multiplyComponents()"""
    r = 1
    for c in v:
        r *= c
    return r


def evaluate_derived(params: dict, derived_src: dict) -> dict:
    """Evaluates the derived expressions in declaration order.

    `eval` is used deliberately: the manifests are trusted repo content, and keeping
    the formula as a readable expression is what lets a reviewer check it against the
    C++ line it was copied from. A hand-rolled mini-parser would obscure exactly the
    thing that needs checking.
    """
    env = {"prod": prod}
    env.update(params)
    out = {}
    for name, expr in derived_src.items():
        value = eval(expr, {"__builtins__": {}}, env)  # noqa: S307 - see docstring
        env[name] = value
        out[name] = value
    return out


def substitute(template: str, values: dict, where: str) -> str:
    def repl(m):
        expr = m.group(1).strip()
        try:
            return str(eval(expr, {"__builtins__": {}}, dict(values)))  # noqa: S307
        except Exception as exc:
            raise SystemExit(f"{where}: cannot evaluate ${{{expr}}}: {exc}") from exc

    return SUBST_RE.sub(repl, template)


def compile_glsl(glslang: str, source: str, stage: str, where: str, spirv_version: str | None) -> list[int]:
    """Runs glslang and returns the SPIR-V as a list of 32-bit words.

    `spirv_version` mirrors the `vk::SPIRV_VERSION_*` a test group passes upstream.
    It has to be per-group, not global: GL_EXT_shared_memory_block needs SPIR-V 1.4,
    while raising the floor for every group would silently change the SPIR-V already
    generated for the others - and the whole point of this file is that regeneration
    stays diff-clean.
    """
    import tempfile

    with tempfile.TemporaryDirectory() as td:
        src_path = Path(td) / f"shader.{STAGE_TO_GLSLANG[stage]}"
        spv_path = Path(td) / "shader.spv"
        src_path.write_text(source)

        # -V targets Vulkan SPIR-V, which is what deqp asks glslang for.
        cmd = [glslang, "-V", "--target-env", "vulkan1.1"]
        if spirv_version:
            cmd += ["--target-env", spirv_version]
        cmd += [str(src_path), "-o", str(spv_path)]
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode != 0:
            raise SystemExit(f"{where}: glslang failed\n{result.stdout}\n{result.stderr}")

        data = spv_path.read_bytes()

    if len(data) % 4 != 0:
        raise SystemExit(f"{where}: SPIR-V size {len(data)} is not a multiple of 4")
    words = [int.from_bytes(data[i : i + 4], "little") for i in range(0, len(data), 4)]
    if not words or words[0] != 0x07230203:
        raise SystemExit(f"{where}: output is not SPIR-V (bad magic)")
    return words


# Cache of compiled SPIR-V, keyed by exactly the inputs that determine the output.
_SPIRV_CACHE: dict[tuple[str, str, str | None], list[int]] = {}


def warm_spirv_cache(glslang: str, jobs: list[tuple[str, str, str | None]], where_of: dict) -> None:
    """Compiles every shader up front, in parallel.

    glslang is a separate process per shader; regenerating everything is several
    thousand of them, and run back to back the spawn cost dominates. The emit loop
    below stays serial so the generated file is byte-for-byte order-independent of
    how the pool happened to schedule things.
    """
    from concurrent.futures import ThreadPoolExecutor

    unique = {(j[0], j[1], j[2]) for j in jobs}
    if not unique:
        return

    def run(key):
        source, stage, spv = key
        return key, compile_glsl(glslang, source, stage, where_of.get(key, "?"), spv)

    workers = min(32, (os.cpu_count() or 4))
    with ThreadPoolExecutor(max_workers=workers) as pool:
        for key, words in pool.map(run, sorted(unique)):
            _SPIRV_CACHE[key] = words


def compile_glsl_cached(glslang: str, source: str, stage: str, where: str, spirv_version: str | None) -> list[int]:
    key = (source, stage, spirv_version)
    if key not in _SPIRV_CACHE:
        _SPIRV_CACHE[key] = compile_glsl(glslang, source, stage, where, spirv_version)
    return _SPIRV_CACHE[key]


def rust_param_value(spec: dict, where: str) -> str:
    ty = spec["type"]
    value = spec["value"]
    if ty == "IVec3":
        if len(value) != 3:
            raise SystemExit(f"{where}: IVec3 needs 3 components, got {value}")
        return f"IVec3::new({value[0]}, {value[1]}, {value[2]})"
    if ty == "UVec3":
        if len(value) != 3:
            raise SystemExit(f"{where}: UVec3 needs 3 components, got {value}")
        return f"UVec3::new({value[0]}, {value[1]}, {value[2]})"
    if ty == "IVec2":
        return f"IVec2::new({value[0]}, {value[1]})"
    if ty in ("u32", "i32", "usize"):
        return f"{value}{ty}"
    if ty == "bool":
        return "true" if value else "false"
    # A GLSL fragment - a type prefix, a layout qualifier, a function name. Carried into
    # the Rust as well as the shader so the host can pick the program that matches the
    # format it is about to bind, instead of trusting an index.
    if ty == "str":
        escaped = value.replace("\\", "\\\\").replace('"', '\\"')
        return f'"{escaped}"'
    # `enum:Axis` -> `Axis::X`. Upstream carries these as real enums (BufferType,
    # MaxWorkGroupSizeTest::Axis), and keeping them enums here means a typo in the
    # manifest is a compile error rather than a silently wrong test.
    if ty.startswith("enum:"):
        return f"{ty.removeprefix('enum:')}::{value}"
    # A list of indirect dispatch commands, as [offset, x, y, z] rows. Emitted both as
    # a Rust slice and (through a derived expression) as the GLSL that writes them, so
    # the shader and the host cannot disagree about what gets dispatched.
    if ty == "DispatchCommands":
        rows = ", ".join(f"DispatchCommand::new({r[0]}, [{r[1]}, {r[2]}, {r[3]}])" for r in value)
        return f"&[{rows}]"
    raise SystemExit(f"{where}: unsupported param type {ty!r}")


def rust_param_raw(spec: dict, where: str):
    """The plain Python value, for use in template substitution."""
    return spec["value"]


def rustfmt(text: str) -> str:
    """Runs the emitted Rust through rustfmt.

    Without this, a later `cargo fmt` would rewrite the generated file and `--check`
    would then report it as stale forever. Emitting already-formatted output makes
    `cargo fmt` a no-op here, so regeneration stays idempotent no matter what else
    ran. The SPIR-V arrays carry `#[rustfmt::skip]`, so they keep their 8-per-line
    layout and stay readable in a diff.
    """
    result = subprocess.run(
        ["rustfmt", "--edition", "2024", "--emit", "stdout", "--quiet"],
        input=text,
        capture_output=True,
        text=True,
        cwd=CRATE_DIR,
    )
    if result.returncode != 0:
        print(f"warning: rustfmt failed, emitting unformatted output:\n{result.stderr}", file=sys.stderr)
        return text
    return result.stdout


def format_spirv_words(words: list[int]) -> str:
    lines = []
    for i in range(0, len(words), 8):
        chunk = ", ".join(f"0x{w:08x}" for w in words[i : i + 8])
        lines.append(f"    {chunk},")
    return "\n".join(lines)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument(
        "--glslang",
        default=shutil.which("glslang") or shutil.which("glslangValidator"),
        help="path to the glslang executable (only needed when regenerating)",
    )
    ap.add_argument("--check", action="store_true", help="fail if the generated output would change")
    args = ap.parse_args()

    if not args.glslang:
        print(
            "error: glslang not found. It is needed only to regenerate shaders, not to\n"
            "       build or run hodow_cts. See the 'Working on the port' section of\n"
            "       hodow_cts/README.md for how to get one.",
            file=sys.stderr,
        )
        return 2

    manifests = sorted(MANIFEST_DIR.glob("*.toml"))
    if not manifests:
        print(f"error: no manifests in {MANIFEST_DIR}", file=sys.stderr)
        return 2

    # Pre-pass: expand every shader and compile them all in parallel, so the emit pass
    # below only ever reads from the cache.
    prescan: list[tuple[str, str, str | None]] = []
    where_of: dict = {}
    for manifest_path in manifests:
        m = tomllib.loads(manifest_path.read_text())
        default_spv = m.get("spirv_version")
        for case in m["case"]:
            where = f"{manifest_path.name}:{case['name']}"
            params = case.get("params", {})
            raw = {k: rust_param_raw(v, where) for k, v in params.items()}
            env = dict(raw)
            env.update(evaluate_derived(raw, case.get("derived", {})))
            for program in case["programs"]:
                tpl = TEMPLATE_DIR / program["template"]
                if not tpl.exists():
                    raise SystemExit(f"{where}: missing template {tpl}")
                src = substitute(tpl.read_text(), env, where)
                key = (src, program["stage"], program.get("spirv_version", default_spv))
                prescan.append(key)
                where_of[key] = where
    print(f"compiling {len(set(prescan))} distinct shaders on {min(32, os.cpu_count() or 4)} threads...", file=sys.stderr)
    warm_spirv_cache(args.glslang, prescan, where_of)

    out = [
        "// @generated by hodow_cts/scripts/compile_shaders.py - do not hand-edit.",
        "//",
        "// Regenerate with:",
        "//     python3 hodow_cts/scripts/compile_shaders.py --glslang <path>",
        "//",
        "// Every parameter below comes from hodow_cts/shaders/manifest/*.toml, which is",
        "// the single source of truth. Test code reads these constants instead of",
        "// restating the numbers, so the compiled shader and the host always agree.",
        "",
        "#![allow(clippy::unreadable_literal)]",
        "",
        "__IMPORTS__",
        "use crate::vk::programs::{BinaryCollection, ProgramBinary};",
        "",
    ]

    # Only the vector types actually used get imported; an unconditional import would
    # make every regeneration emit a warning.
    used_types: set[str] = set()

    total_cases = 0
    total_words = 0

    for manifest_path in manifests:
        manifest = tomllib.loads(manifest_path.read_text())
        module = manifest_path.stem
        rust_module = manifest["rust_module"]
        upstream = manifest["upstream_source"]
        # Optional, e.g. spirv_version = "spirv1.4" for groups that need it.
        spirv_version = manifest.get("spirv_version")

        out.append(f"/// Cases for `{rust_module}`.")
        out.append(f"/// Upstream: `{upstream}`")
        out.append(f"pub mod {module} {{")
        out.append("    use super::*;")
        out.append(f"    use crate::vkt::tests::{rust_module.replace('/', '::')}::*;")
        out.append("")

        # Constants of the same rust_type get an ALL_* array, so a test module looks up
        # what the generator actually emitted rather than a second list beside it.
        by_type: dict[str, list[str]] = {}

        for case in manifest["case"]:
            name = case["name"]
            where = f"{manifest_path.name}:{name}"
            const = case["rust_const"]
            rust_type = case["rust_type"]
            params = case.get("params", {})

            used_types.update(v["type"] for v in params.values() if v["type"].startswith(("IVec", "Vec", "UVec")))
            # Enum params name a type the test module defines; the `use ...::*` the
            # module emits already brings them into scope.

            raw = {k: rust_param_raw(v, where) for k, v in params.items()}
            derived = evaluate_derived(raw, case.get("derived", {}))
            subst_env = dict(raw)
            subst_env.update(derived)

            program_entries = []
            for program in case["programs"]:
                pname = program["name"]
                stage = program["stage"]
                template_path = TEMPLATE_DIR / program["template"]
                if not template_path.exists():
                    raise SystemExit(f"{where}: missing template {template_path}")

                source = substitute(template_path.read_text(), subst_env, where)

                expanded_path = EXPANDED_DIR / rust_module / f"{name}.{pname}.{stage}"
                expanded_path.parent.mkdir(parents=True, exist_ok=True)
                expanded_path.write_text(source)

                words = compile_glsl_cached(args.glslang, source, stage, where, program.get("spirv_version", spirv_version))
                total_words += len(words)

                # A program name is the string `BinaryCollection::get` is called with,
                # and upstream's are not all Rust identifiers - the renderpass tests
                # name theirs `<subpassNdx>-vert`. The lookup keeps the exact name; only
                # the symbol is sanitised.
                sym_suffix = re.sub(r"[^A-Za-z0-9_]", "_", pname.upper())
                spv_sym = f"SPV_{const}_{sym_suffix}"
                glsl_sym = f"GLSL_{const}_{sym_suffix}"

                out.append(f"    #[rustfmt::skip]")
                out.append(f"    static {spv_sym}: [u32; {len(words)}] = [")
                out.append(format_spirv_words(words))
                out.append("    ];")
                out.append(f"    static {glsl_sym}: &str = include_str!(")
                rel = expanded_path.relative_to(CRATE_DIR / "src" / "generated", walk_up=True)
                out.append(f'        "{rel.as_posix()}"')
                out.append("    );")
                out.append("")

                program_entries.append(
                    f'        ProgramBinary {{ name: "{pname}", spirv: &{spv_sym}, glsl: {glsl_sym} }},'
                )

            out.append(f"    static PROGRAMS_{const}: [ProgramBinary; {len(program_entries)}] = [")
            out.extend(program_entries)
            out.append("    ];")
            out.append("")
            out.append(f"    pub static {const}: {rust_type} = {rust_type} {{")
            out.append(f'        name: "{name}",')
            for pname, spec in params.items():
                out.append(f"        {pname}: {rust_param_value(spec, where)},")
            out.append(f"        programs: BinaryCollection::new(&PROGRAMS_{const}),")
            out.append("    };")
            out.append("")
            by_type.setdefault(rust_type, []).append(const)
            total_cases += 1

        for rust_type, consts in by_type.items():
            array = f"ALL_{camel_to_upper_snake(rust_type)}"
            out.append(f"    pub static {array}: [&{rust_type}; {len(consts)}] = [")
            out.extend(f"        &{c}," for c in consts)
            out.append("    ];")
            out.append("")

        out.append("}")
        out.append("")

    imports = f"use crate::tcu::{{{', '.join(sorted(used_types))}}};" if used_types else ""
    text = "\n".join(out).replace("__IMPORTS__\n", f"{imports}\n" if imports else "")
    text = rustfmt(text)

    if args.check:
        current = GENERATED.read_text() if GENERATED.exists() else ""
        if current != text:
            print("error: generated shaders are stale; re-run compile_shaders.py", file=sys.stderr)
            return 1
        print(f"ok: {total_cases} cases up to date")
        return 0

    GENERATED.parent.mkdir(parents=True, exist_ok=True)
    GENERATED.write_text(text)
    print(f"wrote {GENERATED.relative_to(CRATE_DIR.parent)}: {total_cases} cases, {total_words} SPIR-V words")
    return 0


if __name__ == "__main__":
    sys.exit(main())
