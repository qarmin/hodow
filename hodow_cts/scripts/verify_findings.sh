#!/usr/bin/env bash
# Runs every reproducer in `findings/` against one board, in order, and prints one table.
#
# That is the question the directory exists to answer - "is any of this fixed on the
# driver this board is running now" - and until this it meant one invocation by hand per
# finding, with a reboot somewhere in the middle, which nobody does six months later.
#
# A finding that hangs the GPU leaves the driver refusing to serve until the board is
# rebooted, so every run after it would report NO DRIVER. The reboot is therefore part of
# the loop, not something to remember: after a HANG, and only after one, the board is
# reset the fast way (`sysrq`, ~47s, and indifferent to the process stuck in the driver).
#
# Every run of every finding is kept under `tmp/findings-verify/<timestamp>/` - one
# `<finding>.log.<attempt>` each, with `<finding>.log` the attempt the table reports. The
# table itself is only the verdict line.
#
# Three environment variables: `HODOW_VERIFY_ATTEMPTS` (default 1) is how many times a
# finding that printed PASS is asked again before the PASS is believed - an intermittent
# one needs it - `HODOW_VERIFY_ONLY` is a glob limiting which directories run, for
# re-asking one of them without paying for the rest, and `HODOW_QUIET_UNITS` (default
# `ap600-launcher`) the units stopped before every run so nothing else is on the GPU.
#
# Usage: verify_findings.sh <ip> [user] [ssh-opts...]

set -uo pipefail

ip=${1:?usage: verify_findings.sh <ip> [user] [ssh-opts...]}
user=${2:-root}
shift 2 2>/dev/null || shift $#
ssh_opts=("$@")

here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
root=$(cd "$here/../.." && pwd)
cd "$root"

if [ ! -d findings ]; then
    echo "no findings/ directory here - nothing to verify"
    exit 1
fi

out_dir="tmp/findings-verify/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$out_dir"

# How many times a finding that printed PASS is asked again before the PASS is believed.
attempts=${HODOW_VERIFY_ATTEMPTS:-1}
quiet_units=${HODOW_QUIET_UNITS:-ap600-launcher}

# The justfile's `SSH_OPTS` names its key and known-hosts file relative to the repository
# root, and each finding is run from its own directory - so without this ssh looks for the
# key inside `findings/NNNN-.../` and every row comes back "Host key verification failed".
abs_opts=()
for opt in ${ssh_opts[@]+"${ssh_opts[@]}"}; do
    case "$opt" in
        /* | *=/*) abs_opts+=("$opt") ;;
        # By name rather than by "does this look like a path": `IdentitiesOnly=yes` is not
        # a file and rewriting it produced an ssh option nothing accepts.
        UserKnownHostsFile=* | GlobalKnownHostsFile=* | IdentityFile=* | CertificateFile=*)
            abs_opts+=("${opt%%=*}=$root/${opt#*=}") ;;
        *=*) abs_opts+=("$opt") ;;
        *) if [ -e "$root/$opt" ]; then abs_opts+=("$root/$opt"); else abs_opts+=("$opt"); fi ;;
    esac
done

names=()
verdicts=()
seconds=()

only=${HODOW_VERIFY_ONLY:-*}

for dir in findings/[0-9]*/; do
    [ -f "$dir/justfile" ] || continue
    # shellcheck disable=SC2254 # unquoted on purpose: `only` is a glob, not a literal
    case "$(basename "$dir")" in $only) ;; *) continue ;; esac
    name=$(basename "$dir")
    echo
    echo "=== $name ================================================"
    started=$SECONDS
    log="$out_dir/$name.log"

    # A PASS is retried and nothing else is. Some of these are intermittent - 0006 hangs
    # about one run in three - so a single PASS is "it did not happen this time", which
    # reads identically to "the driver fixed it" and is the one mistake this table could
    # make. Anything that reproduced is left alone: repeating it only costs reboots.
    attempt=0
    while :; do
        attempt=$((attempt + 1))
        # Every attempt, because the reboot after a HANG brings these back up. Another GL
        # client on the GPU is not a neutral bystander: with ap600-launcher running, 0019
        # passed 3 of 3 attempts that hang 5 of 5 with it stopped.
        for unit in $quiet_units; do
            ssh ${abs_opts[@]+"${abs_opts[@]}"} -o ConnectTimeout=10 "$user@$ip" "systemctl stop $unit 2>/dev/null; true" >/dev/null 2>&1
        done
        (cd "$dir" && just arm "$ip" "$user" ${abs_opts[@]+"${abs_opts[@]}"}) > "$log.$attempt" 2>&1
        # The verdict is a line of its own that the finding's justfile prints; anything
        # else in the log is the reproducer talking. `tail -1` because a build failure can
        # echo the word too, and the real verdict is always last.
        verdict=$(grep -aoE '^(HANG|PASS|FAIL|NO DRIVER|CLIENT HANG|TIMED OUT)' "$log.$attempt" | tail -1)
        verdict=${verdict:-UNREADABLE}

        if [ "$verdict" = "HANG" ]; then
            echo "--- the GPU is down; rebooting"
            "$here/arm_reboot.sh" "$ip" sysrq "$user" ${abs_opts[@]+"${abs_opts[@]}"} 2>&1 | tail -3
        fi
        [ "$verdict" = "PASS" ] && [ "$attempt" -lt "$attempts" ] || break
        echo "PASS on attempt $attempt of $attempts - asking again"
    done

    cp "$log.$attempt" "$log"
    took=$((SECONDS - started))
    [ "$attempt" -gt 1 ] && verdict="$verdict/$attempt"
    echo "$verdict  (${took}s, $log)"

    names+=("$name")
    verdicts+=("$verdict")
    seconds+=("$took")
done

echo
echo "=== every finding, against $ip ============================="
printf '%-56s %-12s %6s\n' "finding" "verdict" "secs"
fixed=0
nodriver=0
for i in "${!names[@]}"; do
    printf '%-56s %-12s %6s\n' "${names[$i]}" "${verdicts[$i]}" "${seconds[$i]}"
    case "${verdicts[$i]}" in
        PASS | PASS/*) fixed=$((fixed + 1)) ;;
        "NO DRIVER" | UNREADABLE) nodriver=$((nodriver + 1)) ;;
    esac
done

echo
if [ "$nodriver" -gt 0 ]; then
    echo "$nodriver finding(s) never got a driver to test - those rows say nothing."
fi
if [ "$fixed" -gt 0 ]; then
    echo "$fixed finding(s) printed PASS: the driver fixed them, the reproducer stopped"
    echo "reproducing, or it is an intermittent one that did not happen in $attempts run(s)."
    echo "Read that finding's README and log before believing the first of those."
    echo "HODOW_VERIFY_ATTEMPTS=5 asks each PASS again, which is what an intermittent one needs."
    exit 1
fi
echo "$((${#names[@]} - nodriver)) of ${#names[@]} still reproduce. Nothing here is fixed on this driver."
[ "$nodriver" -gt 0 ] && exit 2
exit 0
