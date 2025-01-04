#!/bin/sh
# Shorthands for running hodow_cts on a board, deployed next to the binary as ~/cts.sh
# by `just install-arm-cts`. There is no repo and no justfile there, so this file is the
# whole of the convenience layer.
#
# Its real job is the environment. On an i.MX/Vivante board the compositor is the only
# route to an EGL display (see hodow_cts/src/eglu/mod.rs, and the same finding in
# hodow_gpu/src/opengl/context.rs), and an SSH session sets neither variable - so
# without them every run reports "no driver" and says nothing about the board. Both are
# only *defaulted* here, never overridden, so a board whose Weston runs as another user
# or on another socket needs no edit:
#
#     XDG_RUNTIME_DIR=/run/user/1000 WAYLAND_DISPLAY=wayland-1 ./cts.sh run
#
# POSIX sh on purpose - a Yocto image is not guaranteed to ship bash.
#
# Usage: ./cts.sh <verb> [args...]

set -u

: "${XDG_RUNTIME_DIR:=/run/user/0}"
: "${WAYLAND_DISPLAY:=wayland-0}"
export XDG_RUNTIME_DIR WAYLAND_DISPLAY

# A crashing worker drops a core dump the size of its address space, and a board's
# rootfs fills long before a run of a few thousand cases finishes. The isolate parent
# already reports which case died and how, so the dump adds nothing the log does not.
ulimit -c 0 2>/dev/null || true

here=$(dirname "$0")
cts="$here/hodow_cts"
fuzz_dir="${HODOW_CTS_FUZZ_DIR:-$HOME/hodow-cts-fuzz}"
fuzz_log="$fuzz_dir/run.log"
kernel_log="$fuzz_dir/kernel.log"
kernel_pidfile="$fuzz_dir/kernel-follow.pid"

usage() {
    cat <<'EOF'
./cts.sh <verb> [args...]   hodow_cts with XDG_RUNTIME_DIR and WAYLAND_DISPLAY set

  env                    what this sets, whether the compositor socket is there, and
                         which driver answers (brings one case up, so it needs a GPU)
  run [args]             every ported OpenGL ES case (dEQP-GLES*)
  gles2|gles3|gles31     one root only
  case '<glob>' [args]   a narrower selection, e.g. 'dEQP-GLES31.functional.compute.*'
  list [args]            what is implemented, without touching a driver
  diag                   what is stuck, while it is still stuck: D-state tasks and the
                         kernel stacks they are blocked in, plus dmesg. Touches no driver
  clean                  remove core dumps left in the home directory
  -- [args]              pass everything straight through to hodow_cts

Fuzzing which cases share a process, and in what order:

  fuzz <verb> [args]     pass through to `hodow_cts fuzz`
  status                 where the campaign is, and whether it is waiting on you
  continue               carry on; an unfinished group counts as having killed the box
  gpucrash               ...and the GPU hung
  systemcrash            ...and the whole machine went down
  log                    follow the campaign log

`fuzz run` and `fuzz continue` (and their shorthands) start detached and then follow
the log, so Ctrl-C stops the following and not the campaign, and a dropped SSH session
costs nothing. Everything else runs in the foreground.

The *kernel* log comes along either way, because that is where the GPU driver says what
happened and none of it reaches hodow_cts' own output. A foreground verb prints what the
kernel said while it ran; a campaign gets a follower into kernel.log in its directory,
which `just arm-fuzz-fetch` brings home with everything else.

Exit code is hodow_cts's own, so 2 still means "no driver reachable", not a failure.
Output goes to the terminal; redirect it to keep it:  ./cts.sh run > cts.log 2>&1
EOF
}

