#!/usr/bin/env python3
"""Writes shaders/manifest/graphicsfuzz.toml: the Amber scripts of dEQP-VK.graphicsfuzz.* that this port can run.

Nearly every script of data/vulkan/amber/graphicsfuzz is one shape: a passthrough vertex shader, a fragment shader (SPIR-V assembly or GLSL), a
few uniform buffers, one full-framebuffer `DRAW_RECT` into a B8G8R8A8_UNORM image and an `EXPECT` of one colour over a rectangle. This reads exactly
that subset and turns each script into a manifest case that src/vkt/tests/graphicsfuzz/amber_tests.rs draws and probes. A script that uses anything else
(push constants, samplers, a device property, a second pipeline that is not drawn the same way) is skipped and listed on stderr, so a
missing script never reads as a passing one.

    python3 hodow_cts/scripts/gen_graphicsfuzz_manifest.py [--cts-dir ../tmp/VK-GL-CTS]

The case names and their order are those of upstream's mustpass list when it is present in the checkout. A pure text generator: no glslang and no cargo.
"""

import argparse
import json
import re
import struct
import sys
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "graphicsfuzz.toml"
AMBER_DIR = "external/vulkancts/data/vulkan/amber/graphicsfuzz"
MUSTPASS = "external/vulkancts/mustpass/main/vk-default/graphicsfuzz.txt"

PASSTHROUGH_VERTEX = (
    "#version 450\n"
    "void main() {\n"
    "    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));\n"
    "    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);\n"
    "}\n"
)

TEXGEN_FRAGMENT = (
    "#version 430\n"
    "precision highp float;\n"
    "layout(location = 0) out vec4 _GLF_color;\n"
    "void main()\n"
    "{\n"
    " _GLF_color = vec4(\n"
    " floor(gl_FragCoord.x) * (1.0 / 255.0),\n"
    " (int(gl_FragCoord.x) ^ int(gl_FragCoord.y)) * (1.0 / 255.0),\n"
    " floor(gl_FragCoord.y) * (1.0 / 255.0),\n"
    " 1.0);\n"
    "}\n"
)
TEXTURE = "default_texture"


def non_blank(text):
    return [line for line in text.splitlines() if line.strip()]

KNOWN_PROPERTIES = {"FloatControlsProperties.shaderSignedZeroInfNanPreserveFloat32"}
SCALARS = {"int32": "<i", "uint32": "<I", "float": "<f"}


class Skip(Exception):
    pass


def pack_scalar(kind, text):
    code = SCALARS[kind]
    try:
        if kind == "float":
            return struct.pack(code, float(text))
        return struct.pack("<I", int(text, 0) & 0xFFFFFFFF)
    except (ValueError, struct.error):
        raise Skip(f"value {text}")


def pack_buffer(data_type, std140, values):
    """The bytes Amber builds for a `DATA_TYPE` buffer: `T[]` in std140 puts every element on a 16 byte stride, a lone vector or scalar is tight."""
    is_array = data_type.endswith("[]")
    base = data_type[:-2] if is_array else data_type
    match = re.fullmatch(r"vec(\d)<(\w+)>", base)
    components, kind = (int(match.group(1)), match.group(2)) if match else (1, base)
    matrix = re.fullmatch(r"mat4x4<(\w+)>", base)
    if matrix:
        # Four columns of a vec4, which is 64 bytes in std140 and tight alike.
        components, kind, match = 16, matrix.group(1), None
    if kind not in SCALARS:
        raise Skip("data type " + data_type)
    if len(values) % components:
        raise Skip("data of another shape")
    elements = [values[index : index + components] for index in range(0, len(values), components)]
    stride_16 = std140 and (is_array or (match and len(elements) > 1))
    out = b""
    for element in elements:
        item = b"".join(pack_scalar(kind, value) for value in element)
        out += item.ljust(16, b"\0") if stride_16 else item
    return out


