# === dev-board ============================================================================
# Reaching a board over ssh, debugging one that wedges, and fuzzing its driver. Nothing here is what you run to test a box.

# Everything that happens once, before a campaign is left running on a board: checks this
# machine has the tooling (zig, cargo-zigbuild, the pinned nightly), cross-builds,
# deploys, confirms the board's driver answers, and runs the fuzzer's own gate **there**.
# That last step is what separates "it found nothing" from "it works and found nothing" -
# see hodow_cts/README.md, "Fuzzing combinations". Starts no campaign; prints the command
# that does.
# Usage: just arm-fuzz-setup 192.168.1.50 [user]
#
# One-off: deploy to an ARM board and prove the fuzzer works on its driver.
[group('dev-board')]
arm-fuzz-setup ip_address user="root":
    @HODOW_SSH_OPTS="{{SSH_OPTS}}" scripts/run_logged.sh arm-fuzz-setup hodow_cts/scripts/arm_fuzz_setup.sh {{ip_address}} {{user}}

# The same fuzzing as `just cts-fuzz`, but on the board, via `~/cts.sh`. Deploys
# nothing: `run`/`continue` start detached there and then follow the log, so Ctrl-C here
# stops the following and not the campaign, and a dropped SSH session costs no work.
#
#   just install-arm-cts 192.168.1.50                      once, deliberately
#   just arm-fuzz 192.168.1.50 run --case 'dEQP-GLES*'     start
#   <the board wedges; you power-cycle it>
#   just arm-fuzz 192.168.1.50 gpucrash                    say what happened, carry on
#   just arm-fuzz-fetch 192.168.1.50                       bring the findings home
#
# **Never deploys**, on purpose: replacing the binary under a live campaign changes the
# corpus, and every stored seed then names a different group. `status`/`continue` say so
# if the binary on the board no longer matches what the campaign was started against.
# The `--label` comes from *this* machine's clock rather than the board's, which on an
# image with no RTC is the only one worth trusting.
# The `user` positional sits between the verb and the fuzzer's own arguments, so it is
# skipped by writing a flag first: `just arm-fuzz <ip> run --case '...'` keeps root, and
# `just arm-fuzz <ip> run pi --case '...'` is how another user is named.
# Usage: just arm-fuzz 192.168.1.50 [verb] [user] [args...]
#
# Drive a fuzzing campaign on an ARM board over ssh. Deploys nothing.
[group('dev-board')]
arm-fuzz ip_address verb="status" user="root" *args:
    #!/usr/bin/env bash
    set -ef
    user='{{user}}'
    args='{{args}}'
    # A flag or a bare number in that slot is an argument for the fuzzer written without
    # naming a user, not a user: `run --case '...'` and `replay 1` are how both are
    # spelled, and `ssh --case ...` / `ssh 1@board` is what they used to become. A real
    # username still wins, it just has to be written before the arguments.
    case "$user" in
        -* | [0-9] | [0-9][0-9] | [0-9][0-9][0-9]) args="$user $args"; user=root ;;
    esac
    extra=""
    if [ "{{verb}}" = "run" ] && [[ " $args " != *" --label "* ]]; then
        extra="--label $(date +%Y%m%d-%H%M%S)"
    fi
    # `set -f` on both ends: a case filter is a glob for hodow_cts, and without it the
    # remote shell expands it against the board's home directory first.
    # Teed to tmp/arm-fuzz-last.log: the board's own journal survives a power cut, but
    # the last thing it printed before wedging exists only in this session's output.
    scripts/run_logged.sh arm-fuzz \
        ssh {{SSH_OPTS}} -t "$user@{{ip_address}}" "set -f; ./cts.sh fuzz {{verb}} $extra $args"

# Brings the whole base directory back - every campaign, its findings, its journal - so
# results can be read and pasted without an ssh session. Through tar rather than
# `scp -r` because the base directory holds a `current` symlink, which scp would follow
# and copy as a second full campaign.
# Usage: just arm-fuzz-fetch 192.168.1.50 [user]
#
# Copy an ARM board's fuzzing campaigns into tmp/cts-fuzz/<ip>/.
[group('dev-board')]
arm-fuzz-fetch ip_address user="root":
    #!/usr/bin/env bash
    # pipefail, because the payload is ssh's *stdout*: without it a board that answers
    # "no such directory" leaves an empty destination and a zero exit, which reads as a
    # campaign that found nothing rather than as a fetch that never happened.
    set -eo pipefail
    dest="tmp/cts-fuzz/{{ip_address}}"
    mkdir -p "$dest" tmp/logs/arm-fuzz-fetch
    log="tmp/logs/arm-fuzz-fetch/$(date +%Y%m%d-%H%M%S).log"
    ln -sfn "logs/arm-fuzz-fetch/$(basename "$log")" tmp/arm-fuzz-fetch-last.log
    echo "# arm-fuzz-fetch {{ip_address}} $(date -Is)" > "$log"
    if ! ssh {{SSH_OPTS}} {{user}}@{{ip_address}} 'tar -C "$HOME" -cf - hodow-cts-fuzz' 2>>"$log" \
        | tar -C "$dest" -xf - --strip-components=1; then
        echo "fetch failed - see $log" | tee -a "$log" >&2
        cat "$log" >&2
        exit 1
    fi
    echo "fetched into $dest" | tee -a "$log"
    find "$dest" -name finding.json | sort | while read -r f; do
        echo "  $(dirname "$f")" | tee -a "$log"
    done

