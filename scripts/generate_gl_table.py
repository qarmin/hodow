#!/usr/bin/env python3
"""
Generate OpenGL function usage table from test source files.

This script scans all GL test files in work_tester_core/src/opengl/tests/
and extracts:
- GL_VERSION: OpenGL version the test targets
- GL_FUNCTIONS: List of OpenGL functions used
- Test name from the module

Output is a markdown table showing which functions are used in which tests.
"""

import re
import sys
from pathlib import Path
from collections import defaultdict
from typing import Dict, List, Tuple

def extract_test_info(file_path: Path) -> Tuple[str, str, List[str]]:
    """
    Extract test name, GL version, and function list from a test file.

    Returns:
        (test_name, gl_version, functions)
    """
    content = file_path.read_text()

    # Extract GL_VERSION from comment
    version_match = re.search(r'//!\s*GL_VERSION:\s*([\d.]+)', content)
    if not version_match:
        return None
    gl_version = version_match.group(1)

    # Extract GL_FUNCTIONS from comment
    functions_match = re.search(r'//!\s*GL_FUNCTIONS:\s*(.+)', content)
    if not functions_match:
        return None
    functions_str = functions_match.group(1)
    functions = [f.strip() for f in functions_str.split(',')]

    # Extract test name from struct
    name_match = re.search(r'pub struct (\w+);', content)
    if not name_match:
        return None
    test_name = name_match.group(1)

    # Convert struct name to readable format (e.g., GL11ImmediateTest -> GL 1.1 Immediate)
    readable_name = re.sub(r'GL(\d+)(\w+)Test', r'GL \1 \2', test_name)
    readable_name = readable_name.replace('GL ', f'GL {gl_version} ')

    return (readable_name, gl_version, functions)

def generate_table(tests_dir: Path) -> str:
    """
    Generate markdown table from all test files.

    Returns:
        Markdown table as string
    """
    # Collect all test data
    tests: List[Tuple[str, str, List[str]]] = []
    all_functions = set()

    for test_file in sorted(tests_dir.glob('gl*.rs')):
        if test_file.name == 'mod.rs':
            continue

        info = extract_test_info(test_file)
        if info:
            test_name, gl_version, functions = info
            tests.append((test_name, gl_version, functions))
            all_functions.update(functions)

    if not tests:
        return "No tests found."

    # Sort functions alphabetically
    sorted_functions = sorted(all_functions)

    # Build function usage map
    function_usage: Dict[str, List[str]] = defaultdict(list)
    for test_name, gl_version, functions in tests:
        for func in functions:
            function_usage[func].append(test_name)

    # Generate table header
    header = "| Function name"
    separator = "|---"

    for test_name, gl_version, _ in tests:
        # Extract short name from test (e.g., "GL 1.1 Immediate" -> "Immediate")
        parts = test_name.split()
        if len(parts) >= 3:
            short_name = " ".join(parts[2:])
        else:
            short_name = test_name
        header += f" | {short_name} <br/> GL {gl_version}"
        separator += " |---"

    header += " |"
    separator += " |"

    table_lines = [header, separator]

    # Generate table rows
    for func in sorted_functions:
        row = f"| {func}"
        for test_name, gl_version, functions in tests:
            if func in functions:
                row += " | x"
            else:
                row += " |"
        row += " |"
        table_lines.append(row)

    return "\n".join(table_lines)

def main():
    # Find tests directory
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    tests_dir = project_root / "work_tester_core" / "src" / "opengl" / "tests"

    if not tests_dir.exists():
        print(f"Error: Tests directory not found: {tests_dir}", file=sys.stderr)
        sys.exit(1)

    # Generate table
    table = generate_table(tests_dir)

    # Output
    output_file = project_root / "work_tester_core" / "src" / "opengl" / "FUNCTIONS_TABLE.md"
    output_file.write_text(f"# OpenGL Function Coverage\n\n{table}\n")

    print(f"Generated table written to: {output_file}")
    print("\nPreview:")
    print(table)

if __name__ == "__main__":
    main()
