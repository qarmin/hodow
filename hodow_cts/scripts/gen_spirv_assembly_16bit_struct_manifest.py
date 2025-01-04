#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_16bit_struct.toml: the four cases of `uniform_16struct_to_32struct` and `uniform_32struct_to_16struct` of
dEQP-VK.spirv_assembly.instruction.compute.16bit_storage (vktSpvAsm16bitStorageTests.cpp), two capabilities each.

The assembly is read out of the C++ string literals - the group's `shaderTemplate` and the `getStructShaderComponet` strides of the layouts - and specialized
with the capability, the storage class and the layouts the group function picks for it, so it is exactly what the test assembles. The host side is
src/vkt/tests/spirv_assembly/struct16_tests.rs.

    python3 hodow_cts/scripts/gen_spirv_assembly_16bit_struct_manifest.py [--cts-dir tmp/VK-GL-CTS]

A pure text generator: no spirv-as and no cargo.
"""

import argparse
import json
import re
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_16bit_struct.toml"
SOURCE8 = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsm8bitStorageTests.cpp"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsm16bitStorageTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"
CAPABILITIES = [("uniform_buffer_block", "StorageUniformBufferBlock16", "BufferBlock"), ("uniform", "StorageUniform16", "Block")]


def literals(text):
    return "".join(bytes(literal, "utf-8").decode("unicode_escape") for literal in re.findall(r'"((?:[^"\\]|\\.)*)"', re.sub(r"//[^\n]*", "", text)))


def function_text(source, name):
    start = source.index(f"void {name}(")
    return source[start : source.index("\n}\n", start)]


def template_of(function):
    start = function.index("shaderTemplate(") + len("shaderTemplate(")
    return literals(function[start : function.index(");\n", start)])


def component(source, label):
    start = source.index(f"case SHADERTEMPLATE_{label}:", source.index("string getStructShaderComponet("))
    end = source.index("    case SHADERTEMPLATE_", start + 10)
    return literals(source[start:end])


def loop_template(source, name):
    start = source.index(f"const tcu::StringTemplate {name}(")
    return literals(source[start + len(f"const tcu::StringTemplate {name}(") : source.index(");\n", start)])


def mix_component(source, label):
    start = source.index(f"case SHADERTEMPLATE_{label}:", source.index("string getStructShaderComponet("))
    ends = [source.index(marker, start + 10) for marker in ("    case SHADERTEMPLATE_", "    default:") if marker in source[start + 10 :]]
    return literals(source[start : min(ends)])


def mixed_cases(source):
    """addCompute16bitStructMixedTypesGroup (struct_mixed_types): an array of structs of mixed 16 and 32 bit members copied from the input to the output, one case per capability."""
    template = template_of(function_text(source, "addCompute16bitStructMixedTypesGroup"))
    loop_begin = loop_template(source, "loopBegin").replace("${loopName}", "z").replace("${exeCount}", "c_i32_11")
    loop_end = loop_template(source, "loopEnd").replace("${loopName}", "z")
    cases = []
    for index, (name, capability, storage) in enumerate(CAPABILITIES):
        uniform = index == 1
        values = {
            "capability": f"OpCapability {capability}" if uniform else " ", "inPtr": "outPtr", "storage": "Block" if uniform else "BufferBlock", "zBeginLoop": loop_begin, "zEndLoop": loop_end,
            "InOffsets": mix_component(source, "STRIDEMIX_STD140" if uniform else "STRIDEMIX_STD430").replace("${InOut}", "In"),
            "OutOffsets": mix_component(source, "STRIDEMIX_STD430").replace("${InOut}", "Out"),
        }
        assembly = template
        for key, value in values.items():
            assembly = assembly.replace("${" + key + "}", value)
        assert "${" not in assembly, name
        cases.append((name, f"group=mix;cap={index}", assembly))
    return cases


def specialized(template, values):
    for key, value in values.items():
        template = template.replace("${" + key + "}", value)
    assert "${" not in template, template[template.index("${") : template.index("${") + 40]
    return template


def storage8_cases(source8):
    """addCompute8bitStorageUniform8StructTo32StructGroup, addCompute8bitStorageUniform32StructTo8StructGroup and addCompute8bitStorage8bitStructMixedTypesGroup: the struct cases
    of compute.8bit_storage, assembly composed from the C++ templates and layouts."""
    cases = []
    template = template_of(function_text(source8, "addCompute8bitStorageUniform8StructTo32StructGroup"))
    values = {
        "capability": "UniformAndStorageBuffer8BitAccess", "stridei8": mix_component(source8, "STRIDE8BIT_STD140"), "stridei32": mix_component(source8, "STRIDE32BIT_STD430"),
        "32Storage": "StorageBuffer", "8Storage": "Uniform",
    }
    cases.append(("uniform_8struct_to_32struct", "uniform", "group=8to32c;cap=1", specialized(template, values)))
    template = template_of(function_text(source8, "addCompute8bitStorageUniform32StructTo8StructGroup"))
    values = {
        "capability": "StorageBuffer8BitAccess", "stridei8": mix_component(source8, "STRIDE8BIT_STD430"), "stridei32": mix_component(source8, "STRIDE32BIT_STD140"),
        "8Storage": "StorageBuffer", "32Storage": "Uniform",
    }
    cases.append(("storagebuffer_32struct_to_8struct", "storage_buffer", "group=32to8c;cap=0", specialized(template, values)))

    function = function_text(source8, "addCompute8bitStorage8bitStructMixedTypesGroup")
    template = template_of(function)
    loop_begin = loop_template(source8, "loopBegin").replace("${loopName}", "z").replace("${exeCount}", "c_i32_11")
    loop_end = loop_template(source8, "loopEnd").replace("${loopName}", "z")
    pointer_types = literals(function[function.index('specs["uniformPtr"]') : function.index('specs["inPtr"]')].split("?", 1)[1].split(":", 1)[0])
    for index, (name, capability) in enumerate((("storage_buffer", "StorageBuffer8BitAccess"), ("uniform", "UniformAndStorageBuffer8BitAccess"))):
        uniform = index == 1
        values = {
            "zBeginLoop": loop_begin, "zEndLoop": loop_end, "inStorage": "Uniform" if uniform else "StorageBuffer", "capability": f"OpCapability {capability}" if uniform else "",
            "uniformPtr": pointer_types if uniform else "", "inPtr": "inPtr" if uniform else "outPtr",
            "InOffsets": mix_component(source8, "STRIDEMIX_STD140" if uniform else "STRIDEMIX_STD430").replace("${InOut}", "In"),
            "OutOffsets": mix_component(source8, "STRIDEMIX_STD430").replace("${InOut}", "Out"),
        }
        cases.append(("struct_mixed_types", name, f"group=mix8;cap={index}", specialized(template, values)))
    return cases


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cts-dir", default=str(CRATE.parent / "tmp" / "VK-GL-CTS"))
    parser_args = parser.parse_args()
    source = (Path(parser_args.cts_dir) / SOURCE).read_text()
    types = component(source, "TYPES")
    templates = {
        "uniform_16struct_to_32struct": template_of(function_text(source, "addCompute16bitStorageUniform16StructTo32StructGroup")),
        "uniform_32struct_to_16struct": template_of(function_text(source, "addCompute16bitStorageUniform32StructTo16StructGroup")),
    }
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.16bit_storage.uniform_{16struct_to_32struct,32struct_to_16struct}.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_16bit_struct_manifest.py - do not hand-edit.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/struct16_tests"\n'
    ]
    count = 0
    for group, template in templates.items():
        narrow_first = group.startswith("uniform_16")
        for index, (name, capability, storage) in enumerate(CAPABILITIES):
            std430 = index == 0
            wide_in = component(source, "STRIDE32BIT_STD430" if std430 else "STRIDE32BIT_STD140")
            narrow_in = component(source, "STRIDE16BIT_STD430" if std430 else "STRIDE16BIT_STD140")
            if narrow_first:
                values = {"strideF16": narrow_in, "strideF32": component(source, "STRIDE32BIT_STD430")}
            else:
                values = {"strideF16": component(source, "STRIDE16BIT_STD430"), "strideF32": wide_in}
            values.update({"capability": capability, "storage": storage, "types": types})
            assembly = template
            for key, value in values.items():
                assembly = assembly.replace("${" + key + "}", value)
            assert "${" not in assembly, group
            spec = f"group={'16to32' if narrow_first else '32to16'};cap={index}"
            case = f"16bit_storage/{group}/{name}"
            out.append(
                f'\n[[case]]\nname = "{case}"\nrust_const = "S16S_{group.upper()}_{name.upper()}"\nrust_type = "Struct16Case"\n'
                f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm" }} ]\n'
                f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
                f"derived = {{ source = {json.dumps(repr(assembly))} }}\n"
            )
            count += 1
    source8 = (Path(parser_args.cts_dir) / SOURCE8).read_text()
    extra = [("16bit_storage", "struct_mixed_types", name, spec, assembly) for name, spec, assembly in mixed_cases(source)]
    extra += [("8bit_storage", group, name, spec, assembly) for group, name, spec, assembly in storage8_cases(source8)]
    for api, group, name, spec, assembly in extra:
        out.append(
            f'\n[[case]]\nname = "{api}/{group}/{name}"\nrust_const = "S{api[:2].strip("b").upper()}S_{group.upper()}_{name.upper()}"\nrust_type = "Struct16Case"\n'
            f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm" }} ]\n'
            f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
            f"derived = {{ source = {json.dumps(repr(assembly))} }}\n"
        )
        count += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()
