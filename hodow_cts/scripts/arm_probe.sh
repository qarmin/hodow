#!/usr/bin/env bash
# Asks, of each case in turn: does this take the GPU down by itself?
#
# It is the cheapest question there is about a finding, and for a long time the only way
# to ask it here was to bisect - nine oracle calls and nine reboots, most of an hour, to
# learn that a two-hundred-case group shrank to the one case that had already been named
# as the casualty. A probe answers the same thing in one run and one reboot per case, and
# answers it for the neighbours too, which is what turns one finding into the shape it
# belongs to.
#
# Two things it does that a stopwatch alone does not, both found by getting them wrong:
#
#   The verdict is the kernel's. galcore with `recovery=0` prints "Stop driver to keep
#   scene" when it gives up, and that is the difference between a case that is slow and a
#   case that ended the session. A case can report a pass *and* leave the driver dead -
#   the hang is in its teardown - and a timeout-only oracle calls that healthy. The other
#   direction matters as much: a case whose worker had to be killed after 60s with the
#   kernel saying nothing is `CLIENTHANG`, which is a real defect and a recoverable one,
#   and it is not a pass however the run's exit code came out.
#
#   Every case starts from a reboot, unless CLEAN_BOOT=0 says otherwise. A case that hangs
#   after five healthy ones in the same boot has been shown something quite different from
#   a case that hangs alone, and only the second is a one-case reproducer. Measured here:
#   `image_atomic_write_read` passes from a fresh boot and hangs in company.
#
#   A case that was never tested says so. `NOTSUPPORTED` is the driver refusing the case
#   (the whole `image_load_store.buffer.*` group here, for want of GL_EXT_texture_buffer)
#   and `NODRIVER` is no EGL display at all, which right after a reboot usually means the
#   compositor was not up yet - so that one is retried once before it is believed. Both
#   used to come out as `OTHER(exit 0)`, indistinguishable from each other and easy to
#   read as "nothing wrong here".
#
# A file of *globs* rather than case names is how a whole tree gets screened in an
# evening: each line is run as one process, so `dEQP-GLES31.functional.ssbo.layout.*`
# costs one driver bring-up instead of 2007. The verdicts mean the same thing, and a
# group that comes back HANG or FAIL is then worth re-probing case by case. Measured
# here: 103 groups covering 16867 GLES 3.1 cases took 53 minutes and found a group of
# 44 wrong-result cases nothing else had looked at, where one process per case would
# have been most of a day.
#
# Usage: arm_probe.sh <ip> <case-glob-or-file> [method] [user] [ssh-opts...]
#   CLEAN_BOOT=0    reboot only after a hang - faster, and a weaker claim
#   CASE_TIMEOUT=N  seconds before a case is called SLOW (default 60 + 40 per repeat)
#   REPEATS=N       run each case N times in one process, not once. Some cases hang on
#                   repetition rather than on the first run - measured here, one that
#                   passed twice alone hung on run 2, run 7 and run 3 of three further
#                   attempts - and a single run reports those as clean.

set -uo pipefail

ip=${1:?usage: arm_probe.sh <ip> <case-glob-or-file> [method] [user] [ssh-opts...]}
what=${2:?a case glob, or a file with one case per line}
method=${3:-sysrq}
user=${4:-root}
shift 4 2>/dev/null || shift $#
ssh_opts=("$@")

here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$(cd "$here/../.." && pwd)"

ssh_cmd=(ssh "${ssh_opts[@]}" -o ConnectTimeout=8 -o BatchMode=yes)
QUIET_UNITS=${HODOW_QUIET_UNITS:-ap600-launcher}
GAVE_UP='Stop driver to keep scene'

# A glob is expanded by the board's own binary, so the list is exactly what a run would
# draw rather than what this machine's build happens to know about.
if [ -f "$what" ]; then
    mapfile -t cases < "$what"
else
    mapfile -t cases < <("${ssh_cmd[@]}" "$user@$ip" "set -f; ./cts.sh list --case '$what'" 2>/dev/null | grep '^dEQP-')
fi
cases=("${cases[@]//$'\r'/}")
if [ "${#cases[@]}" -eq 0 ]; then
    echo "arm_probe: no cases matched '$what'" >&2
    exit 1
fi
echo "probing ${#cases[@]} case(s), one per process${REPEATS:+, ${REPEATS} run(s) each}${CLEAN_BOOT:+ (CLEAN_BOOT=$CLEAN_BOOT)}"

