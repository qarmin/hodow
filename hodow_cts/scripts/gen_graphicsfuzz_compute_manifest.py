#!/usr/bin/env python3
"""Writes shaders/manifest/graphicsfuzz_compute.toml: the compute Amber scripts of dEQP-VK.graphicsfuzz.* - three VkScript ones (`[compute shader spirv]`) and two
`PIPELINE compute` ones - that neither gen_graphicsfuzz_manifest.py (they draw nothing) nor the Amber compute conversion (a uniform buffer next to the storage buffer) take.

Each is one SPIR-V assembly compute shader over a read-write storage buffer at binding 0 and, in most, uniform buffers of a vec2 at bindings 1 and 2, one dispatch and a
comparison of a few words of the storage buffer. What the host needs rides along as `spec` for src/vkt/tests/graphicsfuzz/compute_tests.rs.

    python3 hodow_cts/scripts/gen_graphicsfuzz_compute_manifest.py [--cts-dir ../tmp/VK-GL-CTS]

A pure text generator: no spirv-as and no cargo.
"""

import argparse
import json
import struct
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import gen_graphicsfuzz_manifest as graphics  # noqa: E402

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "graphicsfuzz_compute.toml"
AMBER_DIR = graphics.AMBER_DIR
NAMES = [
    "barrier-in-loop-with-break",
    "dead-barriers-in-loops",
    "unreachable-barrier-in-loops",
    "loops-breaks-returns",
    "two-for-loops-with-barrier-function",
]
Skip = graphics.Skip


def scalar_bytes(kind, text):
    if kind == "float":
        return struct.pack("<f", float(text))
    return struct.pack("<I", int(text, 0) & 0xFFFFFFFF)


class Script:
    def __init__(self):
        self.source = ""
        self.env = None
        self.groups = None
        self.uniforms = {}
        self.ssbo = {}
        self.probes = []

    def put(self, target, binding, offset, data):
        buffer = target.setdefault(binding, bytearray())
        buffer.extend(b"\0" * max(0, offset + len(data) - len(buffer)))
        buffer[offset : offset + len(data)] = data


def parse_vkscript(lines):
    script = Script()
    section = None
    for line in lines:
        text = line.strip()
        if text.startswith("[") and text.endswith("]"):
            section = text
            continue
        if section == "[compute shader spirv]":
            script.source += line + "\n"
            continue
        if section != "[test]" or not text or text.startswith("#"):
            continue
        words = text.split()
        if words[:2] == ["uniform", "ubo"] and words[3] == "vec2":
            set_binding = words[2].split(":")
            if set_binding[0] != "0":
                raise Skip("descriptor set")
            script.put(script.uniforms, int(set_binding[1]), int(words[4]), b"".join(scalar_bytes("float", value) for value in words[5:]))
        elif words[0] == "ssbo" and words[2] == "subdata" and words[3] == "int":
            script.put(script.ssbo, int(words[1]), int(words[4]), b"".join(scalar_bytes("int", value) for value in words[5:]))
        elif words[0] == "compute" and len(words) == 4:
            script.groups = tuple(int(value) for value in words[1:])
        elif words[:3] == ["probe", "ssbo", "int"] and words[5] == "==":
            script.probes.append((int(words[3]), int(words[4]), scalar_bytes("int", words[6])))
        else:
            raise Skip("test statement " + " ".join(words[:3]))
    return script


def parse_amber(lines):
    script = Script()
    buffers, kinds, binds = {}, {}, {}
    index = 0
    while index < len(lines):
        words = lines[index].split()
        index += 1
        if not words or words[0].startswith("#"):
            continue
        if words[0] == "SHADER" and words[1] == "compute":
            script.env = words[words.index("TARGET_ENV") + 1] if "TARGET_ENV" in words else None
            while lines[index].strip() != "END":
                script.source += lines[index] + "\n"
                index += 1
            index += 1
        elif words[0] == "BUFFER" and words[2] == "DATA_TYPE":
            values = []
            while True:
                data_line = lines[index].split("#")[0].strip()
                index += 1
                if data_line == "END":
                    break
                values += data_line.split()
            if "DATA" in words and words[-1] != "DATA":
                values = words[words.index("DATA") + 1 :] + values
            kind = words[3]
            buffers[words[1]] = graphics.pack_buffer(kind, False, values)
            kinds[words[1]] = "float" if "float" in kind else "int"
        elif words[0] == "PIPELINE":
            if words[1] != "compute":
                raise Skip("pipeline " + words[1])
            while lines[index].strip() != "END":
                step = lines[index].split()
                index += 1
                if step[:2] == ["BIND", "BUFFER"] and step[3] == "AS" and step[4] in ("storage", "uniform") and step[5:8] == ["DESCRIPTOR_SET", "0", "BINDING"]:
                    binds[step[2]] = (int(step[8]), step[4])
            index += 1
        elif words[0] == "RUN" and len(words) == 5:
            script.groups = tuple(int(value) for value in words[2:])
        elif words[0] == "EXPECT" and words[2] == "IDX" and words[4] == "EQ" and len(words) == 6:
            binding = binds[words[1]][0]
            script.probes.append((binding, int(words[3]), scalar_bytes(kinds[words[1]], words[5])))
        else:
            raise Skip("statement " + words[0])
    for name, (binding, kind) in binds.items():
        (script.uniforms if kind == "uniform" else script.ssbo)[binding] = bytearray(buffers[name])
    return script


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cts-dir", default=str(CRATE.parent / "tmp" / "VK-GL-CTS"))
    root = Path(parser.parse_args().cts_dir)
    out = [
        "# Shader manifest for the compute scripts of dEQP-VK.graphicsfuzz.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_graphicsfuzz_compute_manifest.py - do not hand-edit.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/amber/vktAmberGraphicsFuzzTests.cpp"\nrust_module = "graphicsfuzz/compute_tests"\n'
    ]
    for name in NAMES:
        lines = (root / AMBER_DIR / f"{name}.amber").read_text(encoding="utf-8", errors="replace").splitlines()
        script = parse_vkscript(lines) if any(line.strip() == "[compute shader spirv]" for line in lines) else parse_amber(lines)
        if set(script.ssbo) != {0} or script.groups is None or not script.probes:
            raise Skip(name)
        ssbo = bytes(script.ssbo[0])
        uniforms = ",".join(f"{binding}:{bytes(data).ljust(16, bytes(1)).hex()}" for binding, data in sorted(script.uniforms.items()))
        probes = ",".join(f"{offset}:{value.hex()}" for binding, offset, value in script.probes if binding == 0)
        if len(probes.split(",")) != len(script.probes):
            raise Skip("probe of another buffer " + name)
        spec = f"groups={','.join(map(str, script.groups))};ssbo={ssbo.hex()};ubo={uniforms};expect={probes}"
        version = f', spirv_version = "spirv{script.env.removeprefix("spv")}"' if script.env else ""
        const = "GFZC_" + "".join(c if c.isalnum() else "_" for c in name).upper()
        out.append(
            f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "GraphicsFuzzComputeCase"\n'
            f'programs = [ {{ name = "compute", template = "spirv_assembly/source.asm", stage = "asm"{version} }} ]\n'
            f'params = {{ spec = {{ type = "str", value = {json.dumps(spec)} }} }}\n'
            f"derived = {{ source = {json.dumps(repr(script.source), ensure_ascii=False)} }}\n"
        )
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {len(NAMES)} cases")


if __name__ == "__main__":
    main()