# Runs each case alone, from its own reboot, and says which of them take the GPU down
# with nothing else involved - the first question to ask about a finding, and the one
# bisection spends most of an hour answering when the answer is "the casualty, by itself".
# Give it a glob and it probes the neighbours too, which is how one finding becomes the
# shape it belongs to.
# The verdict is the kernel's (`Stop driver to keep scene`), not a stopwatch's: a case can
# report a pass and still leave the driver dead, and `SLOW` is what a case that merely ran
# out of time is called instead.
# `CLEAN_BOOT=0` reboots only after a hang - faster, and a weaker claim, since a case that
# hangs after five healthy ones has been shown something else entirely.
# `REPEATS=N` runs each case N times in one process instead of once, which is a different
# question and sometimes the one with the answer: a case that passed twice alone went on to
# hang on run 2, run 7 and run 3 of three further attempts.
# Passing a *file* instead of a glob runs one line per process, and those lines may
# themselves be globs - which is how a whole tree gets screened: 103 patterns covering
# 16867 GLES 3.1 cases took 53 minutes, against most of a day one case at a time. A group
# that comes back HANG or FAIL is then worth re-probing case by case.
# Usage: just arm-probe 192.168.1.50 'dEQP-GLES31.functional.image_load_store.*' [method] [user]
#
# Ask of each case, one at a time on a board: does this hang the GPU on its own?
[group('dev-board')]
arm-probe ip_address cases method="sysrq" user="root":
    @scripts/run_logged.sh arm-probe hodow_cts/scripts/arm_probe.sh {{ip_address}} '{{cases}}' {{method}} {{user}} {{SSH_OPTS}}

# Runs every reproducer under `findings/` against one board and prints one table of
# verdicts - which is the only question that directory exists to answer, and the one a
# new driver build makes worth asking again.
# A finding that hangs the GPU leaves it refusing to serve, so the reboot after a HANG is
# part of the loop rather than something to remember. Each finding's full output lands in
# `tmp/findings-verify/<timestamp>/`; the table is only the verdict line.
# Exit 1 if anything printed PASS - read that finding's log before believing it, because
# a reproducer that stopped reproducing looks exactly like a driver that got fixed, and so
# does an intermittent one that did not happen this time. `HODOW_VERIFY_ATTEMPTS=5` asks
# each PASS again, which is what those need; `HODOW_VERIFY_ONLY='0006*'` runs one of them.
# Usage: just findings-verify 192.168.1.50 [user]
#
# Re-run every finding against a board, in order, and say what is still broken.
[group('dev-board')]
findings-verify ip_address user="root":
    @scripts/run_logged.sh findings-verify hodow_cts/scripts/verify_findings.sh {{ip_address}} {{user}} {{SSH_OPTS}}

# Reboot a board and wait until it can run GL again, reporting how long that took - and
# checking the kernel's boot id, so a method that quietly does nothing is not reported as
# the fastest of them all.
# Measured on the i.MX board after a GPU hang, which is the case that matters: `graceful`
# ~560s (three 90-second rounds on every process stuck in the driver), `force` 224s
# (skips stopping units, still unmounts), `sysrq` 47s (sync, remount read-only, reset -
# and indifferent to the stuck process, which is why it does not slow down after a hang).
# There is deliberately no watchdog method: arming /dev/watchdog resets the board and then
# keeps resetting it, because on i.MX6 the enable bit survives a watchdog reset.
# Usage: just arm-reboot 192.168.1.50 [graceful|force|sysrq] [user]
#
# Reboot an ARM board and time how long it takes to be ready for GL again.
[group('dev-board')]
arm-reboot ip_address method="graceful" user="root":
    @scripts/run_logged.sh arm-reboot hodow_cts/scripts/arm_reboot.sh {{ip_address}} {{method}} {{user}} {{SSH_OPTS}}

