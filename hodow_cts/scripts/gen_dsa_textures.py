#!/usr/bin/env python3
"""Generates hodow_cts/src/khr_gl/direct_state_access_textures_tests.rs from the upstream C++ and `scripts/data/dsa_textures_template.rs.in`.

Reads the reference tables and internal formats of `Reference` and the `addChild` lines of the templated Textures cases from gl4cDirectStateAccessTexturesTests.cpp / gl4cDirectStateAccessTests.cpp.

Usage: gen_dsa_textures.py <glcts modules/gl dir> <template> <output>
"""
import re
import sys

gl_dir, template_path, out_path = sys.argv[1:4]
tex = open(f"{gl_dir}/gl4cDirectStateAccessTexturesTests.cpp").read()
init = open(f"{gl_dir}/gl4cDirectStateAccessTests.cpp").read()

RUST = {"GLbyte": "i8", "GLubyte": "u8", "GLshort": "i16", "GLushort": "u16", "GLint": "i32", "GLuint": "u32", "GLfloat": "f32"}

tables = {}
for m in re.finditer(r"const glw::(\w+) \*Reference::ReferenceData<glw::(\w+), (true|false)>\(\)\s*\{\s*static const [^=]*= \{(.*?)\};", tex, re.S):
    rust = RUST[m.group(2)]
    norm = m.group(3) == "true"
    values = [v.strip() for v in m.group(4).replace("\n", " ").split(",") if v.strip()]
    if rust == "f32":
        values = [re.sub(r"f$", "", v) for v in values]
        values = [v if "." in v else v + ".0" for v in values]
        values = [v + "0" if v.endswith(".") else v for v in values]
    assert len(values) == 96, (rust, norm, len(values))
    tables[(rust, norm)] = values

formats = {}
for m in re.finditer(r"Reference::InternalFormat<glw::(\w+), (\d), (true|false)>\(\)\s*\{\s*return (GL_\w+);", tex):
    formats[(RUST[m.group(1)], int(m.group(2)), m.group(3) == "true")] = m.group(4)

def table_name(rust, norm):
    return f"REF_{rust.upper()}" + ("_NORM" if norm else "")

out = []
for (rust, norm), values in sorted(tables.items()):
    name = table_name(rust, norm)
    out.append(f"#[allow(clippy::excessive_precision, clippy::approx_constant)]\nstatic {name}: [{rust}; REFERENCE_COUNT] = [")
    for i in range(0, 96, 12):
        out.append("    " + ", ".join(values[i:i + 12]) + ",")
    out.append("];\n")

for rust in ["i8", "u8", "i16", "u16", "i32", "u32", "f32"]:
    has_plain = (rust, False) in tables
    has_norm = (rust, True) in tables
    if has_plain and has_norm:
        reference = f"if norm {{ &{table_name(rust, True)} }} else {{ &{table_name(rust, False)} }}"
    else:
        reference = f"&{table_name(rust, has_norm)}"
    if rust in ("i8", "i16", "i32"):
        prefix = '"i"'
    elif rust == "u32":
        prefix = '"u"'
    elif rust == "f32":
        prefix = '""'
    else:
        prefix = 'if norm { "" } else { "u" }'
    arms = []
    for (r, s, n), const in sorted(formats.items()):
        if r == rust:
            arms.append(f"            ({s}, {'true' if n else 'false'}) => glw::{const},")
    gl_type = {"i8": "GL_BYTE", "u8": "GL_UNSIGNED_BYTE", "i16": "GL_SHORT", "u16": "GL_UNSIGNED_SHORT", "i32": "GL_INT", "u32": "GL_UNSIGNED_INT", "f32": "GL_FLOAT"}[rust]
    same = "(self - other).abs() < 1.0 / 256.0" if rust == "f32" else "self == other"
    out.append(f"""impl Scalar for {rust} {{
    const TYPE: glw::GLenum = glw::{gl_type};

    fn sampler_prefix({"norm" if "norm" in prefix else "_norm"}: bool) -> &'static str {{
        {prefix}
    }}

    fn reference({"norm" if "norm" in reference else "_norm"}: bool) -> &'static [Self; REFERENCE_COUNT] {{
        {reference}
    }}

    fn internal_format(s: usize, norm: bool) -> glw::GLenum {{
        match (s, norm) {{
{chr(10).join(arms)}
            _ => unreachable!("no internal format for this size"),
        }}
    }}

    fn same(self, other: Self) -> bool {{
        {same}
    }}
}}
""")

body = init[init.index("Textures::CreationTest"):]
body = body[:body.index("\n}\n")]
regs = []
pattern = re.compile(r'addChild\(\s*new Textures::(BufferTest|StorageAndSubImageTest|StorageMultisampleTest)<glw::(\w+),\s*(\d),\s*(true|false)(?:,\s*(\d))?(?:,\s*(true|false))?>\(\s*m_context,\s*"(\w+)"\)\)', re.S)
count = 0
for m in pattern.finditer(body):
    kind, t, s, n, d, i, name = m.groups()
    args = f"{RUST[t]}, {s}, {n}"
    if d:
        args += f", {d}"
    if i:
        args += f", {i}"
    regs.append(f'    group.add_child(Box::new({kind}::<{args}>::new("{name}")) as Box<dyn TestCase>);\n')
    count += 1

src = open(template_path).read()
src = src.replace("@SCALARS@", "\n".join(out)).replace("@REGISTRATIONS@", "".join(regs)).replace("@COUNT@", str(count))
open(out_path, "w").write(src)
print(count, "registrations")
