#!/usr/bin/env python3
"""Regenerates the SPIR-V blobs of KHR-GL4x.gl_spirv from hodow_cts/shaders/gl_spirv.

Upstream builds them at run time with glslang and SPIRV-Tools (glcSpirvUtils). Those are
developer tools here, never a runtime dependency, so the modules are produced once:
  *.{vert,tesc,tese,geom,frag}  glslangValidator -G (OpenGL SPIR-V, 1.0, the target upstream asks for)
  *.spvasm                      spirv-as --target-env opengl4.5, validated with spirv-val
  state_queries.vert            additionally round-tripped through spirv-dis with every OpName and
                                OpMemberName line dropped, as SpirvModulesStateQueriesTest does
Usage: python3 hodow_cts/scripts/gen_gl_spirv_blobs.py [--check]
"""
import subprocess
import sys
import tempfile
from pathlib import Path

DIR = Path(__file__).resolve().parent.parent / "shaders" / "gl_spirv"
STAGES = {".vert", ".tesc", ".tese", ".geom", ".frag"}
ENV = "opengl4.5"


def run(*args):
    subprocess.run([str(a) for a in args], check=True)


def build(source: Path, out: Path):
    if source.suffix == ".spvasm":
        run("spirv-as", "--target-env", ENV, source, "-o", out)
    else:
        run("glslangValidator", "-G", "--target-env", "spirv1.0", "-S", source.suffix[1:], source, "-o", out)
    if source.stem == "state_queries" and source.suffix == ".vert":
        text = subprocess.run(["spirv-dis", "--no-header", "--raw-id", out], check=True, capture_output=True, text=True).stdout
        kept = [line for line in text.split("\n") if "OpName" not in line and "OpMemberName" not in line]
        with tempfile.TemporaryDirectory() as tmp:
            asm = Path(tmp) / "stripped.spvasm"
            asm.write_text("\n".join(kept) + "\n")
            run("spirv-as", "--target-env", ENV, asm, "-o", out)
    run("spirv-val", "--target-env", ENV, out)


def main():
    check = "--check" in sys.argv
    for source in sorted(DIR.iterdir()):
        if source.suffix not in STAGES and source.suffix != ".spvasm":
            continue
        out = DIR / f"{source.stem}_{source.suffix[1:]}.spv"
        if check:
            with tempfile.TemporaryDirectory() as tmp:
                fresh = Path(tmp) / out.name
                build(source, fresh)
                if not out.exists() or out.read_bytes() != fresh.read_bytes():
                    print(f"stale: {out}", file=sys.stderr)
                    sys.exit(1)
        else:
            build(source, out)
            print(f"wrote {out.name}")


if __name__ == "__main__":
    main()