def parse_script(path):
    lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    shaders, buffers, framebuffers = {}, {}, set()
    pipelines, statements = {}, []
    extensions = []
    samplers = set()
    index = 0
    while index < len(lines):
        text = lines[index].strip()
        index += 1
        if not text or text.startswith("#"):
            continue
        words = text.split()
        if words[0] == "SHADER":
            if words[3] == "PASSTHROUGH":
                shaders[words[2]] = (words[1], "PASSTHROUGH", None, None)
                continue
            if words[3] not in ("SPIRV-ASM", "GLSL"):
                raise Skip("shader language " + words[3])
            env = words[words.index("TARGET_ENV") + 1] if "TARGET_ENV" in words else None
            body = []
            while lines[index].strip() != "END":
                body.append(lines[index])
                index += 1
            index += 1
            shaders[words[2]] = (words[1], words[3], env, "\n".join(body) + "\n")
        elif words[0] == "BUFFER":
            if words[2] == "FORMAT":
                if words[3] != "B8G8R8A8_UNORM":
                    raise Skip("framebuffer format " + words[3])
                framebuffers.add(words[1])
                continue
            if words[2] != "DATA_TYPE":
                raise Skip("buffer " + " ".join(words[2:4]))
            std140 = "STD140" in words
            if "DATA" not in words:
                raise Skip("buffer without DATA")
            values = []
            if words[-1] != "DATA":
                values += words[words.index("DATA") + 1 :]
            while True:
                data_line = lines[index].split("#")[0].strip()
                index += 1
                if data_line == "END":
                    break
                values += data_line.split()
            buffers[words[1]] = pack_buffer(words[3], std140, values)
        elif words[0] == "PIPELINE":
            if words[1] != "graphics":
                raise Skip("pipeline " + words[1])
            name = words[2]
            pipe = dict(attach=[], size=None, color=None, binds=[], push=None)
            while lines[index].strip() != "END":
                step = lines[index].split()
                index += 1
                if not step or step[0].startswith("#"):
                    continue
                if step[0] == "ATTACH" and len(step) == 2:
                    pipe["attach"].append(step[1])
                elif step[0] == "FRAMEBUFFER_SIZE" and len(step) == 3:
                    pipe["size"] = (int(step[1]), int(step[2]))
                elif step[:2] == ["BIND", "BUFFER"] and step[3:5] == ["AS", "color"] and step[5:7] == ["LOCATION", "0"]:
                    pipe["color"] = step[2]
                elif step[:2] == ["BIND", "BUFFER"] and step[3:] == ["AS", "push_constant"]:
                    pipe["push"] = step[2]
                elif step[:2] == ["BIND", "BUFFER", TEXTURE][:2] and step[2] == TEXTURE and step[3:5] == ["AS", "combined_image_sampler"] and step[5] == "SAMPLER" and step[6] in samplers and step[7:9] == ["DESCRIPTOR_SET", "0"] and step[9] == "BINDING":
                    pipe["binds"].append((int(step[10]), "texture", TEXTURE))
                elif step[:2] == ["BIND", "BUFFER"] and step[3] == "AS" and step[4] in ("uniform", "storage") and step[5] == "DESCRIPTOR_SET" and step[7] == "BINDING":
                    if step[6] != "0":
                        raise Skip("descriptor set " + step[6])
                    pipe["binds"].append((int(step[8]), step[4], step[2]))
                else:
                    raise Skip("pipeline statement " + " ".join(step[:5]))
            index += 1
            pipelines[name] = pipe
        elif words[0] == "SAMPLER" and len(words) == 2:
            samplers.add(words[1])
        elif words[0] == "DEVICE_EXTENSION":
            extensions.append(words[1])
        elif words[0] == "DEVICE_PROPERTY" and words[1] in KNOWN_PROPERTIES:
            extensions.append("PROP:" + words[1])
        elif words[0] in ("CLEAR_COLOR", "CLEAR", "RUN", "EXPECT"):
            statements.append(words)
        else:
            raise Skip("statement " + words[0])

    if "texgen_pipeline" in pipelines:
        texgen = pipelines.pop("texgen_pipeline")
        fragment = [shaders[name] for name in texgen["attach"] if shaders[name][0] == "fragment"]
        if len(fragment) != 1 or non_blank(fragment[0][3]) != non_blank(TEXGEN_FRAGMENT) or texgen["size"] != (256, 256) or texgen["color"] != TEXTURE:
            raise Skip("a texture generated by another shader")
        statements = [words for words in statements if words[1] != "texgen_pipeline"]
    if not pipelines:
        raise Skip("no graphics pipeline")
    for pipe_name, pipe in pipelines.items():
        if pipe["size"] is None or pipe["color"] not in framebuffers:
            raise Skip("no colour attachment")
        vertex = [name for name in pipe["attach"] if shaders[name][0] == "vertex"]
        fragment = [name for name in pipe["attach"] if shaders[name][0] == "fragment"]
        if len(vertex) != 1 or len(fragment) != 1 or shaders[vertex[0]][1] not in ("PASSTHROUGH", "SPIRV-ASM") or len(pipe["attach"]) != 2:
            raise Skip("shaders other than a passthrough or assembly vertex and a fragment shader")
        pipe["vertex"] = shaders[vertex[0]]
        pipe["fragment"] = shaders[fragment[0]]
        if len(pipelines) > 1 and pipe["fragment"][1] != "SPIRV-ASM":
            raise Skip("a GLSL fragment shader next to others")

    by_framebuffer = {pipe["color"]: index for index, pipe in enumerate(pipelines.values())}
    pipe_names = list(pipelines)
    clears, drawn, probes, histograms = {}, set(), [], []
    grids = {}
    for words in statements:
        if words[0] == "CLEAR_COLOR" and words[1] in pipelines and len(words) == 6:
            clears[words[1]] = tuple(int(value) for value in words[2:6])
        elif words[0] == "CLEAR" and words[1] in pipelines:
            continue
        elif words[0] == "RUN" and words[1] in pipelines and words[2] == "DRAW_RECT" and words[3] == "POS" and words[4:6] == ["0", "0"] and words[6] == "SIZE":
            if (int(words[7]), int(words[8])) != pipelines[words[1]]["size"] or words[1] in drawn:
                raise Skip("a rectangle other than the framebuffer")
            drawn.add(words[1])
        elif words[0] == "RUN" and words[1] in pipelines and words[2] == "DRAW_GRID" and words[3:7] == ["POS", "0", "0", "SIZE"] and len(words) == 12 and words[9] == "CELLS":
            if (int(words[7]), int(words[8])) != pipelines[words[1]]["size"] or words[1] in drawn:
                raise Skip("a grid other than the framebuffer")
            grids[words[1]] = (int(words[10]), int(words[11]))
            drawn.add(words[1])
        elif words[0] == "EXPECT" and words[1] in by_framebuffer and words[2] == "IDX" and words[5] == "SIZE" and words[8] in ("EQ_RGBA", "EQ_RGB"):
            x, y, w, h = int(words[3]), int(words[4]), int(words[6]), int(words[7])
            channels = [int(value) for value in words[9:]]
            if len(channels) != (4 if words[8] == "EQ_RGBA" else 3):
                raise Skip("probe colour")
            probes.append((by_framebuffer[words[1]], x, y, w, h, *channels, 1 if words[8] == "EQ_RGBA" else 0))
        elif words[0] == "EXPECT" and len(words) == 6 and words[2] == "EQ_HISTOGRAM_EMD_BUFFER" and words[4] == "TOLERANCE" and words[1] in by_framebuffer and words[3] in by_framebuffer:
            histograms.append((by_framebuffer[words[1]], by_framebuffer[words[3]], words[5]))
        else:
            raise Skip("statement " + " ".join(words[:3]))
    if set(clears) != set(pipelines) or drawn != set(pipelines) or not (probes or histograms):
        raise Skip("not a clear, a draw and a probe for every pipeline")

    passes = []
    for pipe_name in pipe_names:
        pipe = pipelines[pipe_name]
        if (pipe["vertex"][1] == "SPIRV-ASM") != (pipe_name in grids):
            raise Skip("an assembly vertex shader without a grid, or the other way round")
        bindings = []
        seen = set()
        for binding, kind, name in sorted(pipe["binds"]):
            if kind == "texture" and binding not in seen:
                seen.add(binding)
                bindings.append((binding, kind, b""))
                continue
            if binding in seen or name not in buffers:
                raise Skip("binding of an unknown or a repeated buffer")
            seen.add(binding)
            bindings.append((binding, kind, buffers[name]))
        language, env, source = pipe["fragment"][1:]
        if pipe["push"] is not None and pipe["push"] not in buffers:
            raise Skip("push constants of an unknown buffer")
        push = buffers[pipe["push"]] if pipe["push"] is not None else b""
        passes.append(dict(width=pipe["size"][0], height=pipe["size"][1], clear=clears[pipe_name], bindings=bindings, push=push, language=language, env=env, source=source,
                           grid=grids.get(pipe_name), vertex=pipe["vertex"]))

    return dict(passes=passes, probes=probes, histograms=histograms, extensions=extensions)


