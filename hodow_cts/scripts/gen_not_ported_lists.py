#!/usr/bin/env python3
"""Writes the case name lists of the groups registered by name only (NotPorted) from the mustpass of the pinned upstream revision:
src/vkt/tests/{glsl,texture,ycbcr}/not_ported_cases/*.txt. Each line is the dotted path below the group the list is added to."""
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
MUSTPASS = CRATE.parent / "tmp" / "VK-GL-CTS" / "external" / "vulkancts" / "mustpass" / "main" / "vk-default"
TESTS = CRATE / "src" / "vkt" / "tests"

# (mustpass file, prefix after dEQP-VK., prefix kept in the name or not, skipped first components, output file)
LISTS = [
    ("glsl.txt", "glsl.texture_functions.", ("truncation", "loop_unroll_hoisting"), "glsl/not_ported_cases/texture_functions.txt"),
    ("glsl.txt", "glsl.texture_gather.", (), "glsl/not_ported_cases/texture_gather.txt"),
    ("glsl.txt", "glsl.builtin.", ("function", "precision_fconvert"), "glsl/not_ported_cases/builtin_precision.txt"),
    ("texture.txt", "texture.explicit_lod.", (), "texture/not_ported_cases/explicit_lod.txt"),
    ("ycbcr.txt", "ycbcr.storage_image_write.", (), "ycbcr/not_ported_cases/storage_image_write.txt"),
]


def main() -> None:
    for file, prefix, skip, out in LISTS:
        names = []
        for line in (MUSTPASS / file).read_text().splitlines():
            line = line.strip()
            if not line.startswith("dEQP-VK." + prefix):
                continue
            rest = line[len("dEQP-VK." + prefix):]
            if rest.split(".")[0] in skip:
                continue
            names.append(rest)
        path = TESTS / out
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text("\n".join(names) + "\n")
        print(out, len(names))


if __name__ == "__main__":
    main()