# A second connection that does nothing but watch the board talk, for the whole length of
# a campaign started from another terminal. The GPU driver reports to the kernel log and
# nowhere else - a Vivante one prints its `*** GPU DRV CONFIG ***` banner there when it
# resets - so a crash that leaves the board up is visible here and invisible in the
# fuzzer's own output. Ctrl-C stops the watching and nothing else.
#
# `-k` for kernel messages only; pass `all` as the second argument for the whole journal.
# The board keeps its own copy next to the campaign either way (`cts.sh` starts a follower
# with every `run`/`continue`), so this is for watching, not for the record.
# Usage: just arm-journal 192.168.1.50 [all] [user]
#
# Follow an ARM board's kernel log live -> tmp/arm-journal-last.log.
[group('dev-board')]
arm-journal ip_address scope="kernel" user="root":
    #!/usr/bin/env bash
    set -e
    case '{{scope}}' in
        kernel) flags="-kf" ;;
        all) flags="-f" ;;
        *) echo "arm-journal: scope is 'kernel' or 'all', not '{{scope}}'" >&2; exit 1 ;;
    esac
    # -n 200 so the lines that explain a crash that already happened are there too.
    scripts/run_logged.sh arm-journal \
        ssh {{SSH_OPTS}} -t {{user}}@{{ip_address}} "journalctl $flags -n 200 --no-pager"

# The one to run *before* rebooting a wedged board, because none of it can be read
# afterwards: which tasks are in uninterruptible sleep (`D`) and the kernel stack each is
# blocked in - i.e. the driver call that is not returning - plus what the kernel itself
# said (`galcore`, GPU hang, reset). Those `D` tasks are also the answer to a reboot that
# takes minutes: nothing can kill them, so init waits out its stop timeout on each.
# Touches no driver, so it is safe on a board where bringing one up is what hangs.
# Usage: just arm-diag 192.168.1.50 [user]
#
# Why an ARM board is wedged, while it still is -> tmp/arm-diag-last.log.
[group('dev-board')]
arm-diag ip_address user="root":
    @scripts/run_logged.sh arm-diag ssh {{SSH_OPTS}} {{user}}@{{ip_address}} ./cts.sh diag

[group('dev-board')]
generate-key:
    mkdir -p tmp
    [ -f {{ BOARD_KEY }} ] || ssh-keygen -t ed25519 -N "" -C "claude-tmp" -f {{ BOARD_KEY }}
    cat {{ BOARD_KEY }}.pub

# sshd on older devices rejects the `expiry-time` option, so expiry is a root crontab entry on the device that
# checks every minute and deletes the key (and itself) once the deadline passes. Needs a running crond and `crontab`
# (busybox has both). Re-running replaces the previous key line and deadline.
[doc('Installs the tmp/ public key on a board (root by default), auto-removed after `lifetime` (a `date -d` span, e.g. "30 days" or "1 minute")')]
[group('dev-board')]
send-key ip_address remote_user="root" lifetime="30 days": generate-key
    #!/usr/bin/env bash
    set -e
    deadline="$(date -d '+{{ lifetime }}' +%s)"
    blob="$(cut -d' ' -f2 {{ BOARD_KEY }}.pub)"
    key="$(cat {{ BOARD_KEY }}.pub)"
    cron_line="* * * * * [ \$(date +\%s) -ge $deadline ] && sed -i \"\\\\,$blob,d\" \$HOME/.ssh/authorized_keys && (crontab -l | grep -v claude-tmp-expiry | crontab -) # claude-tmp-expiry"
    ssh {{ remote_user }}@{{ ip_address }} 'sh -s' <<EOF
    mkdir -p ~/.ssh && chmod 700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
    sed -i '\\|$blob|d' ~/.ssh/authorized_keys
    echo '$key' >> ~/.ssh/authorized_keys
    (crontab -l 2>/dev/null | grep -v claude-tmp-expiry; echo '$cron_line') | crontab -
    crontab -l | grep claude-tmp-expiry
    EOF
    echo "key valid until $(date -d @$deadline)"
    ssh -i {{ BOARD_KEY }} -o IdentitiesOnly=yes -o BatchMode=yes {{ remote_user }}@{{ ip_address }} true \
        && echo "key login works: HODOW_SSH_OPTS=\"-i {{ BOARD_KEY }} -o IdentitiesOnly=yes\" just ..." \
        || echo "key login failed"

[doc('Removes the tmp/ public key and its expiry job from a board')]
[group('dev-board')]
revoke-key ip_address remote_user="root":
    #!/usr/bin/env bash
    set -e
    blob="$(cut -d' ' -f2 {{ BOARD_KEY }}.pub)"
    ssh {{ remote_user }}@{{ ip_address }} 'sh -s' <<EOF
    sed -i '\\|$blob|d' ~/.ssh/authorized_keys
    (crontab -l 2>/dev/null | grep -v claude-tmp-expiry) | crontab -
    echo key removed
    EOF
