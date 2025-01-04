#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Emits src/generated/khr_api_coverage.rs: the data behind the `api.coverage` case of the Khronos GL CTS.

Upstream (`external/openglcts/modules/common/glcApiCoverageTests.cpp`) reads `CoverageGL<ver>.test` from the CTS data archive with an XML parser and checks every `<enum>` against the name functions of `gluStrUtil.inl` and every `<func>` against a table of per-function tests. This emits the parsed `.test` files (same order) and the name tables, so the port needs neither an archive nor an XML parser:

  CONFIG_GL30 ... : `Config { enums: (name, value text), funcs }` per data file;
  ENUM_NAMES      : every `case GL_X: return "GL_X"` of every name function of gluStrUtil.inl as (value, name), sorted. `getEnumNames` is the union over all functions, so one multimap is the same thing;
  BITFIELDS       : the seven `BitDesc` tables behind `isNameWithinBitfield`, in upstream's order;
  EA_<NAME>       : the `ea_<Name>` enum lists `ApiCoverageTestCase::init` fills in for the per-function tests, as the desktop context sees them (the `m_is_context_ES` branch is skipped, a later assignment wins), without the "End of List" terminator.

Token values come from `src/generated/glw.rs`. A token missing there is reported on stderr and left out (a name function entry for an enum that no glw constant exists for can never match a value the test reads from XML as a number; one that does appear in an XML file is an error).

Usage:
    python3 hodow_cts/scripts/gen_khr_api_coverage.py [--cts-dir ../tmp/glcts-src] [--check]
