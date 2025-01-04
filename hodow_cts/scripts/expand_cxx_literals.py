#!/usr/bin/env python3
"""Expands `@LIT(a-b)` and `@LITS(a-b)` markers in a template into Rust string literals taken from line ranges of a C++ file.

`@LIT(a-b)` is the concatenation of every string literal in lines a..b (the CTS `NL` macro is "\\n"), `@LITS(a-b)` is the same split at top-level commas into a comma-separated list of literals. Comments, `;`, braces and a leading `const char *const name[..] =` or `std::string name =` `return`, `if`, `Compile`, `Link`, parentheses and `!` are dropped. Any token that is neither a literal, `NL` nor punctuation is an error, so a range that contains code is noticed.

`@LITDECL(n)` / `@LITSDECL(n)` take the whole statement that starts on line n (up to its `;`).

`@FLT(a-b)` / `@FLTDECL(n)` give the contents of the first brace pair (an array initializer) as Rust numbers.

Usage: expand_cxx_literals.py <cxx file> <template> <output>
"""
import re
import sys


def tokens(text):
    i, n = 0, len(text)
    while i < n:
        c = text[i]
        if c.isspace():
            i += 1
        elif text.startswith("//", i):
            while i < n and text[i] != "\n":
                i += 1
        elif text.startswith("/*", i):
            i = text.index("*/", i) + 2
        elif c == '"':
            j = i + 1
            while text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            yield ("str", text[i + 1 : j])
            i = j + 1
        elif text.startswith("return ", i):
            i += 7
        elif c == ";":
            yield ("semi", ";")
            i += 1
        elif c in "{}()!":
            i += 1
        elif re.match(r"(if|Compile|Link)\b", text[i:]):
            i += re.match(r"(if|Compile|Link)\b", text[i:]).end()
        elif re.match(r"(?:static )?(?:const char \*(?:const )?|std::string )\w+(\[\w*\])?\s*=", text[i:]):
            i += re.match(r"(?:static )?(?:const char \*(?:const )?|std::string )\w+(\[\w*\])?\s*=", text[i:]).end()
        elif c == ",":
            yield ("comma", ",")
            i += 1
        elif text.startswith("NL", i) and not (i + 2 < n and (text[i + 2].isalnum() or text[i + 2] == "_")):
            yield ("str", "\\n")
            i += 2
        else:
            raise SystemExit(f"unexpected text {text[i:i+30]!r} in a literal range")


def rust(parts):
    return '"' + "".join(parts) + '"'


def expand(lines, a, b, many):
    text = "\n".join(lines[a - 1 : b])
    groups, current = [], []
    for kind, value in tokens(text):
        if kind == "semi":
            continue
        if kind == "comma":
            if not many:
                raise SystemExit(f"comma in single literal range {a}-{b}")
            groups.append(current)
            current = []
        else:
            current.append(value)
    groups.append(current)
    groups = [g for g in groups if g]
    return ", ".join(rust(g) for g in groups)


def decl_end(lines, a):
    """Last line of the statement that starts on line `a`: the first line whose text ends it with a `;` outside any literal."""
    for b in range(a, len(lines) + 1):
        if any(kind == "semi" for kind, _ in tokens("\n".join(lines[a - 1 : b]))):
            return b
    raise SystemExit(f"no statement end after line {a}")


def flt_end(lines, a):
    for b in range(a, len(lines) + 1):
        if lines[b - 1].rstrip().endswith("};"):
            return b
    raise SystemExit(f"no end of initializer after line {a}")


def expand_flt(lines, a, b):
    """The contents of the first brace pair in lines a..b as Rust numbers (`1.0f` becomes `1.0f32`)."""
    text = "\n".join(re.sub(r"//.*$", "", line) for line in lines[a - 1 : b])
    text = text[text.index("{") + 1 : text.rindex("}")]
    text = re.sub(r"(?<![\w.])(\d+\.?\d*(?:e-?\d+)?)f\b", r"\1f32", text)
    return re.sub(r"\s+", " ", text).strip().rstrip(",")


def main():
    cxx, template, output = sys.argv[1:4]
    lines = open(cxx, encoding="utf-8").read().split("\n")
    out = open(template, encoding="utf-8").read()

    def sub(m):
        return expand(lines, int(m.group(2)), int(m.group(3)), m.group(1) == "LITS")

    def sub_decl(m):
        a = int(m.group(2))
        return expand(lines, a, decl_end(lines, a), m.group(1) == "LITSDECL")

    out = re.sub(r"@FLT\((\d+)-(\d+)\)", lambda m: expand_flt(lines, int(m.group(1)), int(m.group(2))), out)
    out = re.sub(r"@FLTDECL\((\d+)\)", lambda m: expand_flt(lines, int(m.group(1)), flt_end(lines, int(m.group(1)))), out)
    out = re.sub(r"@(LITS?)\((\d+)-(\d+)\)", sub, out)
    out = re.sub(r"@(LITS?DECL)\((\d+)\)", sub_decl, out)
    open(output, "w", encoding="utf-8").write(out)


main()