# The kernel's own account of a campaign, next to it so it is fetched with it.
#
# This is where a Vivante driver says what happened - the `*** GPU DRV CONFIG ***` banner
# and the reset lines around it - and none of that ever reaches hodow_cts' output: the
# driver talks to the kernel log, not to its caller. It also outlives a power cut, unlike
# the ring buffer itself, which is the case this exists for.
#
# Kernel messages only (`-k`): a full journal on a board doing nothing else is mostly
# systemd chatter, and this file has to be able to sit on an SD card for days. Note
# journald rate-limits what it accepts - "Forwarding to syslog missed N messages" in a
# board's own log is that happening - so a driver spamming faster than the limit loses
# lines either way; `dmesg -w` is the fallback and reads /dev/kmsg directly.
follow_kernel_log() {
    if [ -f "$kernel_pidfile" ] && kill -0 "$(cat "$kernel_pidfile" 2>/dev/null)" 2>/dev/null; then
        return 0
    fi
    # `nohup` and not `setsid` here, unlike the campaign itself: nohup execs rather than
    # forks, so `$!` is the follower's real pid and the guard above can tell a live one
    # from a stale pidfile. A power cut leaves the latter, which is exactly when the next
    # `continue` should start a fresh follower.
    if command -v journalctl >/dev/null 2>&1; then
        nohup journalctl -kf --no-pager >> "$kernel_log" 2>&1 &
    elif command -v dmesg >/dev/null 2>&1; then
        nohup dmesg -w >> "$kernel_log" 2>&1 &
    else
        return 0
    fi
    echo $! > "$kernel_pidfile"
    echo "kernel log: following into $kernel_log (pid $(cat "$kernel_pidfile"))"
}

# What the kernel said while a foreground run was going on, printed after it.
#
# Same reasoning as the follower above, and the same reason both exist: a run in the
# foreground is over in minutes and its output is already being captured by whoever
# started it, so a snapshot of the window it occupied is enough and needs no lifecycle.
# A campaign is hours and may end in a power cut, which is what the follower is for.
with_kernel_log() {
    start=$(date +%s)
    "$@"
    rc=$?
    echo
    echo "=== kernel log during this run - the driver reports here and nowhere else ==="
    if command -v journalctl >/dev/null 2>&1; then
        journalctl -k --since "@$start" --no-pager 2>/dev/null | tail -200
    elif command -v dmesg >/dev/null 2>&1; then
        # No way to ask dmesg for a window, so the tail is the best available answer.
        dmesg | tail -60
    else
        echo "(no journalctl and no dmesg on this board)"
    fi
    return $rc
}

# Starts a campaign in its own session and then follows its log.
#
# The point is that the terminal and the campaign are separate things: an overnight run
# must not die with the SSH session it was started from, and Ctrl-C has to be safe to
# press. Anything that is not `run`/`continue` finishes in seconds and stays in the
# foreground, where its exit code is worth something.
detached_fuzz() {
    mkdir -p "$fuzz_dir"
    follow_kernel_log
    if command -v setsid >/dev/null 2>&1; then
        setsid nohup "$cts" fuzz "$@" >> "$fuzz_log" 2>&1 &
    else
        nohup "$cts" fuzz "$@" >> "$fuzz_log" 2>&1 &
    fi
    campaign_pid=$!
    echo "started detached as pid $campaign_pid, appending to $fuzz_log"
    echo "Ctrl-C stops the following below, not the campaign. './cts.sh status' to check on it."
    echo
    sleep 1
    # The follow has to end when the campaign does. A bare `tail -f` never returns, which
    # is invisible to a person (they press Ctrl-C) and fatal to a script: a campaign that
    # stopped because the driver is gone leaves the caller following a log nothing will
    # ever append to, so the board waits to be rebooted by a loop that is itself waiting.
    if tail --help 2>&1 | grep -q -- --pid; then
        tail -f --pid="$campaign_pid" "$fuzz_log"
    else
        tail -f "$fuzz_log"
    fi
}

