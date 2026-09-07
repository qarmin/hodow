Title: `RDSEED` (`0F C7 /7`) emulated as `RDPID` - random `_rdseed32_step`/`_rdseed64_step` results, plus 6 unimplemented opcodes

I'm building an internal tool that runs a large x86_64 SIMD/CPU-instruction test suite (each test asserts a concrete result captured from real hardware) natively and under an emulator, to catch hardware/firmware bugs rather than app bugs - the emulator is just a convenient second "CPU" to diff against. I ran it under box64 the same way. I already ran the same idea against `rustc_codegen_gcc` and found a few issues there too. Separately reported a batch of AI-assisted findings in this repo before (#4214, unrelated wrappers/glue code) - this issue is a different, empirical kind of finding: real behavioral divergence under actual execution, not code reading.

Tested against commit `b5697f4` (`b5697f410770bf71d688c44b2cbb533053dba2d7`), three ways: box64 built directly on an x86_64 host (no `ARM_DYNAREC`/`RV64_DYNAREC` - falls back to the plain C interpreter), box64 cross-built for aarch64 (`-DARM64=1`, real `ARM_DYNAREC` JIT) run under `qemu-aarch64`, and box64 cross-built for riscv64 (`-DRV64=1`, real `RV64_DYNAREC` JIT) run under `qemu-riscv64`.

Coverage note first: the full suite is ~19k cases up to AVX-512/GFNI, but box64's CPUID emulation (`src/os/my_cpuid.c`) doesn't advertise AVX-512 or GFNI at all, so only the ~3900 cases up to AVX2/AES/SHA/RDRAND/ADX actually run against it - not a bug, just why the numbers below stop where they do.

### `RDSEED` (`0F C7 /7`, no mandatory prefix) is implemented as `RDPID`

This is the concrete, reproducible one. Per the SDM, `NP 0F C7 /7` is `RDSEED r32/r64` and `F3 0F C7 /7` is `RDPID r32` - two different instructions that share a ModRM.reg slot and are disambiguated only by the `F3` prefix. box64's interpreter handles reg=7 unconditionally as `RDPID`, with no prefix check, so plain `RDSEED` decodes into this branch instead of ever reaching a real RDSEED implementation:

https://github.com/ptitSeb/box64/blob/b5697f410770bf71d688c44b2cbb533053dba2d7/src/emu/x64run0f.c#L1845-L1872

```c
case 6: /* RDRAND Ed */
    RESET_FLAGS(emu);
    ...
    SET_FLAG(F_CF);
    if (rex.w)
        ED->q[0] = get_random64();
    else {
        ED->dword[0] = get_random32();
        ...
    }
    break;
case 7: /* RDPID Ed */
    ED->q[0] = helper_getcpu(emu);
    break;
```

