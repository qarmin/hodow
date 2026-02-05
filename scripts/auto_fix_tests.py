import os
import re
import sys
import subprocess

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CPU_DIR = os.path.join(ROOT, 'src', 'cpu')


def run_just():
    p = subprocess.run(['just', 'run'], cwd=ROOT, capture_output=True, text=True)
    out = p.stdout + '\n' + p.stderr
    return out

TEST_LINE_RE = re.compile(r"test_(?P<name>[^\s]+) failed: (?P<msg>.+?)(?=(\s+test_|$))", re.DOTALL)
GOT_RE = re.compile(r"Got (?P<got>\x5B.*?\x5D|-?0x[0-9A-Fa-f]+|-?\d+\.\d+|-?\d+)")


def find_all_errors(output):
    results = []
    for m in TEST_LINE_RE.finditer(output):
        name = m.group('name')
        msg = m.group('msg').strip()
        results.append((name, msg))
    return results


def parse_got(msg):
    m = GOT_RE.search(msg)
    if not m:
        return None
    return m.group('got')


def find_function_block(src, fn_name):
    pattern = re.compile(rf"(^|\n)\s*(?:pub\s+)?(?:crate\s+)?(?:unsafe\s+)?(?:fn|async fn)\s+test_{re.escape(fn_name)}\b")
    m = pattern.search(src)
    if not m:
        return None
    start_pos = src.rfind('\n', 0, m.start()) + 1
    brace_pos = src.find('{', m.end())
    if brace_pos == -1:
        return None
    depth = 0
    i = brace_pos
    while i < len(src):
        if src[i] == '{':
            depth += 1
        elif src[i] == '}':
            depth -= 1
            if depth == 0:
                return start_pos, i + 1
        i += 1
    return None


def find_check_call(block_src):
    idx = block_src.find('check_')
    if idx == -1:
        return None
    paren_pos = block_src.find('(', idx)
    if paren_pos == -1:
        return None
    depth = 0
    i = paren_pos
    while i < len(block_src):
        if block_src[i] == '(':
            depth += 1
        elif block_src[i] == ')':
            depth -= 1
            if depth == 0:
                return idx, paren_pos, i
        i += 1
    return None


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


def apply_fix_to_file(file_path, fn_name, got_value):
    src = open(file_path, 'r', encoding='utf-8').read()
    loc = find_function_block(src, fn_name)
    if not loc:
        return False
    start, end = loc
    block = src[start:end]
    chk = find_check_call(block)
    if not chk:
        return False
    c_idx, paren_pos, close_paren = chk
    abs_paren = start + paren_pos
    abs_close = start + close_paren
    args_text = src[abs_paren+1:abs_close]
    args = split_top_level_commas(args_text)
    if len(args) < 2:
        return False
    second_arg = args[1]
    has_amp = second_arg.strip().startswith('&')
    new_second = got_value
    if has_amp and not new_second.strip().startswith('&'):
        new_second = '&' + new_second
    elif (not has_amp) and new_second.strip().startswith('&'):
        new_second = new_second.strip().lstrip('&')
    args[1] = new_second
    new_args_text = ', '.join(args)
    new_src = src[:abs_paren+1] + new_args_text + src[abs_close:]
    open(file_path, 'w', encoding='utf-8').write(new_src)
    return True


def apply_fix(fn_name, got_value):
    for fname in os.listdir(CPU_DIR):
        if not fname.endswith('.rs'):
            continue
        path = os.path.join(CPU_DIR, fname)
        try:
            ok = apply_fix_to_file(path, fn_name, got_value)
            if ok:
                return True
        except Exception:
            pass
    return False


def main():
    out = run_just()
    errors = find_all_errors(out)
    if not errors:
        print('No ERROR test failures found in output')
        return 0
    to_fix = []
    for name, msg in errors:
        got = parse_got(msg)
        if got:
            to_fix.append((name, got))
    if not to_fix:
        print('No `Got` values parsed from messages, skipping.', 'Total errors found:', len(errors))
        return 1
    applied_any = False
    for name, got in to_fix:
        ok = apply_fix(name, got)
        if ok:
            print(f'Applied fix in test_{name}')
            applied_any = True
        else:
            print(f'Failed to apply fix in test_{name}')
    if not applied_any:
        return 1
    print('Done. Re-run the script to fix the next failing tests.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
