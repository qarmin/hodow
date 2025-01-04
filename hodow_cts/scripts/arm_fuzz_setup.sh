#!/usr/bin/env bash
# Everything that has to happen once, before a fuzzing campaign is left running on an ARM
# board: check this machine has the tooling, cross-build, deploy, confirm the board's
# driver answers, and prove the fuzzer itself works against that driver.
#
# That last step is the one worth waiting for. A fuzzer wired up wrong and a fuzzer with
# nothing to find produce identical output, so "it ran and found nothing" is not evidence
# of anything. `fuzz selftest` injects faults whose correct answer is known in advance -
# a crash, a hang, a driver poisoned for the next case, a machine that never came back -
# and checks the pipeline arrived at exactly that answer, on this board, on this driver.
#
# Starts nothing: a campaign is a separate, deliberate command, printed at the end.
# Nothing here is destructive beyond overwriting ~/hodow_cts and ~/cts.sh on the board.
#
# Usage: just arm-fuzz-setup <ip> [user]
#        hodow_cts/scripts/arm_fuzz_setup.sh <ip> [user]

set -uo pipefail

ip=${1:-}
user=${2:-root}
if [ -z "$ip" ]; then
    echo "usage: $0 <ip> [user]" >&2
    exit 1
fi
remote="$user@$ip"

cd "$(dirname "${BASH_SOURCE[0]}")/../.."
nightly=$(grep -m1 '^NIGHTLY' justfile | sed 's/.*"\(.*\)".*/\1/')

fail=0
step() { printf '\n\033[1m=== %s ===\033[0m\n' "$*"; }
ok() { printf '  \033[32mOK\033[0m   %s\n' "$*"; }
bad() {
    printf '  \033[31mFAIL\033[0m %s\n' "$*"
    fail=1
}

# A tty only when there is one to hand on: `ssh -t` without one warns and fills the
# output with carriage returns, which is exactly what someone piping this into a file
# does not want.
tty=()
[ -t 1 ] && tty=(-t)

# Whatever the justfile decided every ssh to a board needs - a key and a known_hosts file
# on a machine whose ~/.ssh is not usable, nothing at all on an ordinary one. Passed in
# rather than recomputed, so there is one place that decides it.
read -ra ssh_opts <<< "${HODOW_SSH_OPTS:-}"

step "1/5  tooling on this machine"
missing=0
for tool in just cargo ssh scp; do
    if command -v "$tool" >/dev/null 2>&1; then
        ok "$tool"
    else
        bad "$tool is not installed"
        missing=1
    fi
done
# cargo-zigbuild and zig are what make the cross-build work without a distro
# cross-toolchain or an ARM sysroot; nothing else in this script needs them.
for tool in zig cargo-zigbuild; do
    if command -v "$tool" >/dev/null 2>&1; then
        ok "$tool"
    else
        bad "$tool is missing - needed to cross-build for the board"
        echo "         cargo install cargo-zigbuild    and install zig (or: pip install ziglang)"
        missing=1
    fi
done
if [ -n "$nightly" ] && rustup toolchain list 2>/dev/null | grep -q "^$nightly"; then
    ok "toolchain $nightly"
else
    bad "toolchain $nightly is missing - the ARM build needs it (per-arch feature() lists are E0554 on stable)"
    echo "         rustup toolchain install $nightly"
    missing=1
fi
[ "$missing" -eq 0 ] || {
    echo
    echo "Install the above and run this again. Nothing has been changed."
    exit 1
}

step "2/5  is the board reachable"
if ssh "${ssh_opts[@]}" -o ConnectTimeout=10 -o BatchMode=yes "$remote" 'uname -srm; echo "up $(cut -d" " -f1 /proc/uptime)s"'; then
    ok "ssh to $remote works without a password prompt"
else
    bad "cannot reach $remote over ssh - fix that first, nothing below will work"
    echo "       (a password prompt also fails here: this needs key-based login, because the"
    echo "        campaign commands run unattended)"
    exit 1
fi

step "3/5  cross-build and deploy (binary + cts.sh; nothing is run on the board)"
if just install-arm-cts "$ip" 0 "$user"; then
    ok "hodow_cts and cts.sh are on the board"
else
    bad "deploy failed"
    exit 1
fi

step "4/5  does the board's OpenGL ES driver answer"
# ~/cts.sh defaults XDG_RUNTIME_DIR and WAYLAND_DISPLAY, which is the whole reason it
# exists: over ssh neither is set, and on i.MX/Vivante the compositor is the only route
# to an EGL display.
if ssh "${ssh_opts[@]}" "${tty[@]}" "$remote" './cts.sh env'; then
    ok "a driver came up and named itself"
else
    bad "no driver reachable"
    echo "       If Weston runs as another user or on another socket, find the right values:"
    echo "         ssh $remote 'XDG_RUNTIME_DIR=/run/user/1000 WAYLAND_DISPLAY=wayland-1 ./cts.sh env'"
    echo "       and then use the same pair for every command below."
    exit 1
fi

step "5/5  does the fuzzer work on this driver"
echo "  Minutes, not seconds: this injects a crash, a hang, a poisoned driver, an"
echo "  order-dependent failure and a machine that never came back, and checks each"
echo "  one was found AND attributed to the right case. Output appears as it goes."
echo
if ssh "${ssh_opts[@]}" "${tty[@]}" "$remote" './cts.sh fuzz selftest'; then
    ok "every injected fault was found and attributed correctly"
else
    bad "the gate did not pass here - do not trust a campaign on this board until it does"
fi

printf '\n\033[1m=== what to run next ===\033[0m\n'
cat <<NEXT

  Start a campaign. It runs detached on the board and then follows the log, so Ctrl-C
  stops the following and not the campaign, and a dropped ssh session costs nothing:

      just arm-fuzz $ip run --case 'dEQP-GLES*'

  Look in on it at any time, from here:

      just arm-fuzz $ip status

  When the board wedges and you have power-cycled it, say what happened - the fuzzer
  does not guess, and the in-flight group is waiting for your verdict:

      just arm-fuzz $ip gpucrash                     the GPU hung
      just arm-fuzz $ip systemcrash                  the whole machine went down
      just arm-fuzz $ip continue                     carry on, nothing special to record
      just arm-fuzz $ip continue --last-was-fine     you stopped it yourself

  Whatever the session printed is kept here, under tmp/logs/arm-fuzz/, newest at:

      tmp/arm-fuzz-last.log

  Bring everything home and read it without ssh:

      just arm-fuzz-fetch $ip
      just cts-fuzz status --dir tmp/cts-fuzz/$ip/<campaign>

  A finding's minimised sequence replays straight back:

      hodow_cts --case-list tmp/cts-fuzz/$ip/<campaign>/findings/0001-crash/repro.txt

NEXT

if [ "$fail" -eq 0 ]; then
    printf '\033[32mready\033[0m\n'
else
    printf '\033[31msomething needs attention (see FAIL above)\033[0m\n'
fi
exit "$fail"
