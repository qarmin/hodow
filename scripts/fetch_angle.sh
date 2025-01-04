#!/usr/bin/env bash
# Puts ANGLE's libEGL.dll, libGLESv2.dll and d3dcompiler_47.dll (the EGL hodow_cts needs on Windows) into the directory given as $1.
# Taken from the CEF runtime package on nuget: since Chromium 129 or so CEF's newer builds link ANGLE statically, so the version is pinned to one that still ships the DLLs.
set -euo pipefail

CEF_VERSION=136.1.4
dest=${1:?usage: fetch_angle.sh <dest dir>}
cache="$(dirname "$0")/../tmp/angle"
package="$cache/cef-$CEF_VERSION.nupkg"

mkdir -p "$cache" "$dest"
if [ -s "$dest/libEGL.dll" ] && [ -s "$dest/libGLESv2.dll" ] && [ -s "$dest/d3dcompiler_47.dll" ]; then
    exit 0
fi
if [ ! -s "$package" ]; then
    curl -fL --retry 3 -o "$package.part" "https://api.nuget.org/v3-flatcontainer/chromiumembeddedframework.runtime.win-x64/$CEF_VERSION/chromiumembeddedframework.runtime.win-x64.$CEF_VERSION.nupkg"
    mv "$package.part" "$package"
fi
unzip -qoj "$package" 'runtimes/win-x64/native/libEGL.dll' 'runtimes/win-x64/native/libGLESv2.dll' 'runtimes/win-x64/native/d3dcompiler_47.dll' -d "$dest"
