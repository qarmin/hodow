#!/usr/bin/env python3
"""Compile the hodow_cts shader manifests into generated Rust.

This is the only place a test-case parameter is written down. For every case in
`shaders/manifest/*.toml` this script:

  1. evaluates the `derived` formulas (which restate the upstream initPrograms()
     arithmetic verbatim),
  2. substitutes params + derived values into the GLSL template,
  3. compiles the result to SPIR-V with glslang - the same compiler upstream uses,
  4. emits `src/generated/shaders/` containing the SPIR-V words *and* the params as
     Rust constants, one module per manifest.

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
import zlib
import shutil
import struct
import subprocess
import sys
import threading
import tomllib
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import vk_crates  # noqa: E402

CRATE_DIR = Path(__file__).resolve().parent.parent
MANIFEST_DIR = CRATE_DIR / "shaders" / "manifest"
TEMPLATE_DIR = CRATE_DIR / "shaders" / "src"
GENERATED_BASE = CRATE_DIR / "src" / "generated"
# The layout before the Vulkan half was split into crates: one `shaders.rs` and one `shaders/` for all of it. Whatever is
# left there is stale.
OLD_ROOT = GENERATED_BASE / "shaders.rs"
OLD_DIR = GENERATED_BASE / "shaders"


def crate_shaders_dir(crate: str) -> Path:
    """Where the shaders of one Vulkan crate go: `src/generated/vk_<crate>/shaders.rs` is the root, its modules are beside it."""
    return GENERATED_BASE / f"vk_{crate}" / "shaders"

# A module whose emitted text passes this is cut into `<module>/<group>.rs`, grouped by case name. Git hosts
# warn above 50 MB and refuse a push above 100 MB, and one manifest
# (binding_model_shader_access) is on its own bigger than either; the cap has to live
# in the generator, because nothing else notices the file growing past it.
PART_SIZE_LIMIT = 4_000_000

STAGE_TO_GLSLANG = {"comp": "comp", "vert": "vert", "frag": "frag", "tesc": "tesc", "tese": "tese", "geom": "geom", "mesh": "mesh", "task": "task", "hlsl_comp": "hlsl", "hlsl_geom": "hlsl", "hlsl_vert": "hlsl", "hlsl_tesc": "hlsl", "hlsl_tese": "hlsl", "hlsl_frag": "hlsl", "rgen": "rgen", "ahit": "rahit", "chit": "rchit", "miss": "rmiss", "isec": "rint", "call": "rcall"}

# A program whose `stage` is this is SPIR-V assembly (upstream's `spirvAsmSources`), assembled with spirv-as instead of compiled.
ASM_STAGE = "asm"

# Set from --spirv-as; only programs of `ASM_STAGE` use it.
SPIRV_AS: str | None = None

SUBST_RE = re.compile(r"\$\{((?:'[^']*'|\"[^\"]*\"|[^}'\"])+)\}")


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


_RESOURCE_CONF: dict[str, str] = {}

# The limits vkShaderToSpirV.cpp raises above glslang's defaults for shaders that need more than the stock 4 / 64.
RESOURCE_OVERRIDES = {
    "MaxTransformFeedbackBuffers": 8,
    "MaxTransformFeedbackInterleavedComponents": 16382,
    "MaxMeshOutputVerticesEXT": 2048,
    "MaxMeshOutputPrimitivesEXT": 2048,
    "MaxMeshWorkGroupSizeX_EXT": 1024,
    "MaxMeshWorkGroupSizeY_EXT": 1024,
    "MaxMeshWorkGroupSizeZ_EXT": 1024,
    "MaxMeshOutputVerticesNV": 256,
    "MaxMeshOutputPrimitivesNV": 512,
    "MaxMeshWorkGroupSizeX_NV": 1024,
    "MaxMeshWorkGroupSizeY_NV": 1024,
    "MaxMeshWorkGroupSizeZ_NV": 1024,
}


def resource_conf(glslang: str) -> str:
    """Path to glslang's default resource config with `RESOURCE_OVERRIDES` applied."""
    if glslang not in _RESOURCE_CONF:
        import tempfile

        text = subprocess.run([glslang, "-c"], capture_output=True, text=True, check=True).stdout
        for name, value in RESOURCE_OVERRIDES.items():
            text, n = re.subn(rf"(?m)^({name}) \d+", rf"\g<1> {value}", text)
            if n != 1:
                raise SystemExit(f"glslang -c: {name} not found in the default resource config")
        path = Path(tempfile.mkdtemp()) / "resources.conf"
        path.write_text(text)
        _RESOURCE_CONF[glslang] = str(path)
    return _RESOURCE_CONF[glslang]