"""

from __future__ import annotations

import argparse
import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
OUT_PATH = CRATE_DIR / "src" / "generated" / "khr_api_coverage.rs"
DATA_DIR = "external/openglcts/data/gl_cts/data/common"
STR_UTIL = "framework/opengl/gluStrUtil.inl"
SOURCE = "external/openglcts/modules/common/glcApiCoverageTests.cpp"
INIT_END_LINE = 1536
ES_BRANCH = (703, 1040)
VERSIONS = ("30", "31", "32", "33", "40", "43")
BITFIELD_FUNCS = ("getBufferMaskStr", "getBufferMapFlagsStr", "getMemoryBarrierFlagsStr", "getShaderTypeMaskStr", "getContextMaskStr", "getClientWaitMaskStr", "getContextProfileMaskStr")


def glw_constants() -> dict[str, int]:
    values = {}
    for line in (CRATE_DIR / "src" / "generated" / "glw.rs").read_text().splitlines():
        m = re.match(r"pub const (GL_\w+): u(?:32|64) = (0x[0-9A-Fa-f]+|\d+);", line)
        if m:
            values[m.group(1)] = int(m.group(2), 0)
    return values


def rust_str(text: str) -> str:
    return '"' + text.replace("\\", "\\\\").replace('"', '\\"') + '"'


def parse_data_file(path: Path) -> tuple[list[tuple[str, str]], list[str]]:
    """`ApiCoverageTestCase::iterate`: the first <name> (and <value>) text inside each <enum>, the first <name> inside each <func>."""
    root = ET.parse(path).getroot()
    enums = []
    for element in root.iter("enum"):
        name = element.findtext("name") or ""
        value = element.findtext("value") or ""
        enums.append((name.strip(), value.strip()))
    funcs = [(element.findtext("name") or "").strip() for element in root.iter("func")]
    return enums, funcs


def parse_enum_arrays(lines: list[str], consts: dict[str, int]) -> dict[str, list[str]]:
    text = "\n".join(lines[:INIT_END_LINE])
    arrays: dict[str, list[str]] = {}
    for m in re.finditer(r"ea_(\w+)\s*=\s*\{(.*?)\};", text, re.S):
        line = text[: m.start()].count("\n") + 1
        if ES_BRANCH[0] <= line < ES_BRANCH[1]:
            continue
        items = []
        for expr in re.findall(r"ENUM\(([^)]*)\)", m.group(2)):
            tokens = re.findall(r"GL_\w+", expr)
            unknown = [t for t in tokens if t not in consts]
            if unknown:
                print(f"ea_{m.group(1)}: {unknown} has no glw constant, left out", file=sys.stderr)
                continue
            items.append(re.sub(r"\b(GL_\w+)", r"glw::\1", expr.strip()))
        arrays[m.group(1)] = items
    return arrays


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cts-dir", type=Path, default=REPO_DIR / "tmp" / "glcts-src")
    ap.add_argument("--check", action="store_true", help="fail if the committed file differs")
    args = ap.parse_args()

    consts = glw_constants()
    inl = (args.cts_dir / STR_UTIL).read_text()

    functions = re.split(r"\n(?=(?:const char\*|tcu::Format::Bitfield<16>)\s+get\w+\s*\(int value\))", inl)
    names: set[tuple[int, str]] = set()
    bitfields: dict[str, list[tuple[int, str]]] = {}
    missing = set()
    for body in functions:
        header = re.match(r"(const char\*|tcu::Format::Bitfield<16>)\s+(get\w+)\s*\(int value\)", body)
        if not header:
            continue
        func = header.group(2)
        if header.group(1) == "const char*":
            for token, text in re.findall(r'case (GL_\w+):\s*return "([^"]*)";', body):
                if token in consts:
                    names.add((consts[token], text))
                else:
                    missing.add(token)
        else:
            rows = []
            for token, text in re.findall(r'BitDesc\((GL_\w+),\s*"([^"]*)"\)', body):
                if token in consts:
                    rows.append((consts[token], text))
                else:
                    missing.add(token)
            bitfields[func] = rows

    eas = parse_enum_arrays((args.cts_dir / SOURCE).read_text().split("\n"), consts)

    configs = {}
    for version in VERSIONS:
        configs[version] = parse_data_file(args.cts_dir / DATA_DIR / f"CoverageGL{version}.test")

    if missing:
        print(f"{len(missing)} tokens of gluStrUtil.inl have no glw constant (left out): {' '.join(sorted(missing))}", file=sys.stderr)

    out = ["// Generated by hodow_cts/scripts/gen_khr_api_coverage.py - do not edit.", "", "use super::glw;", "", "pub struct Config {", "    pub enums: &'static [(&'static str, &'static str)],", "    pub funcs: &'static [&'static str],", "}", ""]
    for version in VERSIONS:
        enums, funcs = configs[version]
        out.append(f"pub const CONFIG_GL{version}: Config = Config {{")
        out.append("    enums: &[")
        for name, value in enums:
            out.append(f"        ({rust_str(name)}, {rust_str(value)}),")
        out.append("    ],")
        out.append("    funcs: &[")
        for name in funcs:
            out.append(f"        {rust_str(name)},")
        out.append("    ],")
        out.append("};")
        out.append("")

    for name, items in sorted(eas.items()):
        const = re.sub(r"(?<=[a-z0-9])(?=[A-Z])", "_", name).upper()
        out.append(f"pub const EA_{const}: [u32; {len(items)}] = [{', '.join(items)}];")
    out.append("")
    out.append(f"pub const ENUM_NAMES: [(u32, &str); {len(names)}] = [")
    for value, text in sorted(names):
        out.append(f"    (0x{value:08X}, {rust_str(text)}),")
    out.append("];")
    out.append("")
    out.append(f"pub const BITFIELDS: [&[(u64, &str)]; {len(BITFIELD_FUNCS)}] = [")
    for func in BITFIELD_FUNCS:
        out.append("    &[")
        for value, text in bitfields[func]:
            out.append(f"        (0x{value:X}, {rust_str(text)}),")
        out.append("    ],")
    out.append("];")
    out.append("")
    text = "\n".join(out)

    if args.check:
        if not OUT_PATH.exists() or OUT_PATH.read_text() != text:
            print(f"{OUT_PATH} is stale", file=sys.stderr)
            return 1
        return 0
    OUT_PATH.write_text(text)
    print(f"wrote {OUT_PATH}: {len(names)} names, " + ", ".join(f"GL{v}: {len(configs[v][0])} enums {len(configs[v][1])} funcs" for v in VERSIONS), file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