def toml_string(text):
    return json.dumps(text, ensure_ascii=False)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cts-dir", default=str(CRATE.parent / "tmp" / "VK-GL-CTS"))
    args = parser.parse_args()
    root = Path(args.cts_dir)

    mustpass = root / MUSTPASS
    if mustpass.exists():
        names = [line.strip().removeprefix("dEQP-VK.graphicsfuzz.") for line in mustpass.read_text().splitlines() if line.strip()]
    else:
        names = sorted(path.stem for path in (root / AMBER_DIR).glob("*.amber"))

    out = [
        "# Shader manifest for dEQP-VK.graphicsfuzz.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_graphicsfuzz_manifest.py - do not hand-edit; see the script for the subset of Amber it reads.\n\n"
        'upstream_source = "external/vulkancts/modules/vulkan/amber/vktAmberGraphicsFuzzTests.cpp"\n'
        'rust_module = "graphicsfuzz/amber_tests"\n'
    ]
    written = 0
    for name in names:
        path = root / AMBER_DIR / f"{name}.amber"
        try:
            case = parse_script(path)
        except (Skip, IndexError, KeyError) as reason:
            print(f"skipped {name}: {reason!r}", file=sys.stderr)
            continue

        const = "GFZ_" + "".join(c if c.isalnum() else "_" for c in name).upper()
        programs = ['{ name = "vert", template = "glsl/source.vert", stage = "vert" }']
        derived = [f"source_vert = {json.dumps(repr(PASSTHROUGH_VERTEX))}"]
        pass_specs = []
        for number, one in enumerate(case["passes"]):
            version = f', spirv_version = "spirv{one["env"].removeprefix("spv")}"' if one["env"] else ""
            program_name = "frag" if number == 0 else f"frag_{number}"
            if one["language"] == "GLSL":
                programs.append(f'{{ name = "{program_name}", template = "glsl/source.frag", stage = "frag" }}')
                derived.append(f"source_frag = {json.dumps(repr(one['source']), ensure_ascii=False)}")
            else:
                template = "spirv_assembly/source.asm" if number == 0 else f"spirv_assembly/source_{number}.asm"
                key = "source" if number == 0 else f"source_{number}"
                programs.append(f'{{ name = "{program_name}", template = "{template}", stage = "asm"{version} }}')
                derived.append(f"{key} = {json.dumps(repr(one['source']), ensure_ascii=False)}")
            if one["grid"] is not None:
                vertex_env = one["vertex"][2]
                vertex_version = f', spirv_version = "spirv{vertex_env.removeprefix("spv")}"' if vertex_env else ""
                if number > 1:
                    raise Skip("more than two pipelines with a grid")
                programs.append(f'{{ name = "vert_{number}", template = "spirv_assembly/source_v{number}.asm", stage = "asm"{vertex_version} }}')
                derived.append(f"source_v{number} = {json.dumps(repr(one['vertex'][3]), ensure_ascii=False)}")
            buffers = ";".join(f"{binding}:{ {'uniform': 'u', 'storage': 's', 'texture': 't'}[kind] }:{data.hex()}" for binding, kind, data in one["bindings"])
            pass_specs.append(f"{one['width']},{one['height']},{','.join(str(value) for value in one['clear'])}/{buffers}/{one['push'].hex()}{'' if one['grid'] is None else f"/{one['grid'][0]}x{one['grid'][1]}"}")
        expects = ";".join(",".join(str(value) for value in probe) for probe in case["probes"])
        histograms = ";".join(",".join(str(value) for value in histogram) for histogram in case["histograms"])
        features = ",".join(case["extensions"])
        params = (
            f'passes = {{ type = "str", value = {toml_string("|".join(pass_specs))} }}, '
            f'expects = {{ type = "str", value = {toml_string(expects)} }}, histograms = {{ type = "str", value = {toml_string(histograms)} }}, '
            f'features = {{ type = "str", value = {toml_string(features)} }}'
        )
        out.append(
            f'\n[[case]]\nname = {toml_string(name)}\nrust_const = "{const}"\nrust_type = "GraphicsFuzzCase"\n'
            f"programs = [ {', '.join(programs)} ]\n"
            f"params = {{ {params} }}\n"
            f"derived = {{ {', '.join(derived)} }}\n"
        )
        written += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {written} of {len(names)} cases")


if __name__ == "__main__":
    main()
