#!/usr/bin/env python3
"""Writes src/vkt/tests/info/mandatory_features.rs from the generated vkMandatoryFeatures.inl of the pinned upstream.

`checkBasicMandatoryFeatures` chains every feature structure the device may report into a VkPhysicalDeviceFeatures2, queries it and pushes the name of every
mandatory feature that is false. The structures are byte buffers described by `api/feature_struct_list.rs` (found by their Vulkan name), so a structure that list
does not know cannot be chained: the generator prints those and the checks that read them are left out of the output.

The `if (...)` expressions of the checks are translated one to one: `ext(name)` is `isExtensionStructSupported`, `api(major, minor)` is `contextSupports`,
`f(var, member)` reads a member of a chained structure and `core.<member>` one of `coreFeatures.features`.

Run from hodow_cts/:  python3 scripts/gen_mandatory_features.py
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
INL = ROOT / "upstream/external/vulkancts/framework/vulkan/generated/vulkan/vkMandatoryFeatures.inl"
STRUCT_LIST = ROOT / "src/vkt/tests/api/feature_struct_list.rs"
OUT = ROOT / "src/vkt/tests/info/mandatory_features.rs"

known = set(re.findall(r'struct_name: "(\w+)"', STRUCT_LIST.read_text()))
text = INL.read_text()

decls = re.findall(
    r"vk::(VkPhysicalDevice\w+) (\w+) = initVulkanStructure\(\);\n\tif \((.*)\)\n\t\taddFeatures\(&\2\);",
    text,
)
var_type = {}
chain = []
missing = []
for type_name, var, cond in decls:
    var_type[var] = type_name
    if type_name not in known:
        missing.append(type_name)
        continue
    m = re.fullmatch(r'canUseFeaturesStruct\(deviceExtensions, usedApiVersion, ("[^"]*")(?:, ("[^"]*"))?\)', cond)
    if m:
        promoted = f"Some({m.group(2)})" if m.group(2) else "None"
        enable = f"can_use(context, {m.group(1)}, {promoted})"
    else:
        m = re.fullmatch(r"context\.contextSupports\(vk::ApiVersion\(0, (\d+), (\d+), 0\)\)", cond)
        assert m, cond
        enable = f"api({m.group(1)}, {m.group(2)})"
    chain.append((type_name, var, enable))

body = text[text.index("getPhysicalDeviceFeatures2(context.getPhysicalDevice(), &coreFeatures);") :]
body = body[body.index("\n") + 1 : body.rindex("\n}")]


def snake(name):
    name = re.sub(r"(.)([A-Z][a-z]+)", r"\1_\2", name)
    name = re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", name)
    return name.lower()


skipped_checks = 0


def translate(cond):
    cond = re.sub(r'isExtensionStructSupported\(deviceExtensions, RequiredExtension\(("[^"]*")\)\)', r"ext(\1)", cond)
    cond = re.sub(r"context\.contextSupports\(vk::ApiVersion\(0, (\d+), (\d+), 0\)\)", r"api(\1, \2)", cond)
    cond = re.sub(r"coreFeatures\.features\.(\w+) == VK_FALSE", lambda m: f"core.{snake(m.group(1))} == vk::FALSE", cond)
    cond = re.sub(r"\b(physicalDevice\w+)\.(\w+) == VK_FALSE", r'!f("\1", "\2")', cond)
    cond = re.sub(r"\b(physicalDevice\w+)\.(\w+)\b(?!\")", r'f("\1", "\2")', cond)
    return cond


def uses_unknown(cond):
    return any(var_type.get(v) not in known for v in re.findall(r"\b(physicalDevice\w+)\.", cond))


lines = [ln.rstrip() for ln in body.splitlines()]
out = []
i = 0
indent = 1


def peek(j):
    while j < len(lines) and not lines[j].strip():
        j += 1
    return j


while i < len(lines):
    line = lines[i].strip()
    i += 1
    if not line:
        continue
    if line.startswith("//"):
        out.append("    " * indent + line)
        continue
    if line.startswith("if ("):
        cond = line[len("if (") : -1].strip()
        j = peek(i)
        braced = lines[j].strip() == "{"
        if braced:
            i = j + 1
        # collect the block to know whether to drop it
        depth = 1 if braced else 0
        block = []
        if braced:
            while True:
                s = lines[i].strip()
                i += 1
                if s == "{":
                    depth += 1
                elif s == "}":
                    depth -= 1
                    if depth == 0:
                        break
                block.append(s)
        else:
            k = peek(i)
            block.append(lines[k].strip())
            i = k + 1
        if uses_unknown(cond) or any(uses_unknown(b) for b in block if b.startswith("if (")):
            skipped_checks += 1
            continue
        # re-run the translator over the block text recursively
        out.append("    " * indent + f"if {translate(cond)} {{")
        indent += 1
        sub = [b for b in block]
        k = 0
        while k < len(sub):
            s = sub[k]
            k += 1
            if not s or s.startswith("//"):
                continue
            m = re.fullmatch(r'failMesages\.push_back\(("[^"]*")\);', s)
            if m:
                out.append("    " * indent + f"fail_messages.push({m.group(1)}.to_string());")
                continue
            assert s.startswith("if ("), s
            inner = s[len("if (") : -1].strip()
            nxt = sub[k].strip()
            k += 1
            m = re.fullmatch(r'failMesages\.push_back\(("[^"]*")\);', nxt)
            assert m, nxt
            out.append("    " * indent + f"if {translate(inner)} {{")
            out.append("    " * (indent + 1) + f"fail_messages.push({m.group(1)}.to_string());")
            out.append("    " * indent + "}")
        indent -= 1
        out.append("    " * indent + "}")
        continue
    raise SystemExit(f"unexpected line: {line}")

chain_code = []
for type_name, var, enable in chain:
    chain_code.append(f'    if {enable} {{\n        structs.push(Queried::new("{var}", "{type_name}")?);\n    }}')

rs = f'''// @generated by hodow_cts/scripts/gen_mandatory_features.py from the generated vkMandatoryFeatures.inl - do not hand-edit.
//
// `checkBasicMandatoryFeatures`. {len(missing)} feature structures of the table are not in `api/feature_struct_list.rs` and are neither chained nor checked
// ({skipped_checks} checks left out).

#![allow(unused_parens, clippy::nonminimal_bool)]

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::TestError;
use crate::vkt::Context;
use crate::vkt::tests::api::feature_struct_list::{{FEATURE_STRUCTS, FeatureStruct}};

const HEADER_SIZE: usize = 16;

/// A chained feature structure as memory: `sType`, `pNext` and the VkBool32 members
struct Queried {{
    var: &'static str,
    spec: &'static FeatureStruct,
    words: Vec<u64>,
}}

impl Queried {{
    fn new(var: &'static str, struct_name: &str) -> Result<Self, TestError> {{
        let spec = FEATURE_STRUCTS
            .iter()
            .find(|s| s.struct_name == struct_name)
            .ok_or_else(|| TestError::InternalError(format!("{{struct_name}} is not in the feature structure list")))?;
        let mut words = vec![0u64; spec.size.div_ceil(8)];
        // SAFETY: the buffer is at least `size` bytes and 8-byte aligned; the first word holds sType.
        unsafe {{ std::ptr::write(words.as_mut_ptr().cast::<i32>(), spec.s_type) }};
        Ok(Self {{ var, spec, words }})
    }}

    fn get(&self, member: &str) -> bool {{
        // A member the structure list does not have is not held against the device
        let Some(index) = self.spec.fields.iter().position(|name| *name == member) else {{
            return true;
        }};
        // SAFETY: `index` is a member of the structure, which `words` has room for.
        unsafe {{ std::ptr::read(self.words.as_ptr().cast::<u8>().add(HEADER_SIZE + index * 4).cast::<u32>()) != 0 }}
    }}
}}

pub fn check_basic_mandatory_features(context: &Context<'_>, fail_messages: &mut Vec<String>) -> Result<(), TestError> {{
    if context.api_version() < (1, 1, 0) && !context.is_device_functionality_supported("VK_KHR_get_physical_device_properties2") {{
        return Err(TestError::NotSupported(
            "Extension VK_KHR_get_physical_device_properties2 is not present".to_string(),
        ));
    }}

    let api = |major: u32, minor: u32| context.api_version() >= (major, minor, 0);
    let device_extensions = context.get_device_extensions();
    let ext = |name: &str| device_extensions.iter().any(|extension| extension == name);
    let can_use = |context: &Context<'_>, name: &str, promoted_from: Option<&str>| {{
        context.is_device_functionality_supported(name) || promoted_from.is_some_and(ext)
    }};

    let mut structs: Vec<Queried> = Vec::new();
{chr(10).join(chain_code)}

    // Link the structures into one chain behind VkPhysicalDeviceFeatures2.
    let pointers: Vec<*mut u8> = structs.iter_mut().map(|s| s.words.as_mut_ptr().cast::<u8>()).collect();
    for (index, s) in structs.iter_mut().enumerate() {{
        let next = pointers.get(index + 1).copied().unwrap_or(std::ptr::null_mut());
        // SAFETY: pNext is the second pointer-sized word of the structure.
        unsafe {{ std::ptr::write(s.words.as_mut_ptr().add(1).cast::<*mut u8>(), next) }};
    }}
    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    features2.next = pointers.first().copied().unwrap_or(std::ptr::null_mut()).cast();
    unsafe {{
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    }};
    let core = features2.features;

    let f = |var: &str, member: &str| structs.iter().any(|s| s.var == var && s.get(member));

{chr(10).join(out)}

    Ok(())
}}
'''
OUT.write_text(rs)
print(f"{len(chain)} structures chained, {len(missing)} unknown ({', '.join(sorted(set(missing)))}), {skipped_checks} checks left out")
