#!/usr/bin/env python3
"""
Generate OpenGL function usage table from test source files.

This script scans all GL test files in work_tester_core/src/opengl/tests/
and extracts:
- GL_VERSION: OpenGL version the test targets (from comments)
- OpenGL function calls: Automatically detected from gl::FunctionName patterns

Output is a markdown table showing which functions are used in which tests.
"""

import re
import sys
from pathlib import Path
from collections import defaultdict
from typing import Dict, List, Tuple, Set

def extract_gl_functions(content: str) -> Set[str]:
    """
    Extract all gl::FunctionName calls from Rust code.
    
    Only extracts actual function calls (e.g., gl::CreateShader, gl::GetError)
    and filters out constants (e.g., gl::ARRAY_BUFFER, gl::COMPILE_STATUS).
    
    Returns:
        Set of function names (e.g., "glCreateShader")
    """
    # Pattern to match gl::FunctionName calls
    # Matches: gl::CreateShader, gl::GetError, etc.
    # Does NOT match: gl::ARRAY_BUFFER, gl::COMPILE_STATUS (all caps)
    pattern = r'gl::([A-Z][a-z][a-zA-Z0-9_]*)'

    functions = set()
    for match in re.finditer(pattern, content):
        func_name = match.group(1)
        # Convert to OpenGL convention: gl + FunctionName
        gl_func_name = f"gl{func_name}"
        functions.add(gl_func_name)

    return functions

def extract_test_info(file_path: Path):
    """
    Extract test name, GL version, and function list from a test file.

    Returns:
        (test_name, gl_version, functions) or None
    """
    content = file_path.read_text()

    # Extract GL_VERSION from comment
    version_match = re.search(r'//!\s*GL_VERSION:\s*([\d.]+)', content)
    if not version_match:
        return None
    gl_version = version_match.group(1)

    # Extract GL functions automatically from code
    functions = extract_gl_functions(content)

    if not functions:
        return None

    # Extract test name from struct
    name_match = re.search(r'pub struct (\w+);', content)
    if not name_match:
        return None
    test_name = name_match.group(1)

    # Convert struct name to readable format (e.g., GL20ShadersTest -> Shaders)
    readable_name = re.sub(r'GL\d+(\w+)Test', r'\1', test_name)

    return (readable_name, gl_version, functions)

def generate_table(tests_dir: Path) -> str:
    """
    Generate markdown table from all test files.

    Returns:
        Markdown table as string
    """
    # Collect all test data
    tests = []
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

    # Build header with proper spacing
    col_width = 26
    header = f"| {'Function name':<{col_width}}"
    separator = f"|{'-' * (col_width + 1)}"

    for test_name, gl_version, _ in tests:
        cell = f"{test_name} <br/> GL {gl_version}"
        header += f" | {cell:^23}"
        separator += f"|{'-' * 24}"

    header += " |"
    separator += "|"

    table_lines = [header, separator]

    # Generate table rows
    for func in sorted_functions:
        row = f"| {func:<{col_width}}"
        for test_name, gl_version, functions in tests:
            if func in functions:
                row += " | x                   "
            else:
                row += " |                     "
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

    print(f"✓ Generated table: {output_file}")
    print(f"✓ Functions auto-detected from gl::* calls (filters out constants)")
    print("\nPreview:")
    print(table)

if __name__ == "__main__":
    main()
