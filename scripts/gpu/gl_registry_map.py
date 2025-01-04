#!/usr/bin/env python3
"""
Download Khronos OpenGL registry (gl.xml), parse commands and map each command to
- core_version: the earliest OpenGL feature number where the command appears
- extensions: list of extension names that provide the command

Writes a JSON (default) or CSV file with the mapping and metadata.

Usage:
  python3 scripts/gl_registry_map.py --output out.json
  python3 scripts/gl_registry_map.py --source-url <url> --format csv --output out.csv

"""

from __future__ import annotations

import argparse
import xml.etree.ElementTree as ET
import urllib.request
import urllib.error
import tempfile
import shutil
import os
import sys
import time
import json
import csv
import uuid
from typing import Dict, List, Optional, Tuple

DEFAULT_URL = (
    "https://raw.githubusercontent.com/KhronosGroup/OpenGL-Registry/main/xml/gl.xml"
)


def download_registry(url: str, timeout: int = 10, retries: int = 2) -> bytes:
    """Download bytes from url. Support file:// local paths as fallback."""
    if url.startswith("file://"):
        local_path = url[len("file://") :]
        with open(local_path, "rb") as f:
            return f.read()

    attempt = 0
    last_err = None
    while attempt <= retries:
        try:
            with urllib.request.urlopen(url, timeout=timeout) as r:
                return r.read()
        except Exception as e:
            last_err = e
            attempt += 1
            if attempt <= retries:
                time.sleep(1)
    raise RuntimeError(f"Failed to download {url}: {last_err}")


def parse_version_number(s: str) -> Tuple[int, int]:
    # "1.0" -> (1,0) ; fallback to (0,0)
    try:
        parts = s.split(".")
        major = int(parts[0])
        minor = int(parts[1]) if len(parts) > 1 else 0
        return (major, minor)
    except Exception:
        return (0, 0)


def version_to_str(v: Tuple[int, int]) -> str:
    return f"{v[0]}.{v[1]}"


def find_command_name(cmd_elem: ET.Element) -> Optional[str]:
    # command proto/name
    # Find the first descendant named 'name'
    name = cmd_elem.find("name")
    if name is not None and name.text:
        return name.text.strip()
    # Fallback: search recursively
    for nd in cmd_elem.iter():
        if nd.tag == "name" and nd.text:
            return nd.text.strip()
    return None


def build_signature(cmd_elem: ET.Element) -> Optional[str]:
    # Build signature string like: name(arg: type, ...) -> return_type
    name = find_command_name(cmd_elem)
    if name is None:
        return None
    # proto text contains return type and name
    proto = cmd_elem.find("proto")
    return_type = "void"
    if proto is not None:
        proto_text = "".join(proto.itertext()).strip()
        # remove the name at the end if present
        if proto_text.endswith(name):
            return_type = proto_text[: -len(name)].strip()
        else:
            parts = proto_text.split()
            if len(parts) >= 2:
                return_type = " ".join(parts[:-1])
            else:
                return_type = proto_text
    # params
    params = []
    for param in cmd_elem.findall("param"):
        ptext = "".join(param.itertext()).strip()
        if not ptext:
            continue
        parts = ptext.split()
        if len(parts) == 1:
            pname = parts[0]
            ptype = ""
        else:
            pname = parts[-1]
            ptype = " ".join(parts[:-1])
        params.append(f"{pname}: {ptype}" if ptype else pname)
    # use '; ' as parameter separator to avoid commas inside the CSV field (prevents quoting)
    sig = f"{name}({'; '.join(params)}) -> {return_type}"
    # sanitize to avoid commas or double quotes inside the CSV field
    sig = sig.replace(',', ';')
    sig = sig.replace('"', "'")
    sig = ' '.join(sig.split())
    return sig


