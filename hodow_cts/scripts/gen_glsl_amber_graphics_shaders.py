#!/usr/bin/env python3
"""Writes the GLSL shaders of the graphics Amber scripts of dEQP-VK.glsl.{crash_test,logical_copy,combined_operations}
(`data/vulkan/amber/<group>/*.amber`) into shaders/src/glsl/amber and the manifest shaders/manifest/glsl_amber_graphics.toml.

Amber's PASSTHROUGH vertex shader is written out as `passthrough.vert`. Run with `--cts-dir tmp/VK-GL-CTS`."""
import argparse
import re
from pathlib import Path

SCRIPTS = [
    ("crash_test", "divbyzero_vert"),
    ("crash_test", "divbyzero_frag"),
    ("crash_test", "divbyzero_geom"),
    ("crash_test", "divbyzero_tesc"),
    ("crash_test", "divbyzero_tese"),
    ("logical_copy", "initialized_struct"),
    ("logical_copy", "undefined_memory"),
    ("combined_operations", "negintdivand"),
    ("combined_operations", "notxor"),
]
STAGES = {"vertex": ("vert", "vert"), "fragment": ("frag", "frag"), "geometry": ("geom", "geom"),
          "tessellation_control": ("tesc", "tesc"), "tessellation_evaluation": ("tese", "tese")}
PASSTHROUGH = "#version 430\nlayout(location = 0) in vec4 position;\n\nvoid main()\n{\n    gl_Position = position;\n}\n"
SHADER_RE = re.compile(r"^SHADER (\w+) (\w+) (GLSL|PASSTHROUGH)\s*$")


def parse(path):
    shaders = []
    lines = path.read_text().splitlines()
    i = 0
    while i < len(lines):
        match = SHADER_RE.match(lines[i])
        i += 1
        if not match:
            continue
        stage, _, kind = match.groups()
        if kind == "PASSTHROUGH":
            shaders.append((stage, PASSTHROUGH))
            continue
        body = []
        while lines[i].strip() != "END":
            body.append(lines[i])
            i += 1
        text = "\n".join(body).strip("\n") + "\n"
        shaders.append((stage, text if text.startswith("#version") else "#version 430\n" + text))
    return shaders


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cts-dir", default="tmp/VK-GL-CTS")
    args = parser.parse_args()
    root = Path(__file__).resolve().parent.parent
    amber = Path(args.cts_dir) / "external/vulkancts/data/vulkan/amber"
    src = root / "shaders/src/glsl/amber"
    src.mkdir(parents=True, exist_ok=True)
    programs = []
    for group, script in SCRIPTS:
        for stage, source in parse(amber / group / f"{script}.amber"):
            short, ext = STAGES[stage]
            name = f"{group}_{script}_{short}"
            (src / f"{name}.{ext}").write_text(source)
            programs.append(f'    {{ name = "{name}", template = "glsl/amber/{name}.{ext}", stage = "{short}" }},')
    manifest = (
        "# Shader manifest for the graphics Amber scripts of dEQP-VK.glsl.{crash_test,logical_copy,combined_operations}\n"
        "#\n# Written by scripts/gen_glsl_amber_graphics_shaders.py together with the sources it names; do not hand-edit either.\n\n"
        'upstream_source = "external/vulkancts/data/vulkan/amber/crash_test/divbyzero_vert.amber"\n'
        'rust_module = "glsl/amber_graphics_tests"\n\n[[case]]\nname = "scripts"\nrust_const = "GLSL_AMBER_GRAPHICS"\nrust_type = "SharedProgram"\n'
        "programs = [\n" + "\n".join(programs) + "\n]\n"
    )
    (root / "shaders/manifest/glsl_amber_graphics.toml").write_text(manifest)
    print(f"{len(programs)} programs")


if __name__ == "__main__":
    main()
