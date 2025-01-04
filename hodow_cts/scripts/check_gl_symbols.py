#!/usr/bin/env python3
"""Text-only check of hodow_cts GL test files: every `gl.<fn>(` method and every `glw::GL_*` constant they use must exist in generated/glw.rs. Usage: check_gl_symbols.py <file.rs>..."""
import re, sys, pathlib

glw = pathlib.Path(__file__).resolve().parent.parent / "src/generated/glw.rs"
text = glw.read_text()
fns = set(re.findall(r"pub unsafe fn (\w+)\(", text))
consts = set(re.findall(r"pub const (\w+):", text))
bad = 0
for name in sys.argv[1:]:
    src = pathlib.Path(name).read_text()
    for m in sorted(set(re.findall(r"\bgl\.(\w+)\(", src))):
        if m not in fns:
            print(f"{name}: unknown gl fn {m}")
            bad += 1
    for m in sorted(set(re.findall(r"glw::(GL_\w+)", src))):
        if m not in consts:
            print(f"{name}: unknown constant {m}")
            bad += 1
print("symbols ok" if not bad else f"{bad} problems")
sys.exit(1 if bad else 0)