def parse_registry(xml_bytes: bytes) -> Dict[str, Dict]:
    """Return mapping name -> { core_version: Optional[str], extensions: List[str], signature: Optional[str] }

    Strategy:
      - parse <feature api="gl" number="X.Y"> in ascending order and record commands
        listed inside <require> as core-introduced if not already set.
      - parse <extension> entries and record commands from their <require> sections.
    """
    root = ET.fromstring(xml_bytes)

    # Prepare command map from <commands> section to ensure we know all command names
    commands_section = root.find("commands")
    all_commands: Dict[str, Dict] = {}
    if commands_section is not None:
        for cmd in commands_section.findall("command"):
            name = find_command_name(cmd)
            sig = build_signature(cmd)
            if name:
                all_commands[name] = {"core_version": None, "extensions": [], "signature": sig}

    # Parse <feature> elements for core versions (search recursively)
    features = []
    for feat in root.findall(".//feature"):
        api = feat.attrib.get("api", "gl")
        if api != "gl":
            continue
        number = feat.attrib.get("number")
        if not number:
            continue
        ver = parse_version_number(number)
        features.append((ver, feat))

    features.sort(key=lambda x: (x[0][0], x[0][1]))

    for ver, feat in features:
        number_str = version_to_str(ver)
        # iterate require/require children
        for req in feat.findall("require"):
            # commands are <command name="..."/>
            for cmd in req.findall("command"):
                name = cmd.attrib.get("name")
                if not name:
                    continue
                if name not in all_commands:
                    all_commands[name] = {"core_version": number_str, "extensions": [], "signature": None}
                else:
                    if all_commands[name]["core_version"] is None:
                        all_commands[name]["core_version"] = number_str

    # Parse extensions (search recursively for extension elements)
    for ext in root.findall(".//extension"):
        ext_name = ext.attrib.get("name")
        if not ext_name:
            continue
        for req in ext.findall("require"):
            for cmd in req.findall("command"):
                name = cmd.attrib.get("name")
                if not name:
                    continue
                if name not in all_commands:
                    all_commands[name] = {"core_version": None, "extensions": [ext_name], "signature": None}
                else:
                    if ext_name not in all_commands[name]["extensions"]:
                        all_commands[name]["extensions"].append(ext_name)

    # Remove duplicates and sort extensions
    for v in all_commands.values():
        v["extensions"] = sorted(set(v["extensions"]))
        # ensure signature key exists
        if "signature" not in v:
            v["signature"] = None

    return all_commands


def _atomic_tmp_path(path: str) -> str:
    # create a tmp filename in same directory to avoid cross-device rename
    abs_path = os.path.abspath(path)
    dirpath = os.path.dirname(abs_path) or os.getcwd()
    unique = uuid.uuid4().hex
    return os.path.join(dirpath, f".tmp_gl_map_{os.getpid()}_{unique}")


def write_json_atomic(path: str, data) -> None:
    dirpath = os.path.dirname(path)
    if dirpath and not os.path.exists(dirpath):
        os.makedirs(dirpath, exist_ok=True)
    tmp = _atomic_tmp_path(path)
    try:
        with open(tmp, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
        os.replace(tmp, path)
    finally:
        if os.path.exists(tmp):
            try:
                os.remove(tmp)
            except Exception:
                pass


def write_csv_atomic(path: str, commands_map: Dict[str, Dict]) -> None:
    dirpath = os.path.dirname(path)
    if dirpath and not os.path.exists(dirpath):
        os.makedirs(dirpath, exist_ok=True)
    tmp = _atomic_tmp_path(path)
    try:
        with open(tmp, "w", encoding="utf-8", newline="") as f:
            writer = csv.writer(f)
            # signature column first (compact human-readable form), then core_version and extensions
            writer.writerow(["signature", "core_version", "extensions"])
            for name in sorted(commands_map.keys()):
                rec = commands_map[name]
                sig = (rec.get("signature") or f"{name}() ->").strip()
                # final sanitize: replace any commas/double quotes to avoid CSV quoting
                sig = sig.replace(',', ';').replace('"', "'")
                core_ver = (rec.get("core_version") or "").strip()
                exts = ";".join(e.strip() for e in rec.get("extensions", []))
                writer.writerow([sig, core_ver, exts])
        os.replace(tmp, path)
    finally:
        if os.path.exists(tmp):
            try:
                os.remove(tmp)
            except Exception:
                pass


def main(argv: Optional[List[str]] = None) -> int:
    p = argparse.ArgumentParser(description="Fetch and map OpenGL functions to core versions and extensions")
    p.add_argument("--source-url", default=DEFAULT_URL, help="URL or file:// path to gl.xml")
    p.add_argument("--output", default="gl_functions.csv", help="Output file path (json or csv based on --format). Defaults to gl_functions.csv")
    p.add_argument("--format", choices=["json", "csv"], default="csv", help="Output format (default: csv)")
    p.add_argument("--timeout", type=int, default=10, help="HTTP timeout in seconds")
    p.add_argument("--retries", type=int, default=2, help="Number of download retries")
    args = p.parse_args(argv)

    try:
        print(f"Downloading registry from {args.source_url}...")
        xml_bytes = download_registry(args.source_url, timeout=args.timeout, retries=args.retries)
        print("Parsing registry...")
        commands_map = parse_registry(xml_bytes)

        metadata = {
            "generated_at": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
            "source_url": args.source_url,
            "commands_count": len(commands_map),
        }

        if args.format == "json":
            out = {"metadata": metadata, "commands": []}
            for name in sorted(commands_map.keys()):
                rec = commands_map[name]
                out["commands"].append({
                    "name": name,
                    "core_version": rec.get("core_version"),
                    "extensions": rec.get("extensions", []),
                })
            print(f"Writing JSON to {args.output} ({len(out['commands'])} commands)")
            write_json_atomic(args.output, out)
        else:
            print(f"Writing CSV to {args.output} ({len(commands_map)} commands)")
            write_csv_atomic(args.output, commands_map)

        print("Done.")
        return 0
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())