`RDRAND` (reg=6, right next to it) is implemented correctly and does set `F_CF`. The `RDPID`-labeled reg=7 branch never touches any flag. The exact same mistake is duplicated in the ARM64 dynarec (so it's not just an interpreter fallback thing):

https://github.com/ptitSeb/box64/blob/b5697f410770bf71d688c44b2cbb533053dba2d7/src/dynarec/arm64/dynarec_arm64_0f.c#L2684-L2711

```c
case 7:
    INST_NAME("RDPID Ed");
    GETED(0);
    CALL_(const_helper_getcpu, ed, x2);
    break;
```

The RISC-V64 dynarec has no case for `0xC7` register-form at all (falls to `DEFAULT`, i.e. the interpreter), so it inherits the same bug through the interpreter fallback:

https://github.com/ptitSeb/box64/blob/b5697f410770bf71d688c44b2cbb533053dba2d7/src/dynarec/rv64/dynarec_rv64_0f.c#L2817-L2826

What this actually does to guest code: `rustc`'s codegen for `_rdseed32_step`/`_rdseed64_step` is

```asm
rdseed %ecx
mov    $0x1,%eax
cmovae %ecx,%eax   ; on real hardware: CF=0 (failure) -> return the (zeroed) value in ecx
ret
```

Since box64 never sets `F_CF` for this opcode, whatever `CF` happened to be left over from earlier code decides whether `cmovae` fires, and when it does, `eax` gets loaded not with 0 (what real hardware would leave in the destination on failure) but with whatever `helper_getcpu()` put there - the calling CPU's core id. That's exactly what I saw: the "step" functions don't fail with a fixed wrong value, they return small integers that change run to run (2, 7, 9, 10, 11, 13, 14, 17, 18, 21, 22 all observed across repeated runs on a 24-core host) - consistent with core ids, not with any RDSEED-shaped bug. Repeated runs on real hardware return 1 every single time; every backend of box64 is flaky on this.

Fix direction: add a real `F3`-prefix check before dispatching to `RDPID`, and add an actual `RDSEED` implementation (mirroring the `RDRAND` branch, using a real RNG source and explicitly setting `F_CF`) for the no-prefix case. `RDPID` should then live behind its own prefix-gated path instead of unconditionally owning reg=7.

### Six opcodes with no implementation at all (clean, deterministic `SIGILL` on every box64 backend)

All six pass natively and reliably `SIGILL` identically on the x86_64-host interpreter, the aarch64 dynarec and the riscv64 dynarec - no flakiness, no backend differences:

- `RDRAND`/`RDSEED`, 16-bit operand form (`66 0F C7 /6`, `66 0F C7 /7`) - `src/emu/x64run660f.c` has no `case 0xC7` at all, so the 16-bit forms never reach any handler (the 32-/64-bit forms at `src/emu/x64run0f.c` do, see above).
- `XSAVEOPT`/`XSAVEOPT64` (`0F AE /6`) - the `0F AE` group implements reg 0/1/2/3/4/5/7 (`FXSAVE`/`FXRSTOR`/`LDMXCSR`/`STMXCSR`/`XSAVE`/`XRSTOR`/`CLFLUSH`) but reg=6 falls straight to `default: return 0`:
  https://github.com/ptitSeb/box64/blob/b5697f410770bf71d688c44b2cbb533053dba2d7/src/emu/x64run0f.c#L1396-L1444
- `XSAVEC`/`XSAVEC64` (`0F C7 /4`, memory operand) - the memory-operand half of the same `0xC7` case implements only `case 1` (`CMPXCHG8B`/`CMPXCHG16B`); reg=4 falls to the same `default: return 0`:
  https://github.com/ptitSeb/box64/blob/b5697f410770bf71d688c44b2cbb533053dba2d7/src/emu/x64run0f.c#L1873-L1908

Minor/weaker note, probably not worth acting on: `XGETBV` (`0F 01 D0`) also `SIGILL`s in my run, but that's because our test calls it with `ECX=1`, and box64 explicitly faults on any nonzero `ECX`:
https://github.com/ptitSeb/box64/blob/b5697f410770bf71d688c44b2cbb533053dba2d7/src/emu/x64run0f.c#L122-L131
Only `XCR0` (`ECX=0`) is architecturally defined, so this is arguably box64 being *more* correct than the AMD chip I tested on, which tolerates `ECX=1` and returns a value instead of `#GP`ing. Including it for completeness, not as a real bug.

### Open, not independently reproducible: `SHA-NI` `SIGSEGV`s on the RISC-V64 dynarec, but only inside a larger binary

Six of the seven `SHA-NI` intrinsics (`_mm_sha1msg1_epu32`, `_mm_sha1msg2_epu32`, `_mm_sha1nexte_epu32`, `_mm_sha256msg1_epu32`, `_mm_sha256msg2_epu32`, `_mm_sha256rnds2_epu32` - `_mm_sha1rnds4_epu32` is the one that's fine) reliably `SIGSEGV` (6/6 tries, real core dump, not `SIGILL`) under the riscv64 dynarec when called from inside my full test-suite binary, at the very first `SHA` case tried. I could not reproduce it in isolation: the exact same call, same inputs, in a minimal binary that does nothing else first, passes every time on every backend including riscv64. So this looks state-dependent (JIT translation-cache contents, register allocation, something built up by whatever ran before it) rather than an opcode/operand problem, and I don't have a clean enough repro to file with confidence yet - flagging it here in case it rings a bell, rather than as a confirmed bug.

### Reproducing this

Minimal standalone harness (no dependency on my larger project) attached: [box64_repro.zip](https://github.com/user-attachments/files/31899312/box64_repro.zip). `just setup` (installs `qemu-user` + the aarch64/riscv64 cross-compilers if missing, builds box64 all three ways) then `just matrix` prints one table, all three box64 targets plus native, all 16 cases:

One real run (`rdseed32_step`/`rdseed64_step` will show different numbers, or even `pass`, every time you re-run it - that's the point, see above; the `SHA-NI` rows below all show `pass` here for the reason explained above):

```
case              native          box64-x86       box64-aarch64   box64-riscv64
rdrand16_step     pass            SIGILL          SIGILL          SIGILL
rdseed16_step     pass            SIGILL          SIGILL          SIGILL
xgetbv            pass            SIGILL          SIGILL          SIGILL
xsaveopt          pass            SIGILL          SIGILL          SIGILL
xsavec            pass            SIGILL          SIGILL          SIGILL
xsaveopt64        pass            SIGILL          SIGILL          SIGILL
xsavec64          pass            SIGILL          SIGILL          SIGILL
rdseed32_step     pass            pass            pass            fail(2)
rdseed64_step     pass            fail(18)        fail(2)         fail(2)
sha1msg1_epu32    pass            pass            pass            pass
sha1msg2_epu32    pass            pass            pass            pass
sha1nexte_epu32   pass            pass            pass            pass
sha1rnds4_epu32   pass            pass            pass            pass
sha256msg1_epu32  pass            pass            pass            pass
sha256msg2_epu32  pass            pass            pass            pass
sha256rnds2_epu32 pass            pass            pass            pass
```
