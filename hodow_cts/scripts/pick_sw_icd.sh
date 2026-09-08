#!/usr/bin/env bash
# Prints the path of a software Vulkan ICD manifest, preferring Mesa's lavapipe over
# SwiftShader. Exits 1 with a diagnostic if there is none.
#
# lavapipe first because it is the more complete driver: SwiftShader has neither
# tessellation, geometry, VK_KHR_push_descriptor nor VK_KHR_maintenance6, so whole
# test groups can only be skipped on it - and it ignores a descriptor update
# template's layout, which means it also passes cases that a real driver rejects.
#
# ICD locations differ between distros and Mesa versions, so they are searched for
# rather than hardcoded.
set -uo pipefail

icd_dirs=(
    /usr/share/vulkan/icd.d
    /usr/local/share/vulkan/icd.d
    /etc/vulkan/icd.d
    /usr/lib/x86_64-linux-gnu/vulkan/icd.d
    /usr/lib/vulkan/icd.d
    "${XDG_DATA_HOME:-$HOME/.local/share}/vulkan/icd.d"
)

found=()
for d in "${icd_dirs[@]}"; do
    [ -d "$d" ] || continue
    while IFS= read -r f; do found+=("$f"); done < <(find "$d" -maxdepth 1 -name '*.json' 2>/dev/null)
done
# SwiftShader ships with Chrome/Playwright; handy when Mesa has no software driver.
while IFS= read -r f; do found+=("$f"); done < <(
    find /opt/ms-playwright /opt/google/chrome -maxdepth 4 -name 'vk_swiftshader_icd.json' 2>/dev/null
)

pick=""
for pattern in lvp lavapipe swiftshader; do
    for f in "${found[@]:-}"; do
        [ -n "$f" ] || continue
        if printf '%s' "$f" | grep -qi "$pattern"; then pick="$f"; break 2; fi
    done
done

if [ -z "$pick" ]; then
    echo "no software Vulkan driver found." >&2
    echo >&2
    echo "ICD manifests visible on this system:" >&2
    if [ "${#found[@]}" -eq 0 ] || [ -z "${found[0]:-}" ]; then
        echo "  (none - searched: ${icd_dirs[*]})" >&2
    else
        printf '  %s\n' "${found[@]}" >&2
    fi
    echo >&2
    echo "mesa-vulkan-drivers should provide lavapipe. Find where it put it with:" >&2
    echo "  dpkg -L mesa-vulkan-drivers | grep -i icd" >&2
    echo >&2
    echo "Then run it directly, e.g.:" >&2
    echo "  VK_ICD_FILENAMES=<that path> just cts" >&2
    exit 1
fi

printf '%s\n' "$pick"