# A campaign directory wants a name a person can read, and only the shell here knows
# what time it is locally - hodow_cts deliberately never formats a clock (see
# hodow_cts/src/fuzz/store.rs). Skipped if the caller named one, which is how
# `just arm-fuzz` passes the *host's* time instead of the board's.
run_fuzz() {
    verb=$1
    shift
    case "$verb" in
        run)
            case " $* " in
                *" --label "*) : ;;
                *) set -- "$@" --label "$(date +%Y%m%d-%H%M%S)" ;;
            esac
            detached_fuzz run "$@"
            ;;
        continue) detached_fuzz continue "$@" ;;
        *) "$cts" fuzz "$verb" "$@" ;;
    esac
}

if [ ! -x "$cts" ]; then
    echo "error: no executable hodow_cts next to $0" >&2
    echo "       deploy it with 'just install-arm-cts <ip>' from the repo" >&2
    exit 1
fi

verb=${1-}
[ $# -gt 0 ] && shift

case "$verb" in
    "" | -h | --help | help)
        usage
        ;;
    env)
        echo "XDG_RUNTIME_DIR = $XDG_RUNTIME_DIR"
        echo "WAYLAND_DISPLAY = $WAYLAND_DISPLAY"
        if [ -e "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; then
            echo "socket          = present"
        else
            echo "socket          = MISSING - is the compositor running, and as this user?"
        fi
        echo
        # The cheapest thing that actually brings a driver up and makes it say who it is.
        with_kernel_log "$cts" --case 'dEQP-GLES2.functional.negative_api.buffer.bind_buffer' "$@"
        ;;
    run)
        with_kernel_log "$cts" --case 'dEQP-GLES*' "$@"
        ;;
    gles2)
        with_kernel_log "$cts" --case 'dEQP-GLES2.*' "$@"
        ;;
    gles3)
        with_kernel_log "$cts" --case 'dEQP-GLES3.*' "$@"
        ;;
    gles31)
        with_kernel_log "$cts" --case 'dEQP-GLES31.*' "$@"
        ;;
    case)
        if [ $# -eq 0 ]; then
            echo "error: 'case' needs a glob, e.g. ./cts.sh case 'dEQP-GLES31.functional.compute.*'" >&2
            exit 1
        fi
        glob=$1
        shift
        with_kernel_log "$cts" --case "$glob" "$@"
        ;;
    list)
        "$cts" --list "$@"
        ;;
    diag)
        # For the state a wedged board is in *before* it is rebooted, which is the only
        # time any of this can be read. A process blocked in the GPU driver is in state
        # D: SIGKILL is recorded and not delivered, so nothing retires it and the board
        # cannot shut down either - init waits out its stop timeout on every one of them,
        # which is why "reboot" takes minutes rather than seconds. The kernel stack names
        # the driver call that is not returning.
        echo "=== when ==="
        date
        uptime
        echo
        echo "=== tasks in uninterruptible sleep (D) - these are what cannot be killed ==="
        # No `ps -o stat` on busybox, so this reads /proc directly and works either way.
        found=0
        for d in /proc/[0-9]*; do
            pid=${d#/proc/}
            state=$(sed -n 's/^State:[[:space:]]*//p' "$d/status" 2>/dev/null)
            case "$state" in
                D*) ;;
                *) continue ;;
            esac
            found=$((found + 1))
            echo "--- pid $pid  state $state"
            echo "    cmd:   $(tr '\0' ' ' < "$d/cmdline" 2>/dev/null)"
            echo "    wchan: $(cat "$d/wchan" 2>/dev/null)"
            if [ -r "$d/stack" ]; then
                echo "    kernel stack:"
                sed 's/^/      /' "$d/stack" 2>/dev/null
            else
                echo "    kernel stack: unreadable (needs root and CONFIG_STACKTRACE)"
            fi
        done
        [ "$found" -eq 0 ] && echo "none - nothing is stuck in the kernel right now"
        echo
        echo "=== GPU driver: is a hang survivable at all ==="
        # `recovery=0` is the setting that decides everything else here: galcore's monitor
        # timer still notices the hang and dumps the GPU state, but then prints "Stop
        # driver to keep scene" instead of resetting - so every client waiting on the GPU
        # waits forever, in D, and nothing short of a reboot clears it.
        if [ -d /sys/module/galcore/parameters ]; then
            for p in recovery stuckDump powerManagement; do
                [ -r "/sys/module/galcore/parameters/$p" ] && echo "  galcore.$p = $(cat "/sys/module/galcore/parameters/$p")"
            done
            echo "  (recovery=1 resets a hung GPU and fails the client; recovery=0 stops the driver and needs a reboot)"
        else
            echo "  no /sys/module/galcore - not a Vivante board, or its parameters are not exported"
        fi
        echo
        echo "=== hodow_cts / compositor processes ==="
        # `ps` with no arguments is util-linux's "this terminal only", which over ssh is
        # the ssh session and nothing else - it reported a live Weston as "none running".
        { ps -ef || ps aux || ps; } 2>/dev/null | grep -E 'hodow|weston|Xwayland' | grep -v grep || echo "none running"
        echo
        echo "=== has the GPU driver stopped serving ==="
        # The line that decides whether anything can run at all, and the reason it needs
        # its own section: it is one line in a dump thousands long, so the tail below
        # scrolls past it within seconds of the hang it describes.
        if dmesg 2>/dev/null | grep -qE "Stop driver to keep scene"; then
            dmesg | grep -nE "Stop driver to keep scene|GPU DRV CONFIG" | tail -4
            echo "  ^ galcore hung and, with recovery=0, stopped rather than resetting."
            echo "    Nothing GL will run on this board until it is rebooted."
        else
            echo "  no - galcore has not reported a hang since boot"
        fi
        echo
        echo "=== sysrq: ask the kernel to dump every blocked task into dmesg ==="
        # `w` only prints; it changes nothing. Worth doing because it reaches tasks this
        # script's own scan can miss, and it is the standard answer to a shutdown that hangs.
        if [ -w /proc/sysrq-trigger ] && [ "$(cat /proc/sys/kernel/sysrq 2>/dev/null)" != "0" ]; then
            echo w > /proc/sysrq-trigger 2>/dev/null && echo "dumped (see dmesg below)" || echo "refused"
        else
            echo "unavailable - enable with: echo 1 > /proc/sys/kernel/sysrq"
        fi
        echo
        echo "=== dmesg (tail) - the driver's own account: galcore/GPU hang/reset lines ==="
        dmesg 2>/dev/null | tail -120 || echo "dmesg unreadable"
        ;;
    clean)
        # `core` and `core.<pid>` only - a bare `core*` would also match an ordinary
        # file whose name happens to start that way.
        dumps=$(find "$HOME" -maxdepth 1 -type f \( -name core -o -name 'core.*' \) | wc -l | tr -d ' ')
        find "$HOME" -maxdepth 1 -type f \( -name core -o -name 'core.*' \) -delete
        echo "removed $dumps core dump(s)"
        ;;
    fuzz)
        if [ $# -eq 0 ]; then
            echo "error: 'fuzz' needs a verb - try './cts.sh fuzz --help'" >&2
            exit 1
        fi
        verb=$1
        shift
        run_fuzz "$verb" "$@"
        ;;
    # The four typed next to a board that has just been power-cycled, so they are one
    # word rather than two.
    status | continue | gpucrash | systemcrash)
        run_fuzz "$verb" "$@"
        ;;
    log)
        [ -f "$fuzz_log" ] || {
            echo "no campaign log at $fuzz_log yet" >&2
            exit 1
        }
        tail -f "$fuzz_log"
        ;;
    --)
        with_kernel_log "$cts" "$@"
        ;;
    *)
        echo "error: unknown verb '$verb'" >&2
        echo >&2
        usage >&2
        exit 1
        ;;
esac
