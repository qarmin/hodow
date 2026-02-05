import os
import re
import sys
import shutil
import subprocess
from datetime import datetime

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC_PATH = os.path.join(ROOT, 'src', 'cpu', 'sse2.rs')

def run_just():
    print('Running `just run`...')
    p = subprocess.run(['just', 'run'], cwd=ROOT, capture_output=True, text=True)
    out = p.stdout + '\n' + p.stderr
    return out

TEST_LINE_RE = re.compile(r"test_(?P<name>[^\s]+) failed: (?P<msg>.+)$")
GOT_RE = re.compile(r"Got (?P<got>\[[^\]]*\]|-?0x[0-9A-Fa-f]+|-?\d+\.\d+|-?\d+)")


def find_first_error(output):
    for line in output.splitlines():
        if ('[ERROR]' in line) and ('test_' in line):
            print(line)
            m = TEST_LINE_RE.search(line)
            if m:
                return m.group('name'), m.group('msg'), line
    return None, None, None


def parse_got(msg):
    m = GOT_RE.search(msg)
    if not m:
        return None
    return m.group('got')


# Helpers to find function body by simple brace counting

def find_function_block(src, fn_name):
    # find 'fn test_<name>' occurrence
    pattern = re.compile(rf"fn\s+test_{re.escape(fn_name)}\s*\(")
    m = pattern.search(src)
    if not m:
        return None
    start_pos = src.rfind('\n', 0, m.start()) + 1  # start of line
    # find first '{' after the fn header
    brace_pos = src.find('{', m.end())
    if brace_pos == -1:
        return None
    # find matching closing brace
    depth = 0
    i = brace_pos
    while i < len(src):
        if src[i] == '{':
            depth += 1
        elif src[i] == '}':
            depth -= 1
            if depth == 0:
                return start_pos, i+1
        i += 1
    return None


# Find first check_ call within a block by finding 'check_' and balancing parens

def find_check_call(block_src):
    idx = block_src.find('check_')
    if idx == -1:
        return None
    # find '(' after idx
    paren_pos = block_src.find('(', idx)
    if paren_pos == -1:
        return None
    # find matching closing ')' by counting
    depth = 0
    i = paren_pos
    while i < len(block_src):
        if block_src[i] == '(':
            depth += 1
        elif block_src[i] == ')':
            depth -= 1
            if depth == 0:
                # return span (start, end) and content
                return idx, paren_pos, i, block_src[idx:i+1]
        i += 1
    return None


# split top-level commas

def split_top_level_commas(s):
    parts = []
    cur = ''
    depth_paren = depth_brack = depth_brace = 0
    i = 0
    while i < len(s):
        ch = s[i]
        if ch == '(':
            depth_paren += 1
        elif ch == ')':
            depth_paren -= 1
        elif ch == '[':
            depth_brack += 1
        elif ch == ']':
            depth_brack -= 1
        elif ch == '{':
            depth_brace += 1
        elif ch == '}':
            depth_brace -= 1
        if ch == ',' and depth_paren == 0 and depth_brack == 0 and depth_brace == 0:
            parts.append(cur.strip())
            cur = ''
        else:
            cur += ch
        i += 1
    if cur.strip() != '':
        parts.append(cur.strip())
    return parts


def backup_file(path):
    ts = datetime.now().strftime('%Y%m%d-%H%M%S')
    bak = path + f'.bak-{ts}'
    shutil.copy2(path, bak)
    return bak


def apply_fix(fn_name, got_value):
    if not os.path.exists(SRC_PATH):
        print('Source file not found:', SRC_PATH)
        return False
    src = open(SRC_PATH, 'r', encoding='utf-8').read()
    loc = find_function_block(src, fn_name)
    if not loc:
        print(f'Function test_{fn_name} not found in {SRC_PATH}')
        return False
    start, end = loc
    block = src[start:end]
    chk = find_check_call(block)
    if not chk:
        print(f'No check_* call found in function test_{fn_name} (skipping)')
        return False
    c_idx, paren_pos, end_pos, call_src = chk
    # compute absolute positions
    abs_call_start = start + c_idx
    abs_paren = start + paren_pos
    abs_call_end = start + end_pos
    args_text = src[abs_paren+1:abs_call_end-1]
    args = split_top_level_commas(args_text)
    if len(args) < 2:
        print('Check call has less than 2 arguments, skipping')
        return False
    # detect if original second arg had a leading '&'
    second_arg = args[1]
    has_amp = second_arg.strip().startswith('&')
    # prepare new second arg
    new_second = got_value
    # If got is an array like [1,2] and original had '&', keep it
    if has_amp and not new_second.strip().startswith('&'):
        new_second = '&' + new_second
    elif (not has_amp) and new_second.strip().startswith('&'):
        # remove amp if got_value included it
        new_second = new_second.strip().lstrip('&')
    # reconstruct args
    args[1] = new_second
    new_args_text = ', '.join(args)
    # replace in source
    new_src = src[:abs_paren+1] + new_args_text + src[abs_call_end-1:]
    # backup
    bak = backup_file(SRC_PATH)
    open(SRC_PATH, 'w', encoding='utf-8').write(new_src)
    print(f'Applied fix in test_{fn_name}. Backup saved to {bak}')
    return True


def main():
    out = run_just()
    fn_name, msg, raw_line = find_first_error(out)
    if not fn_name:
        print('No ERROR test failures found in output')
        return 0
    print('First failing test:', fn_name)
    got = parse_got(msg)
    if not got:
        print('No `Got` value parsed from message, skipping. Message was:\n', msg)
        return 1
    print('Parsed GOT value:', got)
    ok = apply_fix(fn_name, got)
    if not ok:
        print('Failed to apply fix')
        return 1
    print('Done. Re-run the script to fix the next failing test.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