def assemble_spirv(source: str, where: str, spirv_version: str | None) -> bytes:
    """Runs spirv-as and returns the SPIR-V as a list of 32-bit words.

    `spirv_version` is the same `spirvX.Y` string glslang takes; spirv-as spells it `spvX.Y`. Without one the module is
    assembled for SPIR-V 1.3, the baseline of Vulkan 1.1 that the GLSL programs target.
    """
    import tempfile

    if not SPIRV_AS:
        raise SystemExit(f"{where}: spirv-as is needed for this program (--spirv-as)")
    target = "spv" + spirv_version.removeprefix("spirv") if spirv_version else "spv1.3"
    with tempfile.TemporaryDirectory() as td:
        src_path = Path(td) / "shader.spvasm"
        spv_path = Path(td) / "shader.spv"
        src_path.write_text(source, encoding="utf-8")
        result = subprocess.run([SPIRV_AS, "--target-env", target, str(src_path), "-o", str(spv_path)], capture_output=True, text=True)
        if result.returncode != 0:
            raise SystemExit(f"{where}: spirv-as failed\n{result.stdout}\n{result.stderr}")
        data = spv_path.read_bytes()

    if len(data) % 4 != 0:
        raise SystemExit(f"{where}: SPIR-V size {len(data)} is not a multiple of 4")
    return data


DISK_CACHE_DIR = CRATE_DIR.parent / "tmp" / "shader_cache"
_TOOL_IDENTITY: dict[str, str] = {}


def tool_identity(tool: str) -> str:
    """Version text of a compiler, so a cached SPIR-V is never reused across a glslang/spirv-as upgrade."""
    if tool not in _TOOL_IDENTITY:
        out = subprocess.run([tool, "--version"], capture_output=True, text=True)
        _TOOL_IDENTITY[tool] = out.stdout + out.stderr
    return _TOOL_IDENTITY[tool]


def disk_cache_path(glslang: str, source: str, stage: str, spirv_version: str | None) -> Path:
    import hashlib

    tool = SPIRV_AS if stage == ASM_STAGE else glslang
    h = hashlib.sha256()
    for part in (source, stage, spirv_version or "", tool_identity(tool) if tool else ""):
        h.update(part.encode())
        h.update(b"\0")
    digest = h.hexdigest()
    return DISK_CACHE_DIR / digest[:2] / f"{digest}.spv"


def compile_glsl(glslang: str, source: str, stage: str, where: str, spirv_version: str | None) -> bytes:
    """Compiles through the on-disk cache (`tmp/shader_cache`, git-ignored): an unchanged shader is never recompiled."""
    path = disk_cache_path(glslang, source, stage, spirv_version)
    if path.exists():
        data = path.read_bytes()
        return data
    data = compile_glsl_uncached(glslang, source, stage, where, spirv_version)
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_suffix(f".{os.getpid()}.{threading.get_ident()}.tmp")
    tmp.write_bytes(data)
    tmp.replace(path)
    return data


def compile_glsl_uncached(glslang: str, source: str, stage: str, where: str, spirv_version: str | None) -> bytes:
    """Runs glslang and returns the SPIR-V as a list of 32-bit words.

    `spirv_version` mirrors the `vk::SPIRV_VERSION_*` a test group passes upstream.
    It has to be per-group, not global: GL_EXT_shared_memory_block needs SPIR-V 1.4,
    while raising the floor for every group would silently change the SPIR-V already
    generated for the others - and the whole point of this file is that regeneration
    stays diff-clean.
    """
    import tempfile

    if stage == ASM_STAGE:
        return assemble_spirv(source, where, spirv_version)

    with tempfile.TemporaryDirectory() as td:
        src_path = Path(td) / f"shader.{STAGE_TO_GLSLANG[stage]}"
        spv_path = Path(td) / "shader.spv"
        src_path.write_text(source)

        # -V targets Vulkan SPIR-V, which is what deqp asks glslang for.
        cmd = [glslang, resource_conf(glslang), "-V", "--target-env", "vulkan1.1"]
        if stage.startswith("hlsl_"):
            # upstream's `hlslSources.add(..)`: HLSL entry point `main`, compiled as the stage the name says
            cmd += ["-D", "-S", stage[len("hlsl_"):], "-e", "main"]
        if spirv_version:
            cmd += ["--target-env", spirv_version]
        cmd += [str(src_path), "-o", str(spv_path)]
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode != 0:
            raise SystemExit(f"{where}: glslang failed\n{result.stdout}\n{result.stderr}")

        data = spv_path.read_bytes()

    if len(data) % 4 != 0:
        raise SystemExit(f"{where}: SPIR-V size {len(data)} is not a multiple of 4")
    if data[:4] != b"\x03\x02\x23\x07":
        raise SystemExit(f"{where}: output is not SPIR-V (bad magic)")
    return data