hangs=0
clienthangs=0
unsupporteds=0
index=0
for case in "${cases[@]}"; do
    [ -n "$case" ] || continue
    index=$((index + 1))
  for attempt in 1 2; do
    if [ "${CLEAN_BOOT:-1}" = 1 ] && ! "$here/arm_reboot.sh" "$ip" "$method" "$user" "${ssh_opts[@]}" >/dev/null 2>&1; then
        echo "the board did not come back from a reboot - stopping here" >&2
        exit 1
    fi
    for unit in $QUIET_UNITS; do
        "${ssh_cmd[@]}" "$user@$ip" "systemctl stop $unit 2>/dev/null; true" >/dev/null 2>&1
    done

    before=$("${ssh_cmd[@]}" "$user@$ip" "dmesg | grep -c '$GAVE_UP'" 2>/dev/null)
    case "${before:-}" in '' | *[!0-9]*) before=0 ;; esac

    # A case list with the name repeated runs it that many times in one process, which
    # `select_cases` honours deliberately.
    if [ "${REPEATS:-1}" -gt 1 ]; then
        run="set -f; : >/tmp/arm_probe_cases.txt; i=0; while [ \$i -lt ${REPEATS} ]; do echo '$case' >>/tmp/arm_probe_cases.txt; i=\$((i+1)); done; ./cts.sh -- --case-list /tmp/arm_probe_cases.txt"
    else
        run="set -f; ./cts.sh case '$case'"
    fi
    out=$(timeout "${CASE_TIMEOUT:-$((60 + 40 * ${REPEATS:-1}))}" "${ssh_cmd[@]}" "$user@$ip" \
        "$run >/tmp/arm_probe.out 2>&1; echo \"RC=\$?\"; tail -40 /tmp/arm_probe.out")
    rc=$?
    # The board's own exit code, not ssh's: 2 is "no driver", and the pipeline that used
    # to carry it home returned `tail`'s instead, which is always 0.
    remote_rc=$(sed -n 's/^RC=//p' <<<"$out" | head -1)

    after=$("${ssh_cmd[@]}" "$user@$ip" "dmesg | grep -c '$GAVE_UP'" 2>/dev/null)
    case "${after:-}" in '' | *[!0-9]*) after=$before ;; esac

    # Read the counts rather than matching the summary as text: `Passed: 0/1 (0.0%)`
    # contains a 1, and a pattern loose enough to accept it calls a case that never
    # produced a verdict a pass. That is what this is here to tell apart.
    count() { sed -n "s;.*$1:[[:space:]]*\([0-9]*\)/.*;\1;p" <<<"$out" | head -1; }
    passed=$(count Passed)
    failed=$(count Failed)
    crashed=$(count Crashed)
    unsupported=$(count 'Not supported')

    if [ "$after" -gt "$before" ]; then
        verdict=HANG
        hangs=$((hangs + 1))
    elif [ "$rc" -eq 124 ]; then
        # Nothing from the kernel, and the run never came back on its own.
        verdict=SLOW
    elif [ "${crashed:-0}" -gt 0 ]; then
        # The harness gave up on its own worker while the kernel stayed quiet: the client
        # is stuck in the driver and killing it is enough. Not the same as a GPU that has
        # to be rebooted out of, and not a pass either.
        verdict=CLIENTHANG
        clienthangs=$((clienthangs + 1))
        grep -q "no progress for" <<<"$out" || verdict=CRASH
    elif [ "${failed:-0}" -gt 0 ]; then
        verdict=FAIL
    elif [ "${passed:-0}" -gt 0 ]; then
        verdict=PASS
    elif [ "${unsupported:-0}" -gt 0 ]; then
        # The driver refused the case. Nothing was tested, and counting it with the
        # passes is how a probe over a whole group comes back clean having asked nothing.
        verdict=NOTSUPPORTED
        unsupporteds=$((unsupporteds + 1))
    elif [ "${remote_rc:-}" = 2 ]; then
        verdict=NODRIVER
    else
        verdict="OTHER(exit ${remote_rc:-$rc})"
    fi

    # No display is almost always the compositor not being up yet, a second after a
    # reboot. One more try rather than a recorded non-answer.
    [ "$verdict" = NODRIVER ] && [ "$attempt" = 1 ] && { sleep 15; continue; }
    break
  done
    printf '%-14s %s\n' "$verdict" "$case"

    # Anything left in uninterruptible sleep is in the driver and cannot be killed, so
    # whatever runs next would be running against a machine that is already gone. The
    # reboot only has to happen here when the loop is not about to do one anyway.
    stuck=$("${ssh_cmd[@]}" "$user@$ip" 'ps -eo stat,comm | grep -c "^D.*hodow_cts"' 2>/dev/null)
    case "${stuck:-}" in '' | *[!0-9]*) stuck=0 ;; esac
    # A case the driver refused, or one that found no driver at all, never dispatched
    # anything - rebooting after it costs 47s to restore a GPU nothing has touched, and a
    # screen over an unsupported family is otherwise almost entirely reboots.
    settled=$verdict
    case "$verdict" in PASS | NOTSUPPORTED | NODRIVER) settled=PASS ;; esac
    if [ "$stuck" -gt 0 ] || { [ "$settled" != PASS ] && { [ "${CLEAN_BOOT:-1}" != 1 ] || [ "$index" = "${#cases[@]}" ]; }; }; then
        "$here/arm_reboot.sh" "$ip" "$method" "$user" "${ssh_opts[@]}" >/dev/null 2>&1 \
            || { echo "the board did not come back from a reboot - stopping here" >&2; exit 1; }
    fi
done

echo
echo "$hangs of ${#cases[@]} took the GPU down on its own (HANG)."
echo "$clienthangs of ${#cases[@]} left the client stuck while the kernel stayed quiet (CLIENTHANG)."
[ "$unsupporteds" -gt 0 ] && echo "$unsupporteds of ${#cases[@]} were never tested at all (NOTSUPPORTED)."
exit 0
