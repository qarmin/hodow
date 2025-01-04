#!/usr/bin/env python3
"""Writes src/vkt/tests/renderpass/exotic_cases/<parent>.txt from the mustpass: the case names of the renderpasses groups whose bodies need
vendor extensions (fragment_density_map, multiview_per_view, performance_counters_by_region), one file per parent group, relative to it."""
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
MUSTPASS = CRATE.parent / "tmp" / "VK-GL-CTS" / "external" / "vulkancts" / "mustpass" / "main" / "vk-default" / "renderpasses.txt"
OUT = CRATE / "src" / "vkt" / "tests" / "renderpass" / "exotic_cases"
FAMILIES = ("fragment_density_map", "multiview_per_view", "performance_counters_by_region")
PARENTS = [
    "renderpass1",
    "renderpass2",
    "dynamic_rendering.primary_cmd_buff",
    "dynamic_rendering.partial_secondary_cmd_buff",
    "dynamic_rendering.complete_secondary_cmd_buff",
    "dynamic_rendering.graphics_pipeline_library",
]


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    lines = [l.strip() for l in MUSTPASS.read_text().splitlines() if l.strip()]
    for parent in PARENTS:
        prefix = "dEQP-VK.renderpasses." + parent + "."
        names = []
        for line in lines:
            if line.startswith(prefix):
                rest = line[len(prefix):]
                if rest.split(".")[0] in FAMILIES:
                    names.append(rest)
        (OUT / f"{parent}.txt").write_text("\n".join(names) + "\n")
        print(parent, len(names))


if __name__ == "__main__":
    main()