# Cache of compiled SPIR-V, keyed by exactly the inputs that determine the output.
_SPIRV_CACHE: dict[tuple[str, str, str | None], bytes] = {}


# Filled instead of exiting at the first bad shader when --keep-going is given.
KEEP_GOING = False
FAILURES: list[tuple[str, str]] = []


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
        try:
            if disk_cache_path(glslang, source, stage, spv).exists():
                return key, None
            compile_glsl(glslang, source, stage, where_of.get(key, "?"), spv)
            return key, None
        except SystemExit as exc:
            if not KEEP_GOING:
                raise
            FAILURES.append((where_of.get(key, "?"), str(exc)))
            return key, None

    workers = max(1, min(32, (os.cpu_count() or 4) // 2))
    with ThreadPoolExecutor(max_workers=workers) as pool:
        list(pool.map(run, unique))


def compile_glsl_cached(glslang: str, source: str, stage: str, where: str, spirv_version: str | None) -> bytes:
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


FMT_CACHE_DIR = CRATE_DIR.parent / "tmp" / "shader_cache" / "rustfmt"
MANIFEST_CACHE_DIR = CRATE_DIR.parent / "tmp" / "shader_cache" / "manifests"


_TEMPLATES: dict[Path, str] = {}


def read_template(path: Path) -> str:
    if path not in _TEMPLATES:
        _TEMPLATES[path] = path.read_text()
    return _TEMPLATES[path]


def load_manifest(path: Path) -> dict:
    """Parsed manifest; tomllib needs ~50 s for all of them, so the parse is cached by content hash."""
    import hashlib
    import pickle

    raw = path.read_bytes()
    cached = MANIFEST_CACHE_DIR / f"{hashlib.sha256(raw).hexdigest()}.pkl"
    if cached.exists():
        return pickle.loads(cached.read_bytes())
    manifest = tomllib.loads(raw.decode())
    MANIFEST_CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cached.write_bytes(pickle.dumps(manifest, protocol=pickle.HIGHEST_PROTOCOL))
    return manifest


def rustfmt(text: str) -> str:
    """Runs the emitted Rust through rustfmt.

    Without this, a later `cargo fmt` would rewrite the generated file and `--check`
    would then report it as stale forever. Emitting already-formatted output makes
    `cargo fmt` a no-op here, so regeneration stays idempotent no matter what else
    ran. The SPIR-V itself is not in the Rust: it is a `.spv` blob next to each file.
    """
    import hashlib

    key = hashlib.sha256(text.encode() + b"\0" + tool_identity("rustfmt").encode()).hexdigest()
    cached = FMT_CACHE_DIR / key[:2] / f"{key}.rs"
    if cached.exists():
        return cached.read_text()
    out = rustfmt_uncached(text)
    if out is not text:
        cached.parent.mkdir(parents=True, exist_ok=True)
        cached.write_text(out)
    return out


def rustfmt_uncached(text: str) -> str:
    result = subprocess.run(
        ["rustfmt", "--edition", "2024", "--config", "max_width=180", "--emit", "stdout", "--quiet"],
        input=text,
        capture_output=True,
        text=True,
        cwd=CRATE_DIR,
    )
    if result.returncode != 0:
        print(f"warning: rustfmt failed, emitting unformatted output:\n{result.stderr}", file=sys.stderr)
        return text
    return result.stdout


class Blob:
    """The SPIR-V of one generated Rust file, as little-endian words in the `.spv` file beside it."""

    def __init__(self) -> None:
        self.data = bytearray()

    def add(self, words: bytes) -> int:
        offset = len(self.data) // 4
        self.data.extend(words)
        return offset

    def to_bytes(self) -> bytes:
        return bytes(self.data)


class TextBlob:
    """The GLSL of one generated Rust file, concatenated as UTF-8 in the `.glsl` file beside it.

    A shader's source is a `&str` cut out of that file at a byte offset, so the crate has one `include_str!` per part
    instead of one per program (over 300,000 of them were the larger half of what rustc spent expanding macros). The
    same text inside one part is stored once."""

    def __init__(self) -> None:
        self.chunks: list[bytes] = []
        self.size = 0
        self.known: dict[str, tuple[int, int]] = {}

    def add(self, text: str) -> tuple[int, int]:
        if text in self.known:
            return self.known[text]
        data = text.encode("utf-8")
        entry = (self.size, len(data))
        self.chunks.append(data)
        self.size += len(data)
        self.known[text] = entry
        return entry

    def to_bytes(self) -> bytes:
        return b"".join(self.chunks)


GEN_HEADER = [
    "// @generated by hodow_cts/scripts/compile_shaders.py - do not hand-edit.",
    "//",
    "// Regenerate with:",
    "//     python3 hodow_cts/scripts/compile_shaders.py --glslang <path>",
]

# The part modules are named after the upstream case, which can carry capitals (graphicsfuzz's `_O_`/`_Os_` optimizer flags).
NON_SNAKE_ALLOW = "#[allow(non_snake_case)]\n"


RUST_KEYWORDS = {"as", "break", "const", "continue", "crate", "else", "enum", "extern", "false", "fn", "for", "if", "impl", "in", "let", "loop", "match", "mod", "move", "mut", "pub", "ref", "return", "self", "static", "struct", "super", "trait", "true", "type", "unsafe", "use", "where", "while", "async", "await", "dyn"}


def split_case_name(name: str) -> tuple[list[str], int | None]:
    """`bda12` -> (["bda"], 12); `uint_0_uint_4` -> (["uint", "0", "uint"], 4); `copy_struct` -> (["copy", "struct"], None)."""
    tokens = name.split("_")
    m = re.fullmatch(r"([A-Za-z]*)(\d+)", tokens[-1])
    if m is None:
        return tokens, None
    head = tokens[:-1] + ([m.group(1)] if m.group(1) else [])
    return head, int(m.group(2))


def file_label(words: list[str], suffix: str = "") -> str:
    label = "_".join(w for w in words if w) + suffix
    label = re.sub(r"[^A-Za-z0-9_]", "_", label)
    if not label or label[0].isdigit() or label in RUST_KEYWORDS:
        label = f"g_{label}"
    return label


# A case named after a content hash (`rx_d028c0823764`). Such names have no words to split by: going one word deeper gives
# every case a group of its own, which was 45,000 files of 20 lines each and what made rustc spend 12 GB expanding them.
HASH_TAIL = re.compile(r"[0-9a-f]{8,}")


def looks_hashed(members: list[dict]) -> bool:
    hashed = sum(1 for m in members if HASH_TAIL.fullmatch(m["name"].rsplit("_", 1)[-1]))
    return hashed * 10 >= len(members) * 9


def assign_parts(items: list[dict]) -> dict[str, list[dict]]:
    """Decides which `<module>/<group>.rs` each case goes in, from its name alone.

    The previous `partN.rs` was cut by position, so one case added at the front of a
    manifest shifted every later case across a boundary and rewrote every file. Here a
    case's file depends on its own name (and on its siblings' only through size, which
    changes a boundary rarely): cases are grouped by the leading `_`-separated words of
    the name, taking more words only while a group is still over `PART_SIZE_LIMIT`,
    and a group that no more words can split is cut into ranges of its trailing number
    (`bda_0_49.rs`), or by a hash of the name when it has none. A group whose names are themselves hashes is
    not split by word at all: it goes straight to hash buckets, as many as keep each under the limit.
    """
    total = sum(i["size"] for i in items)
    if total < PART_SIZE_LIMIT:
        return {"all": items}

    out: dict[str, list[dict]] = {}
    for item in items:
        item["words"], item["number"] = split_case_name(item["name"])

    def split(group: list[dict], depth: int) -> None:
        keyed: dict[tuple[str, ...], list[dict]] = {}
        for item in group:
            keyed.setdefault(tuple(item["words"][:depth]), []).append(item)
        for key, members in keyed.items():
            if sum(m["size"] for m in members) < PART_SIZE_LIMIT:
                out.setdefault(file_label(list(key)), []).extend(members)
                continue
            if looks_hashed(members):
                by_hash(list(key), members)
                continue
            longer = [m for m in members if len(m["words"]) > depth]
            if longer and len({tuple(m["words"][: depth + 1]) for m in longer}) > 1:
                split(members, depth + 1)
                continue
            by_number(list(key), members)

    def by_hash(key: list[str], members: list[dict]) -> None:
        buckets = 1
        while sum(m["size"] for m in members) / buckets >= PART_SIZE_LIMIT * 0.75:
            buckets *= 2
        for m in members:
            out.setdefault(file_label(key, f"_h{zlib.crc32(m['name'].encode()) % buckets}"), []).append(m)

    def by_number(key: list[str], members: list[dict]) -> None:
        numbered = [m for m in members if m["number"] is not None]
        plain = [m for m in members if m["number"] is None]
        if plain:
            buckets = 1
            while sum(m["size"] for m in plain) / buckets >= PART_SIZE_LIMIT * 0.75:
                buckets *= 2
            for m in plain:
                bucket = zlib.crc32(m["name"].encode()) % buckets
                out.setdefault(file_label(key, f"_h{bucket}" if buckets > 1 else ""), []).append(m)
        if not numbered:
            return
        # The widest range that still fits, so a file holds as many cases as the limit allows.
        width = 1
        for candidate in (1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000):
            ranges: dict[int, int] = {}
            for m in numbered:
                ranges[m["number"] // candidate] = ranges.get(m["number"] // candidate, 0) + m["size"]
            if max(ranges.values()) >= PART_SIZE_LIMIT:
                break
            width = candidate
        for m in numbered:
            lo = (m["number"] // width) * width
            out.setdefault(file_label(key, f"_{lo}_{lo + width - 1}"), []).append(m)

    split(items, 1)
    # Cases keep their manifest order inside a file.
    order = {id(i): n for n, i in enumerate(items)}
    for members in out.values():
        members.sort(key=lambda m: order[id(m)])
    return out


def text_size(lines: list[str]) -> int:
    return sum(len(line) + 1 for line in lines)


def write_or_check(files: dict[Path, str | bytes], check: bool, scopes: list[tuple[Path, str]] | None = None) -> int:
    """Writes every generated file, and deletes any that regeneration no longer emits.

    A module that shrinks below the split threshold, or a manifest that is renamed,
    leaves `partN.rs` files behind that still compile - so a stale one is invisible
    until it drifts. Removing whatever is not in `files` keeps `src/generated/shaders/`
    exactly what the manifests describe.
    """
    shader_dirs = [crate_shaders_dir(crate) for crate in vk_crates.load()] + [OLD_DIR]
    existing: set[Path] = set()
    for directory in shader_dirs:
        if directory.exists():
            existing |= set(directory.rglob("*.rs")) | set(directory.rglob("*.spv")) | set(directory.rglob("*.glsl"))
        root_file = OLD_ROOT if directory == OLD_DIR else directory.parent / "shaders.rs"
        if root_file.exists():
            existing.add(root_file)
    if scopes is not None:
        existing = {p for p in existing if any(p.parent == d and p.stem == m or d / m in p.parents for d, m in scopes)}
    stale = sorted(existing - set(files))

    if check:
        problems = [f"stale: {p.relative_to(CRATE_DIR)}" for p in stale]
        for path, text in sorted(files.items()):
            current = (path.read_bytes() if isinstance(text, bytes) else path.read_text()) if path.exists() else None
            if current != text:
                problems.append(f"{'missing' if not path.exists() else 'differs'}: {path.relative_to(CRATE_DIR)}")
        if problems:
            print("error: generated shaders are stale; re-run compile_shaders.py", file=sys.stderr)
            for problem in problems[:10]:
                print(f"  {problem}", file=sys.stderr)
            if len(problems) > 10:
                print(f"  ... and {len(problems) - 10} more", file=sys.stderr)
            return 1
        return 0

    for path in stale:
        path.unlink()
    for path, text in files.items():
        path.parent.mkdir(parents=True, exist_ok=True)
        data = text if isinstance(text, bytes) else text.encode()
        # An identical file keeps its mtime, so cargo does not rebuild what did not change.
        if path.exists() and path.read_bytes() == data:
            continue
        path.write_bytes(data)
    # Left over once a module stops needing parts.
    for base in shader_dirs:
        if base.exists():
            for directory in sorted((p for p in base.rglob("*") if p.is_dir()), reverse=True) + [base]:
                if not any(directory.iterdir()):
                    directory.rmdir()
    return 0


def main() -> int:
    os.nice(10)
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument(
        "--glslang",
        default=shutil.which("glslang") or shutil.which("glslangValidator"),
        help="path to the glslang executable (only needed when regenerating)",
    )
    ap.add_argument(
        "--spirv-as",
        default=shutil.which("spirv-as"),
        help="path to the spirv-as executable (only needed for programs with stage = \"asm\")",
    )
    ap.add_argument("--check", action="store_true", help="fail if the generated output would change")
    ap.add_argument(
        "--only",
        nargs="+",
        metavar="MANIFEST",
        help="regenerate only these manifests (file stem, e.g. api_descriptor_set); the crate roots are left alone, so a new manifest needs a full run",
    )
    ap.add_argument("--exclude", nargs="+", default=[], metavar="MANIFEST", help="leave these manifests out of the run entirely (file stem)")
    ap.add_argument("--keep-going", action="store_true", help="compile everything, write nothing, and report every failing shader to tmp/shader_failures.txt")
    args = ap.parse_args()
    global KEEP_GOING
    KEEP_GOING = args.keep_going

    global SPIRV_AS
    SPIRV_AS = args.spirv_as

    if not args.glslang:
        print(
            "error: glslang not found. It is needed only to regenerate shaders, not to\n"
            "       build or run hodow_cts. See the 'Working on the port' section of\n"
            "       hodow_cts/README.md for how to get one.",
            file=sys.stderr,
        )
        return 2

    manifests = sorted(m for m in MANIFEST_DIR.glob("*.toml") if m.stem not in args.exclude)
    if args.only:
        unknown = sorted(set(args.only) - {m.stem for m in manifests})
        if unknown:
            print(f"error: no such manifest: {', '.join(unknown)}", file=sys.stderr)
            return 2
        manifests = [m for m in manifests if m.stem in args.only]
    if not manifests:
        print(f"error: no manifests in {MANIFEST_DIR}", file=sys.stderr)
        return 2

    # Pre-pass: expand every shader and compile them all in parallel, so the emit pass
    # below only ever reads from the cache.
    prescan: list[tuple[str, str, str | None]] = []
    where_of: dict = {}
    for manifest_path in manifests:
        m = load_manifest(manifest_path)
        default_spv = m.get("spirv_version")
        for case in m["case"]:
            where = f"{manifest_path.name}:{case['name']}"
            try:
                params = case.get("params", {})
                raw = {k: rust_param_raw(v, where) for k, v in params.items()}
                env = dict(raw)
                env.update(evaluate_derived(raw, case.get("derived", {})))
                for program in case["programs"]:
                    tpl = TEMPLATE_DIR / program["template"]
                    if not tpl.exists():
                        raise SystemExit(f"{where}: missing template {tpl}")
                    src = substitute(read_template(tpl), env, where)
                    key = (src, program["stage"], program.get("spirv_version", default_spv))
                    prescan.append(key)
                    where_of[key] = where
            except (SystemExit, Exception) as exc:  # noqa: BLE001
                if not KEEP_GOING:
                    raise
                FAILURES.append((where, f"{type(exc).__name__}: {exc}"))
    print(f"compiling {len(set(prescan))} distinct shaders on {max(1, min(32, (os.cpu_count() or 4) // 2))} threads...", file=sys.stderr)
    warm_spirv_cache(args.glslang, prescan, where_of)
    if KEEP_GOING:
        report = CRATE_DIR.parent / "tmp" / "shader_failures.txt"
        report.parent.mkdir(exist_ok=True)
        with report.open("w") as out:
            for where, message in sorted(FAILURES):
                out.write(f"=== {where}\n{message.strip()}\n")
        print(f"{len(FAILURES)} failing shader(s); details in {report}", file=sys.stderr)
        return 1 if FAILURES else 0

    root_header = GEN_HEADER + [
        "//",
        "// Every parameter below comes from hodow_cts/shaders/manifest/*.toml, which is",
        "// the single source of truth. Test code reads these constants instead of",
        "// restating the numbers, so the compiled shader and the host always agree.",
        "//",
        "// One module per manifest, each in its own file under `shaders/`, cut into",
        "// `<module>/<group>.rs` once it gets big. Programs that compile to identical",
        "// SPIR-V share a single static (a slice of the file's `.spv` blob), named after the first case that used it -",
        "// over half of the SPIR-V here is one shader repeated across the variants of",
        "// a case group.",
        "",
        "#![allow(clippy::unreadable_literal)]",
        "",
        "__IMPORTS__",
        "use crate::vk::programs::{BinaryCollection, KEEP_GLSL, ProgramBinary, SpirvBlob, glsl_text, spirv_words};",
        "",
    ]

    # Only the vector types actually used get imported; an unconditional import would
    # make every regeneration emit a warning.
    used_types: dict[str, set[str]] = {}
    roots: dict[str, list[str]] = {}

    files: dict[Path, str | bytes] = {}
    total_cases = 0
    total_words = 0

    for manifest_path in manifests:
        manifest = load_manifest(manifest_path)
        module = manifest_path.stem
        rust_module = manifest["rust_module"]
        crate = vk_crates.crate_of_group(rust_module.split("/")[0])
        gen_dir = crate_shaders_dir(crate)
        roots.setdefault(crate, list(root_header))
        root = roots[crate]
        upstream = manifest["upstream_source"]
        # Optional, e.g. spirv_version = "spirv1.4" for groups that need it.
        spirv_version = manifest.get("spirv_version")
        use_tests = f"use crate::vkt::tests::{rust_module.replace('/', '::')}::*;"

        # Constants of the same rust_type get an ALL_* array, so a test module looks up
        # what the generator actually emitted rather than a second list beside it.
        by_type: dict[str, list[str]] = {}

        # Pass 1: everything that has side effects or needs glslang. Each case is kept as
        # data, so which file it lands in can be decided from its name alone afterwards.
        prepared: list[dict] = []
        for case in manifest["case"]:
            name = case["name"]
            where = f"{manifest_path.name}:{name}"
            const = case["rust_const"]
            rust_type = case["rust_type"]
            params = case.get("params", {})

            used_types.setdefault(crate, set()).update(v["type"] for v in params.values() if v["type"].startswith(("IVec", "Vec", "UVec")))
            # Enum params name a type the test module defines; the `use ...::*` the
            # module emits already brings them into scope.

            raw = {k: rust_param_raw(v, where) for k, v in params.items()}
            derived = evaluate_derived(raw, case.get("derived", {}))
            subst_env = dict(raw)
            subst_env.update(derived)

            programs = []
            for program in case["programs"]:
                pname = program["name"]
                stage = program["stage"]
                template_path = TEMPLATE_DIR / program["template"]
                if not template_path.exists():
                    raise SystemExit(f"{where}: missing template {template_path}")

                source = substitute(read_template(template_path), subst_env, where)

                words = compile_glsl_cached(args.glslang, source, stage, where, program.get("spirv_version", spirv_version))
                total_words += len(words) // 4
                programs.append((pname, words, source))

            by_type.setdefault(rust_type, []).append(const)
            total_cases += 1
            prepared.append(
                {
                    "name": name,
                    "const": const,
                    "rust_type": rust_type,
                    "params": params,
                    "where": where,
                    "programs": programs,
                }
            )

        def render_case(item: dict, emitted: dict[tuple[int, ...], str], blob: Blob, text: TextBlob) -> list[str]:
            const = item["const"]
            out: list[str] = []
            program_entries = []
            for pname, words, source in item["programs"]:
                # A program name is the string `BinaryCollection::get` is called with,
                # and upstream's are not all Rust identifiers - the renderpass tests
                # name theirs `<subpassNdx>-vert`. The lookup keeps the exact name; only
                # the symbol is sanitised.
                sym_suffix = re.sub(r"[^A-Za-z0-9_]", "_", pname.upper())
                spv_sym = emitted.get(words)
                if spv_sym is None:
                    spv_sym = f"SPV_{const}_{sym_suffix}"
                    emitted[words] = spv_sym
                    out.append(f"static {spv_sym}: &[u32] = spirv_words(SPIRV_BLOB, {blob.add(words)}, {len(words) // 4});")

                glsl_offset, glsl_len = text.add(source)
                program_entries.append(
                    f'    ProgramBinary {{ name: "{pname}", spirv: {spv_sym}, glsl: glsl_text(GLSL_BLOB, {glsl_offset}, {glsl_len}) }},'
                )

            out.append(f"static PROGRAMS_{const}: [ProgramBinary; {len(program_entries)}] = [")
            out.extend(program_entries)
            out.append("];")
            out.append("")
            out.append(f"pub static {const}: {item['rust_type']} = {item['rust_type']} {{")
            out.append(f'    name: "{item["name"]}",')
            for pname, spec in item["params"].items():
                out.append(f"    {pname}: {rust_param_value(spec, item['where'])},")
            out.append(f"    programs: BinaryCollection::new(&PROGRAMS_{const}),")
            out.append("};")
            out.append("")
            return out

        # Pass 2: size each case (sharing a static across the module, as the parts will,
        # approximately) and name the file each one goes in. A split module is cut by
        # what the cases are called, never by where they happen to sit.
        estimate_emitted: dict[tuple[int, ...], str] = {}
        for item in prepared:
            estimate_blob = Blob()
            estimate_text = TextBlob()
            item["size"] = (
                text_size(render_case(item, estimate_emitted, estimate_blob, estimate_text))
                + len(estimate_blob.data)
                + estimate_text.size
            )
        parts_by_label = assign_parts(prepared)
        # Deduplication is per part, not per module: a static can only be shared by
        # cases in the same file, and the shaders that repeat do so hundreds of times
        # across a group, so a handful of copies (one per part) costs almost nothing.
        parts: list[list[str]] = []
        blobs: list[Blob] = []
        texts: list[TextBlob] = []
        names: list[str] = []
        for label, items in sorted(parts_by_label.items()):
            emitted: dict[tuple[int, ...], str] = {}
            blob = Blob()
            text = TextBlob()
            lines: list[str] = []
            for item in items:
                lines.extend(render_case(item, emitted, blob, text))
            parts.append(lines)
            blobs.append(blob)
            texts.append(text)
            names.append(label)

        def blob_decl(stem: str) -> list[str]:
            return [
                f'static SPIRV_BLOB: &SpirvBlob<[u8]> = &SpirvBlob(*include_bytes!("{stem}.spv"));',
                f'static GLSL_BLOB: &str = if KEEP_GLSL {{ include_str!("{stem}.glsl") }} else {{ "" }};',
                "",
            ]

        all_arrays: list[str] = []
        for rust_type, consts in by_type.items():
            array = f"ALL_{camel_to_upper_snake(rust_type)}"
            all_arrays.append(f"pub static {array}: [&{rust_type}; {len(consts)}] = [")
            all_arrays.extend(f"    &{c}," for c in consts)
            all_arrays.append("];")
            all_arrays.append("")

        root.append(f"/// Cases for `{rust_module}`.")
        root.append(f"/// Upstream: `{upstream}`")
        root.append(f"pub mod {module};")
        root.append("")

        module_head = GEN_HEADER + ["", f"//! Cases for `{rust_module}`.", ""]
        if len(parts) == 1:
            body = "\n".join(module_head + ["use super::*;", use_tests, ""] + blob_decl(module) + parts[0] + all_arrays)
            files[gen_dir / f"{module}.rs"] = rustfmt(body)
            files[gen_dir / f"{module}.spv"] = blobs[0].to_bytes()
            files[gen_dir / f"{module}.glsl"] = texts[0].to_bytes()
        else:
            # No `use super::*` here: with the cases in the parts, the only names this
            # file resolves are the case types, and an unused glob is a warning.
            body = "\n".join(
                module_head
                + [use_tests, ""]
                + [f"{NON_SNAKE_ALLOW}mod {n};" if n != n.lower() else f"mod {n};" for n in names]
                + [""]
                + [f"pub use {n}::*;" for n in names]
                + [""]
                + all_arrays
            )
            files[gen_dir / f"{module}.rs"] = rustfmt(body)
            part_dir = gen_dir / module
            for part_name, part_lines, part_blob, part_text in zip(names, parts, blobs, texts):
                # A part cannot say `use super::*`: that would glob-import the sibling
                # parts the module re-exports, and back again through this import.
                head = GEN_HEADER + ["", "use crate::generated::shaders::*;", use_tests, ""]
                text = "\n".join(head + blob_decl(part_name) + part_lines)
                files[part_dir / f"{part_name}.rs"] = rustfmt(text)
                files[part_dir / f"{part_name}.spv"] = part_blob.to_bytes()
                files[part_dir / f"{part_name}.glsl"] = part_text.to_bytes()

    scopes = [(crate_shaders_dir(vk_crates.crate_of_group(load_manifest(m)["rust_module"].split("/")[0])), m.stem) for m in manifests]
    for crate, root in {} if args.only else roots.items():
        types = used_types.get(crate, set())
        imports = f"use crate::tcu::{{{', '.join(sorted(types))}}};" if types else ""
        root_text = "\n".join(root).replace("__IMPORTS__\n", f"{imports}\n" if imports else "")
        files[crate_shaders_dir(crate).parent / "shaders.rs"] = rustfmt(root_text)

    status = write_or_check(files, args.check, scopes if args.only else None)
    if status != 0:
        return status
    if args.check:
        print(f"ok: {total_cases} cases up to date")
        return 0
    largest = max((len(t) for t in files.values()), default=0)
    print(
        f"wrote {len(files)} files under {GENERATED_BASE.relative_to(CRATE_DIR.parent)}: "
        f"{total_cases} cases, {total_words} SPIR-V words, largest file {largest / 1e6:.1f} MB"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
