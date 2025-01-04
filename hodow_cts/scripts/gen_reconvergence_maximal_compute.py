#!/usr/bin/env python3
"""Writes the shaders, the manifest and the case table of dEQP-VK.reconvergence.maximal.compute (1440 cases) by replaying
`RandomProgram` of vktReconvergenceTests.cpp (de::Random draws included, in the same order).

What upstream decides per device is not baked in: the local index comparisons (`rnd % invocationStride`, the stride depends on the
subgroup size) are specialization constants (ids 10 + n, in the order of the `IF_LOCAL_INVOCATION_INDEX` ops) and the table carries
the raw draw. The program itself is written as a token list for the host simulation in `maximal_compute_tests.rs`.

Token of an op: `<type>` or `<type>:<arg>`; the arg is `u`/`i<mask index>` for OP_IF_MASK, 32 hex digits (the 128 bit ballot value)
for OP_CASE_MASK_BEGIN and OP_CASE_LOOP_COUNT_BEGIN, and the hex value otherwise (omitted when zero).

Written: shaders/manifest/reconvergence_compute.toml, shaders/src/reconvergence_compute/ and
src/vkt/tests/reconvergence/compute_cases.rs. Run from hodow_cts/:  python3 scripts/gen_reconvergence_maximal_compute.py
(then `just cts-shaders`). Pure text, no compilation.
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "scripts"))
from de_random import DeRandom  # noqa: E402

SRC = ROOT / "shaders" / "src" / "reconvergence_compute"
MANIFEST = ROOT / "shaders" / "manifest" / "reconvergence_compute.toml"
TABLE = ROOT / "src" / "vkt" / "tests" / "reconvergence" / "compute_cases.rs"

M64 = (1 << 64) - 1
M128 = (1 << 128) - 1

(
    OP_BALLOT,
    OP_STORE,
    OP_IF_MASK,
    OP_ELSE_MASK,
    OP_ENDIF,
    OP_IF_LOOPCOUNT,
    OP_ELSE_LOOPCOUNT,
    OP_IF_LOCAL_INVOCATION_INDEX,
    OP_ELSE_LOCAL_INVOCATION_INDEX,
    OP_BREAK,
    OP_CONTINUE,
    OP_ELECT,
    OP_BEGIN_FOR_UNIF,
    OP_END_FOR_UNIF,
    OP_BEGIN_FOR_VAR,
    OP_END_FOR_VAR,
    OP_BEGIN_FOR_INF,
    OP_END_FOR_INF,
    OP_BEGIN_DO_WHILE_UNIF,
    OP_END_DO_WHILE_UNIF,
    OP_BEGIN_DO_WHILE_INF,
    OP_END_DO_WHILE_INF,
    OP_RETURN,
    OP_CALL_BEGIN,
    OP_CALL_END,
    OP_SWITCH_UNIF_BEGIN,
    OP_SWITCH_VAR_BEGIN,
    OP_SWITCH_LOOP_COUNT_BEGIN,
    OP_CASE_MASK_BEGIN,
    OP_CASE_LOOP_COUNT_BEGIN,
    OP_SWITCH_END,
    OP_CASE_END,
    OP_NOISE,
    OP_NOP,
) = range(34)

IF_MASK, IF_UNIFORM, IF_LOOPCOUNT, IF_LOCAL_INVOCATION_INDEX = range(4)


class Op:
    """`OP`: `arg` is what the token carries beyond the type (the raw draw for the local index ifs, an index or "u" for the mask ifs, a ballot for the cases)."""

    def __init__(self, type_, value=0, case_value=0, bvalue=None, arg=None):
        self.type = type_
        self.value = value
        self.case_value = case_value
        self.bvalue = bvalue
        self.arg = arg

    def copy(self):
        return Op(self.type, self.value, self.case_value, self.bvalue, self.arg)

    def token(self):
        if self.type == OP_IF_MASK:
            return f"{self.type}:{self.arg}"
        if self.type in (OP_CASE_MASK_BEGIN, OP_CASE_LOOP_COUNT_BEGIN):
            return f"{self.type}:{self.bvalue:032x}"
        if self.type == OP_BALLOT and self.case_value:
            return f"{self.type}:1"
        if self.value:
            return f"{self.type}:{self.value:x}"
        return str(self.type)


def uvec4_ballot(x, y=None, z=None, w=None):
    """`Ballot = UVec4`: component 0 is the lowest word."""
    if y is None:
        y = z = w = x
    return (x & 0xFFFFFFFF) | ((y & 0xFFFFFFFF) << 32) | ((z & 0xFFFFFFFF) << 64) | ((w & 0xFFFFFFFF) << 96)


class RandomProgram:
    def __init__(self, seed, max_nesting, invocation_stride, test_type="maximal"):
        self.test_type = test_type
        self.maximal = test_type == "maximal"
        self.elect = test_type.endswith("elect")
        self.rnd = DeRandom(seed)
        self.invocation_stride = invocation_stride
        self.ops = []
        self.masks = []
        self.ballot_masks = []
        self.num_masks = 5
        self.nesting = 0
        self.max_nesting = max_nesting
        self.loop_nesting = 0
        self.loop_nesting_this_function = 0
        self.call_nesting = 0
        self.min_count = 30
        self.indent = 0
        self.is_loop_inf = [False] * 100
        self.done_inf_loop_break = [False] * 100
        self.store_base = 0x10000
        for _ in range(self.num_masks):
            lo = self.u64()
            hi = self.u64()
            self.ballot_masks.append(uvec4_ballot(lo & 0xFFFFFFFF, lo >> 32, hi & 0xFFFFFFFF, hi >> 32))
            self.masks.append(lo)

    def u32(self):
        return self.rnd.get_uint32()

    def u64(self):
        x = self.u32()
        return (x << 32) | self.u32()

    def push(self, type_, value=0, case_value=0, bvalue=None, arg=None):
        self.ops.append(Op(type_, value, case_value, bvalue, arg))

    def push_mask_if(self, index):
        self.push(OP_IF_MASK, self.masks[index], 0, self.ballot_masks[index], f"i{index}")

    def gen_if(self, if_type):
        mask_idx = self.u32() % self.num_masks
        uniform = if_type == IF_UNIFORM

        local_index_cmp = self.u32()
        if if_type == IF_LOCAL_INVOCATION_INDEX:
            self.push(OP_IF_LOCAL_INVOCATION_INDEX, local_index_cmp)
        elif if_type == IF_LOOPCOUNT:
            self.push(OP_IF_LOOPCOUNT, 0)
        elif uniform:
            self.push(OP_IF_MASK, M64, 0, M128, "u")
        else:
            self.push_mask_if(mask_idx)

        self.nesting += 1

        then_begin = len(self.ops)
        self.pick_op(2)
        then_end = len(self.ops)

        rand_else = self.u32() % 100
        if rand_else < 50:
            if if_type == IF_LOCAL_INVOCATION_INDEX:
                self.push(OP_ELSE_LOCAL_INVOCATION_INDEX, local_index_cmp)
            elif if_type == IF_LOOPCOUNT:
                self.push(OP_ELSE_LOOPCOUNT, 0)
            else:
                self.push(OP_ELSE_MASK, 0)

            if rand_else < 10:
                for i in range(then_begin, then_end):
                    self.ops.append(self.ops[i].copy())
            else:
                self.pick_op(2)
        self.push(OP_ENDIF, 0)
        self.nesting -= 1

    def gen_loop(self, begin_type, end_type, value, inf):
        self.push(begin_type, value)
        loop_header = len(self.ops) - 1
        self.nesting += 1
        self.loop_nesting += 1
        self.loop_nesting_this_function += 1
        if inf:
            self.is_loop_inf[self.loop_nesting] = True
            self.done_inf_loop_break[self.loop_nesting] = False

        self.pick_op(2)
        if inf:
            self.gen_elect(True)
            self.done_inf_loop_break[self.loop_nesting] = True
            self.pick_op(2)

        self.push(end_type, loop_header)

        if inf:
            self.is_loop_inf[self.loop_nesting] = False
            self.done_inf_loop_break[self.loop_nesting] = False
        self.loop_nesting_this_function -= 1
        self.loop_nesting -= 1
        self.nesting -= 1

    def gen_for_unif(self):
        iter_count = (self.u32() % 5) + 1
        self.gen_loop(OP_BEGIN_FOR_UNIF, OP_END_FOR_UNIF, iter_count, False)

    def gen_do_while_unif(self):
        iter_count = (self.u32() % 5) + 1
        self.gen_loop(OP_BEGIN_DO_WHILE_UNIF, OP_END_DO_WHILE_UNIF, iter_count, False)

    def gen_for_var(self):
        self.gen_loop(OP_BEGIN_FOR_VAR, OP_END_FOR_VAR, 0, False)

    def gen_for_inf(self):
        self.gen_loop(OP_BEGIN_FOR_INF, OP_END_FOR_INF, 0, True)

    def gen_do_while_inf(self):
        self.gen_loop(OP_BEGIN_DO_WHILE_INF, OP_END_DO_WHILE_INF, 0, True)

    def gen_break(self):
        if self.loop_nesting_this_function > 0:
            if (self.u32() % 100) < 10:
                self.push_mask_if(0)
                self.push(OP_BREAK, 0)
                self.push(OP_ELSE_MASK, 0)
                self.push(OP_BREAK, 0)
                self.push(OP_ENDIF, 0)
            else:
                self.push(OP_BREAK, 0)

    def gen_continue(self):
        if self.loop_nesting_this_function > 0 and not self.is_loop_inf[self.loop_nesting]:
            if (self.u32() % 100) < 10:
                self.push_mask_if(0)
                self.push(OP_CONTINUE, 0)
                self.push(OP_ELSE_MASK, 0)
                self.push(OP_CONTINUE, 0)
                self.push(OP_ENDIF, 0)
            else:
                self.push(OP_CONTINUE, 0)

    def gen_elect(self, do_break):
        self.push(OP_ELECT, 0)
        self.nesting += 1
        if do_break:
            self.gen_ballot()
            self.gen_ballot()
            if (self.u32() % 100) < 10:
                self.pick_op(1)

            if self.call_nesting > 0 and (self.u32() % 100) < 30:
                self.push(OP_RETURN, 0)
            else:
                self.gen_break()
        else:
            self.pick_op(2)

        self.push(OP_ENDIF, 0)
        self.nesting -= 1

    def gen_return(self):
        r = self.u32() % 100
        if self.nesting > 0 and (
            r < 5
            or (self.call_nesting > 0 and self.loop_nesting_this_function > 0 and r < 20)
            or (self.call_nesting > 0 and self.loop_nesting_this_function > 1 and r < 50)
        ):
            self.gen_ballot()
            if (self.u32() % 100) < 10:
                self.push_mask_if(0)
                self.push(OP_RETURN, 0)
                self.push(OP_ELSE_MASK, 0)
                self.push(OP_RETURN, 0)
                self.push(OP_ENDIF, 0)
            else:
                self.push(OP_RETURN, 0)

    def gen_call(self):
        self.push(OP_CALL_BEGIN, 0)
        self.call_nesting += 1
        self.nesting += 1
        save = self.loop_nesting_this_function
        self.loop_nesting_this_function = 0

        self.pick_op(2)

        self.loop_nesting_this_function = save
        self.nesting -= 1
        self.call_nesting -= 1
        self.push(OP_CALL_END, 0)

    def gen_switch_unif(self):
        r = self.u32() % 5
        self.push(OP_SWITCH_UNIF_BEGIN, r)
        self.nesting += 1

        self.push(OP_CASE_MASK_BEGIN, 0, 1 << (r + 1), 0)
        self.pick_op(1)
        self.push(OP_CASE_END, 0)

        self.push(OP_CASE_MASK_BEGIN, M64, 1 << r, M128)
        self.pick_op(2)
        self.push(OP_CASE_END, 0)

        self.push(OP_CASE_MASK_BEGIN, 0, 1 << (r + 2), 0)
        self.pick_op(1)
        self.push(OP_CASE_END, 0)

        self.push(OP_SWITCH_END, 0)
        self.nesting -= 1

    def gen_switch_var(self):
        self.push(OP_SWITCH_VAR_BEGIN, 0)
        self.nesting += 1

        for pattern, case in ((0x11111111, 1 << 0), (0x22222222, 1 << 1), (0x44444444, 1 << 2), (0x88888888, 1 << 3)):
            self.push(OP_CASE_MASK_BEGIN, 0, case, uvec4_ballot(pattern))
            self.pick_op(1)
            self.push(OP_CASE_END, 0)

        self.push(OP_SWITCH_END, 0)
        self.nesting -= 1

    def gen_switch_multicase(self):
        self.push(OP_SWITCH_VAR_BEGIN, 0)
        self.nesting += 1

        self.push(OP_CASE_MASK_BEGIN, 0, (1 << 0) | (1 << 1), uvec4_ballot(0x33333333))
        self.pick_op(2)
        self.push(OP_CASE_END, 0)

        self.push(OP_CASE_MASK_BEGIN, 0, (1 << 2) | (1 << 3), uvec4_ballot(0xCCCCCCCC))
        self.pick_op(2)
        self.push(OP_CASE_END, 0)

        self.push(OP_SWITCH_END, 0)
        self.nesting -= 1

    def gen_switch_loop_count(self):
        r = self.u32() % self.loop_nesting
        self.push(OP_SWITCH_LOOP_COUNT_BEGIN, r)
        self.nesting += 1

        self.push(OP_CASE_LOOP_COUNT_BEGIN, 1 << 1, 1, uvec4_ballot(1 << 1, 0, 0, 0))
        self.pick_op(1)
        self.push(OP_CASE_END, 0)

        self.push(OP_CASE_LOOP_COUNT_BEGIN, 1 << 2, 2, uvec4_ballot(1 << 2, 0, 0, 0))
        self.pick_op(1)
        self.push(OP_CASE_END, 0)

        self.push(OP_CASE_LOOP_COUNT_BEGIN, (~6) & M64, 0xFFFFFFFF, uvec4_ballot((~6) & 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF))
        self.pick_op(1)
        self.push(OP_CASE_END, 0)

        self.push(OP_SWITCH_END, 0)
        self.nesting -= 1

    def pick_op(self, count):
        for _ in range(count):
            self.gen_ballot()
            if self.nesting < self.max_nesting:
                r = self.u32() % 11
                if r == 2 and self.loop_nesting:
                    self.gen_if(IF_LOOPCOUNT)
                elif r in (2, 10):
                    self.gen_if(IF_LOCAL_INVOCATION_INDEX)
                elif r == 0:
                    self.gen_if(IF_MASK)
                elif r == 1:
                    self.gen_if(IF_UNIFORM)
                elif r == 3:
                    if self.loop_nesting <= 3:
                        r2 = self.u32() % 3
                        if r2 == 0:
                            self.gen_for_unif()
                        elif r2 == 1:
                            self.gen_for_inf()
                        else:
                            self.gen_for_var()
                elif r == 4:
                    self.gen_break()
                elif r == 5:
                    self.gen_continue()
                elif r == 6:
                    self.gen_elect(False)
                elif r == 7:
                    r2 = self.u32() % 5
                    if r2 == 0 and self.call_nesting == 0 and self.nesting < self.max_nesting - 2:
                        self.gen_call()
                    else:
                        self.gen_return()
                elif r == 8:
                    if self.loop_nesting <= 3:
                        r2 = self.u32() % 2
                        if r2 == 0:
                            self.gen_do_while_unif()
                        else:
                            self.gen_do_while_inf()
                elif r == 9:
                    r2 = self.u32() % 4
                    if r2 == 0:
                        self.gen_switch_unif()
                    elif r2 == 1 and self.loop_nesting > 0:
                        self.gen_switch_loop_count()
                    elif r2 in (1, 2) and not self.maximal:
                        self.gen_switch_multicase()
                    else:
                        self.gen_switch_var()
            self.gen_ballot()

    def gen_ballot(self):
        ops = self.ops
        if (self.u32() % 100) < 20:
            if len(ops) < 2 or not (ops[-1].type == OP_BALLOT or (ops[-1].type == OP_STORE and ops[-2].type == OP_BALLOT)):
                if not self.maximal:
                    self.push(OP_STORE, len(ops) + self.store_base)
                self.push(OP_BALLOT, 0)

        if (self.u32() % 100) < 10:
            if len(ops) < 2 or not (ops[-1].type == OP_STORE or (ops[-1].type == OP_BALLOT and ops[-2].type == OP_STORE)):
                if self.maximal:
                    self.push(OP_STORE, len(ops) + self.store_base)

        r = self.u32() % 10000
        if r < 3:
            self.push(OP_NOISE, 0)
        elif r < 10:
            self.push(OP_NOISE, 1)

    def generate(self):
        attempts = 0
        while True:
            self.ops = []
            while len(self.ops) < self.min_count:
                self.pick_op(1)
            if self.maximal:
                return
            # Retry until the program has some UCF results in it
            subgroup_size = 4
            while subgroup_size <= 128:
                simulate_flags(self, subgroup_size)
                subgroup_size *= 2
            if any(op.type == OP_BALLOT and op.case_value == 0 for op in self.ops):
                return
            attempts += 1
            if attempts > 10000:
                raise RuntimeError("no program with uniform control flow results")

    # ---- printCode -------------------------------------------------------------------------------------------------------

    def pad(self):
        return " " * self.indent

    def print_ballot(self, end_with_semicolon=False):
        text = self.pad() + "outputC.loc[gl_LocalInvocationIndex]++,"
        if self.elect and not (self.loop_nesting > 0 and self.maximal):
            text += "outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()"
        else:
            text += "outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)"
        if end_with_semicolon:
            text += ";\n"
        return text

    def print_code(self):
        functions = []
        main = []
        out = main
        self.indent = 4
        self.loop_nesting = 0
        func_num = 0
        local_index_count = 0
        ops = self.ops

        def emit(text):
            out.append(text)

        for i, op in enumerate(ops):
            t = op.type
            if t == OP_IF_MASK:
                if op.value == M64:
                    idx = self.u32() % 4
                    emit(f"{self.pad()}if (inputA.a[{idx}] == {idx}) {{\n")
                else:
                    v = [(op.bvalue >> (32 * k)) & 0xFFFFFFFF for k in range(4)]
                    emit(f"{self.pad()}if (testBit(uvec4(0x{v[0]:x}, 0x{v[1]:x}, 0x{v[2]:x}, 0x{v[3]:x}), gl_SubgroupInvocationID)) {{\n")
                self.indent += 4
            elif t == OP_IF_LOOPCOUNT:
                emit(f"{self.pad()}if (gl_SubgroupInvocationID == loopIdx{self.loop_nesting - 1}) {{\n")
                self.indent += 4
            elif t == OP_IF_LOCAL_INVOCATION_INDEX:
                emit(f"{self.pad()}if (gl_LocalInvocationIndex >= inputA.a[cmpIndex{local_index_count}]) {{\n")
                local_index_count += 1
                self.indent += 4
            elif t in (OP_ELSE_MASK, OP_ELSE_LOOPCOUNT, OP_ELSE_LOCAL_INVOCATION_INDEX):
                self.indent -= 4
                emit(f"{self.pad()}}} else {{\n")
                self.indent += 4
            elif t == OP_ENDIF:
                self.indent -= 4
                emit(f"{self.pad()}}}\n")
            elif t == OP_BALLOT:
                emit(self.print_ballot(True))
            elif t == OP_STORE:
                emit(f"{self.pad()}outputC.loc[gl_LocalInvocationIndex]++;\n")
                emit(f"{self.pad()}outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x{op.value:x};\n")
            elif t == OP_BEGIN_FOR_VAR:
                n = self.loop_nesting
                emit(f"{self.pad()}for (int loopIdx{n} = 0;\n")
                emit(f"{self.pad()}         loopIdx{n} < gl_SubgroupInvocationID + 1;\n")
                emit(f"{self.pad()}         loopIdx{n}++) {{\n")
                self.indent += 4
                self.loop_nesting += 1
            elif t in (OP_END_FOR_VAR, OP_END_FOR_UNIF, OP_END_FOR_INF):
                self.loop_nesting -= 1
                self.indent -= 4
                emit(f"{self.pad()}}}\n")
            elif t == OP_BEGIN_FOR_UNIF:
                n = self.loop_nesting
                emit(f"{self.pad()}for (int loopIdx{n} = 0;\n")
                emit(f"{self.pad()}         loopIdx{n} < inputA.a[{op.value}];\n")
                emit(f"{self.pad()}         loopIdx{n}++) {{\n")
                self.indent += 4
                self.loop_nesting += 1
            elif t == OP_BEGIN_FOR_INF:
                n = self.loop_nesting
                emit(f"{self.pad()}for (int loopIdx{n} = 0;;loopIdx{n}++,")
                self.loop_nesting += 1
                emit(self.print_ballot(False))
                emit(") {\n")
                self.indent += 4
            elif t == OP_BEGIN_DO_WHILE_UNIF:
                n = self.loop_nesting
                emit(f"{self.pad()}{{\n")
                self.indent += 4
                emit(f"{self.pad()}int loopIdx{n} = 0;\n")
                emit(f"{self.pad()}do {{\n")
                self.indent += 4
                emit(f"{self.pad()}loopIdx{n}++;\n")
                self.loop_nesting += 1
            elif t == OP_END_DO_WHILE_UNIF:
                self.loop_nesting -= 1
                self.indent -= 4
                emit(f"{self.pad()}}} while (loopIdx{self.loop_nesting} < inputA.a[{ops[op.value].value}]);\n")
                self.indent -= 4
                emit(f"{self.pad()}}}\n")
            elif t == OP_BEGIN_DO_WHILE_INF:
                n = self.loop_nesting
                emit(f"{self.pad()}{{\n")
                self.indent += 4
                emit(f"{self.pad()}int loopIdx{n} = 0;\n")
                emit(f"{self.pad()}do {{\n")
                self.indent += 4
                self.loop_nesting += 1
            elif t == OP_END_DO_WHILE_INF:
                self.loop_nesting -= 1
                emit(f"{self.pad()}loopIdx{self.loop_nesting}++;\n")
                self.indent -= 4
                emit(f"{self.pad()}}} while (true);\n")
                self.indent -= 4
                emit(f"{self.pad()}}}\n")
            elif t == OP_BREAK:
                emit(f"{self.pad()}break;\n")
            elif t == OP_CONTINUE:
                emit(f"{self.pad()}continue;\n")
            elif t == OP_ELECT:
                emit(f"{self.pad()}if (subgroupElect()) {{\n")
                self.indent += 4
            elif t == OP_RETURN:
                emit(f"{self.pad()}return;\n")
            elif t == OP_CALL_BEGIN:
                args = ", ".join(f"loopIdx{n}" for n in range(self.loop_nesting))
                emit(f"{self.pad()}func{func_num}({args});\n")
                out = functions
                params = ", ".join(f"int loopIdx{n}" for n in range(self.loop_nesting))
                emit(f"{self.pad()}void func{func_num}({params}) {{\n")
                self.indent += 4
                func_num += 1
            elif t == OP_CALL_END:
                self.indent -= 4
                emit(f"{self.pad()}}}\n")
                out = main
            elif t == OP_NOISE:
                if op.value == 0:
                    emit(f"{self.pad()}while (!subgroupElect()) {{}}\n")
                else:
                    emit(f"{self.pad()}if (inputA.a[0] == 12345) {{\n")
                    self.indent += 4
                    emit(f"{self.pad()}while (true) {{\n")
                    self.indent += 4
                    emit(self.print_ballot(True))
                    self.indent -= 4
                    emit(f"{self.pad()}}}\n")
                    self.indent -= 4
                    emit(f"{self.pad()}}}\n")
            elif t == OP_SWITCH_UNIF_BEGIN:
                emit(f"{self.pad()}switch (inputA.a[{op.value}]) {{\n")
                self.indent += 4
            elif t == OP_SWITCH_VAR_BEGIN:
                emit(f"{self.pad()}switch (gl_SubgroupInvocationID & 3) {{\n")
                self.indent += 4
            elif t == OP_SWITCH_LOOP_COUNT_BEGIN:
                emit(f"{self.pad()}switch (loopIdx{op.value}) {{\n")
                self.indent += 4
            elif t == OP_SWITCH_END:
                self.indent -= 4
                emit(f"{self.pad()}}}\n")
            elif t == OP_CASE_MASK_BEGIN:
                for b in range(32):
                    if (1 << b) & op.case_value:
                        emit(f"{self.pad()}case {b}:\n")
                emit(f"{self.pad()}{{\n")
                self.indent += 4
            elif t == OP_CASE_LOOP_COUNT_BEGIN:
                if op.case_value == 0xFFFFFFFF:
                    emit(f"{self.pad()}default: {{\n")
                else:
                    emit(f"{self.pad()}case {op.case_value}: {{\n")
                self.indent += 4
            elif t == OP_CASE_END:
                emit(f"{self.pad()}break;\n")
                self.indent -= 4
                emit(f"{self.pad()}}}\n")
            else:
                raise AssertionError(t)
        return "".join(functions), "".join(main), local_index_count



# ---- the simulation of `RandomProgram::execute(countOnly = true)`: only the ballots it flags as non uniform matter here -----------------


def size_mask(subgroup_size):
    return M128 if subgroup_size >= 128 else (1 << subgroup_size) - 1


GUARD = 1_500_000


def simulate_flags(program, subgroup_size):
    """Flags (`caseValue = 1`) the OP_BALLOTs that are not workgroup (WUCF) or subgroup (SUCF) uniform, for one subgroup size."""
    ops = program.ops
    stride = program.invocation_stride
    count = -(-stride // subgroup_size)
    full = size_mask(subgroup_size)
    wucf = program.test_type.startswith("workgroup")
    sucf = program.test_type.startswith("subgroup")

    def zeros():
        return [0] * count

    def band(a, b):
        return [x & y for x, y in zip(a, b)]

    def bnot(a):
        return [(~x) & M128 for x in a]

    def from_ballot(ballot):
        return [ballot & full] * count

    def any_(a):
        return any(x != 0 for x in a)

    class State:
        def __init__(self):
            self.active = zeros()
            self.cont = zeros()
            self.header = 0
            self.trip = 0
            self.is_loop = False
            self.is_call = False
            self.is_switch = False

    stack = [State() for _ in range(32)]
    for ident in range(stride):
        stack[0].active[ident // subgroup_size] |= 1 << (ident % subgroup_size)

    nesting = 0
    loop_nesting = 0
    i = 0
    n_ops = len(ops)
    guard = 0
    while i < n_ops:
        guard += 1
        if guard > GUARD:
            raise RuntimeError("simulation does not terminate")
        op = ops[i]
        t = op.type
        st = stack[nesting]
        if t == OP_BALLOT:
            active = st.active
            if wucf and any_(active) and not all(x == M128 for x in active):
                op.case_value = 1
            if sucf:
                for ident in range(0, stride, subgroup_size):
                    mask = active[ident // subgroup_size] & full
                    if mask != 0 and mask != full:
                        op.case_value = 1
        elif t == OP_STORE:
            pass
        elif t == OP_IF_MASK:
            nesting += 1
            stack[nesting].active = band(stack[nesting - 1].active, from_ballot(op.bvalue))
            stack[nesting].header = i
            stack[nesting].is_loop = False
            stack[nesting].is_switch = False
        elif t == OP_ELSE_MASK:
            stack[nesting].active = band(stack[nesting - 1].active, bnot(from_ballot(ops[st.header].bvalue)))
        elif t == OP_IF_LOOPCOUNT:
            n = nesting
            while not stack[n].is_loop:
                n -= 1
            trip = 1 << stack[n].trip
            nesting += 1
            stack[nesting].active = band(stack[nesting - 1].active, from_ballot(trip))
            stack[nesting].header = i
            stack[nesting].is_loop = False
            stack[nesting].is_switch = False
        elif t == OP_ELSE_LOOPCOUNT:
            n = nesting
            while not stack[n].is_loop:
                n -= 1
            trip = 1 << stack[n].trip
            stack[nesting].active = band(stack[nesting - 1].active, bnot(from_ballot(trip)))
        elif t == OP_IF_LOCAL_INVOCATION_INDEX:
            first = op.value % stride
            mask = zeros()
            for ident in range(first, count * subgroup_size):
                mask[ident // subgroup_size] |= 1 << (ident % subgroup_size)
            nesting += 1
            stack[nesting].active = band(stack[nesting - 1].active, mask)
            stack[nesting].header = i
            stack[nesting].is_loop = False
            stack[nesting].is_switch = False
        elif t == OP_ELSE_LOCAL_INVOCATION_INDEX:
            end = min(op.value % stride, count * subgroup_size)
            mask = zeros()
            for ident in range(0, end):
                mask[ident // subgroup_size] |= 1 << (ident % subgroup_size)
            stack[nesting].active = band(stack[nesting - 1].active, mask)
        elif t == OP_ENDIF:
            nesting -= 1
        elif t in (OP_BEGIN_FOR_UNIF, OP_BEGIN_FOR_VAR, OP_BEGIN_FOR_INF, OP_BEGIN_DO_WHILE_INF, OP_BEGIN_DO_WHILE_UNIF):
            nesting += 1
            loop_nesting += 1
            stack[nesting].active = list(stack[nesting - 1].active)
            stack[nesting].header = i
            stack[nesting].trip = 1 if t == OP_BEGIN_DO_WHILE_UNIF else 0
            stack[nesting].is_loop = True
            stack[nesting].is_switch = False
            stack[nesting].cont = zeros()
        elif t in (OP_END_FOR_UNIF, OP_END_DO_WHILE_UNIF, OP_END_FOR_VAR, OP_END_FOR_INF, OP_END_DO_WHILE_INF):
            if t != OP_END_DO_WHILE_UNIF:
                st.trip += 1
            st.active = [a | c for a, c in zip(st.active, st.cont)]
            st.cont = zeros()
            if t == OP_END_FOR_UNIF:
                again = st.trip < ops[st.header].value and any_(st.active)
            elif t == OP_END_DO_WHILE_UNIF:
                again = st.trip < ops[st.header].value and any_(st.active)
                if again:
                    st.trip += 1
            elif t == OP_END_FOR_VAR:
                trip_ballot = 0
                if subgroup_size != st.trip:
                    for bit in range(st.trip, 128):
                        trip_ballot |= 1 << bit
                st.active = band(st.active, from_ballot(trip_ballot))
                again = any_(st.active)
            else:
                again = any_(st.active)
            if again:
                i = st.header + 1
                continue
            loop_nesting -= 1
            nesting -= 1
        elif t == OP_BREAK:
            n = nesting
            mask = list(st.active)
            while True:
                stack[n].active = band(stack[n].active, bnot(mask))
                if stack[n].is_loop or stack[n].is_switch:
                    break
                n -= 1
        elif t == OP_CONTINUE:
            n = nesting
            mask = list(st.active)
            while True:
                stack[n].active = band(stack[n].active, bnot(mask))
                if stack[n].is_loop:
                    stack[n].cont = [c | m for c, m in zip(stack[n].cont, mask)]
                    break
                n -= 1
        elif t == OP_ELECT:
            nesting += 1
            stack[nesting].active = [0 if a == 0 else a & -a for a in stack[nesting - 1].active]
            stack[nesting].header = i
            stack[nesting].is_loop = False
            stack[nesting].is_switch = False
        elif t == OP_RETURN:
            mask = list(st.active)
            for n in range(nesting, -1, -1):
                stack[n].active = band(stack[n].active, bnot(mask))
                if stack[n].is_call:
                    break
        elif t == OP_CALL_BEGIN:
            nesting += 1
            stack[nesting].active = list(stack[nesting - 1].active)
            stack[nesting].is_loop = False
            stack[nesting].is_switch = False
            stack[nesting].is_call = True
        elif t == OP_CALL_END:
            st.is_call = False
            nesting -= 1
        elif t == OP_NOISE:
            pass
        elif t in (OP_SWITCH_UNIF_BEGIN, OP_SWITCH_VAR_BEGIN, OP_SWITCH_LOOP_COUNT_BEGIN):
            nesting += 1
            stack[nesting].active = list(stack[nesting - 1].active)
            stack[nesting].header = i
            stack[nesting].is_loop = False
            stack[nesting].is_switch = True
        elif t == OP_SWITCH_END:
            nesting -= 1
        elif t == OP_CASE_MASK_BEGIN:
            st.active = band(stack[nesting - 1].active, from_ballot(op.bvalue))
        elif t == OP_CASE_LOOP_COUNT_BEGIN:
            n = nesting
            l = loop_nesting
            while True:
                if stack[n].is_loop:
                    l -= 1
                    if l == ops[st.header].value:
                        break
                n -= 1
            if ((1 << stack[n].trip) & op.bvalue) != 0:
                st.active = list(stack[nesting - 1].active)
            else:
                st.active = zeros()
        elif t == OP_CASE_END:
            pass
        else:
            raise AssertionError(t)
        i += 1


HEADER = (
    "#version 450 core\n"
    "#extension GL_KHR_shader_subgroup_ballot : enable\n"
    "#extension GL_KHR_shader_subgroup_vote : enable\n"
    "#extension GL_NV_shader_subgroup_partitioned : enable\n"
    "#extension GL_EXT_subgroup_uniform_control_flow : enable\n"
    "#extension GL_EXT_maximal_reconvergence : require\n"
)

LAYOUT = (
    "layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;\n"
    "layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;\n"
    "layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;\n"
    "layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;\n"
    "layout(push_constant) uniform PC {\n"
    "   // set to the real stride when writing out ballots, or zero when just counting\n"
    "   int  invocationStride;\n"
    "   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders\n"
    "   int  width;\n"
    "   int  height;\n"
    "   uint primitiveStride;\n"
    "   uint subgroupStride;\n"
    "   uint enableInvocationIndex;\n"
    "};\n"
)

GLOBALS = (
    "int outLoc = 0;\n"
    "bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }\n"
    "uint elect() { return int(subgroupElect()) + 1; }\n"
)

NESTING_CASES = [(2, 250), (3, 250), (4, 250), (5, 100), (6, 50)]

# (group name, short name, test type of RandomProgram)
TEST_TYPES = [
    ("maximal", "maximal", "maximal"),
    ("subgroup_uniform_control_flow_elect", "sucf_elect", "subgroup_elect"),
    ("subgroup_uniform_control_flow_ballot", "sucf_ballot", "subgroup_ballot"),
    ("workgroup_uniform_control_flow_elect", "wucf_elect", "workgroup_elect"),
    ("workgroup_uniform_control_flow_ballot", "wucf_ballot", "workgroup_ballot"),
]

# The strides a device can end up with: 7 * 13 invocations, or rounded up to the subgroup size when it can run full subgroups.
STRIDES = [91, 92, 96, 128]


def any_letter(text, length):
    return any(c.isalpha() for c in text[:length])


def build_shader(test_type, functions, main_text, cmp_count):
    maximal = test_type == "maximal"
    header = HEADER if maximal else HEADER.replace("#extension GL_EXT_maximal_reconvergence : require\n", "")
    globals_text = GLOBALS + "".join(f"layout(constant_id = {10 + k}) const uint cmpIndex{k} = 0u;\n" for k in range(cmp_count))
    attributes = ("[[subgroup_uniform_control_flow]]\n" if test_type.startswith("subgroup") else "") + ("[[maximally_reconverges]]\n" if maximal else "")
    return (
        header
        + LAYOUT
        + globals_text
        + functions
        + "\n\n"
        + "void main()\n"
        + attributes
        + "{\n"
        + "\n"
        + main_text
        + "\n\n"
        + "\n"
        + "}\n"
    )


def generate(seed, nesting, stride, test_type):
    program = RandomProgram(seed, nesting, stride, test_type)
    program.generate()
    functions, main_text, cmp_count = program.print_code()
    return program, build_shader(test_type, functions, main_text, cmp_count), main_text


def main():
    only = sys.argv[1:]
    SRC.mkdir(parents=True, exist_ok=True)
    manifest = [
        "# Shader manifest for the random program cases of dEQP-VK.reconvergence ({maximal,subgroup_uniform_control_flow_*,workgroup_uniform_control_flow_*}.compute).",
        "#",
        "# @generated by hodow_cts/scripts/gen_reconvergence_maximal_compute.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/reconvergence/vktReconvergenceTests.cpp"',
        'rust_module = "reconvergence/compute_tests"',
        "",
    ]
    table = [
        "// @generated by hodow_cts/scripts/gen_reconvergence_maximal_compute.py - do not hand-edit.",
        "//",
        "// One row per case of the random program groups: the five masks and, per stride the device can end up with, the ops of the program and",
        "// the raw draws of the local index comparisons. See the script for the encoding.",
        "",
        "use super::compute_tests::{ReconvergenceCase, ReconvergenceVariant};",
        "",
        "pub static COMPUTE_CASES: &[ReconvergenceCase] = &[",
    ]
    total = 0
    shaders = 0
    skipped = []
    for group, short, test_type in TEST_TYPES:
        if only and short not in only:
            continue
        for nesting, num_tests in NESTING_CASES:
            if test_type != "maximal" and nesting >= 5:
                continue
            seed = 0
            for seed_group in range(8):
                for ndx in range(num_tests):
                    this_seed = seed
                    seed += 1
                    if ndx >= num_tests // 5:
                        continue
                    strides = [0] if test_type == "maximal" else STRIDES
                    variants = []
                    for stride in strides:
                        try:
                            program, source, main_text = generate(this_seed, nesting, stride or 91, test_type)
                        except RuntimeError:
                            # The simulation is too slow in Python (nested infinite loops that retire one lane per iteration): no program for this stride.
                            skipped.append((group, nesting, seed_group, ndx, stride))
                            continue
                        tokens = " ".join(op.token() for op in program.ops)
                        for variant in variants:
                            if variant["source"] == source and variant["tokens"] == tokens:
                                variant["strides"].append(stride)
                                break
                        else:
                            variants.append({"strides": [stride], "source": source, "tokens": tokens, "main": main_text, "program": program})
                    masks = ", ".join(f"0x{m:032x}" for m in RandomProgram(this_seed, nesting, 91, test_type).ballot_masks)
                    rows = []
                    base_key = f"reconvergence_compute_{short}_n{nesting}_s{seed_group}_{ndx}"
                    entries = []
                    for number, variant in enumerate(variants):
                        suffix = f"_v{number}" if number else ""
                        (SRC / f"{base_key}{suffix}.comp").write_text(variant["source"])
                        entries.append(
                            f'{{ name = "test{suffix}", template = "reconvergence_compute/{base_key}{suffix}.comp", stage = "comp", spirv_version = "spirv1.3" }}'
                        )
                        empty = "true" if not any_letter(variant["main"], min(len(variant["main"]), 20)) else "false"
                        strides_text = ", ".join(str(v) for v in variant["strides"] if v)
                        rows.append(f'ReconvergenceVariant {{ strides: &[{strides_text}], empty_main: {empty}, ops: "{variant["tokens"]}" }}')
                        shaders += 1
                    if entries:
                        manifest += [
                            "[[case]]",
                            f'name = "{base_key}"',
                            f'rust_const = "{base_key.upper()}"',
                            'rust_type = "SharedProgram"',
                            "programs = [ " + ", ".join(entries) + " ]",
                            "",
                        ]
                    table.append(
                        f'    ReconvergenceCase {{ group: "{group}", name: "{ndx}", nesting: {nesting}, seed_group: {seed_group}, masks: [{masks}], variants: &[{", ".join(rows)}] }},'
                    )
                    total += 1
    table.append("];")
    MANIFEST.write_text("\n".join(manifest))
    TABLE.write_text("\n".join(table) + "\n")
    print(f"wrote {total} cases, {shaders} shaders, {len(skipped)} (case, stride) pairs without a program")
    for entry in skipped:
        print("  no program:", entry)


if __name__ == "__main__":
    main()
