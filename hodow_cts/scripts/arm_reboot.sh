#!/usr/bin/env bash
# Reboots a board and waits until it can run GL again, timing the whole thing.
#
# It has to be timed because on a board whose GPU hang leaves an unkillable process, the
# reboot is most of what a minimisation costs: ten rounds of bisection is ten reboots,
# and the difference between the methods below is the difference between one hour and
# two. `graceful` is the honest default; the other two trade shutdown cleanliness for
# minutes, which is a trade worth making on a test board and nowhere else.
#
#   graceful   systemctl reboot. Stops every unit, so it waits out the stop timeout of
#              each process stuck in the driver - three 90s rounds each, on this image.
#   force      systemctl reboot --force. Skips stopping units, still unmounts and syncs.
#   sysrq      sync, remount read-only, reset. Nothing is asked politely; the kernel
#              resets the machine. Needs kernel.sysrq to allow it - the default on this
#              image is 16 (sync only), so it is turned on first.
# There is no `watchdog` method, and there was one for about an hour. Arming /dev/watchdog
# and not feeding it does reset the board - and then resets it again, and again, because
# on i.MX6 the watchdog's enable bit survives a watchdog reset. The board went into a loop
# of rebooting every ~80 seconds and had to be caught between reboots and told to stop
# (`printf V > /dev/watchdog`, the magic close). Nothing was damaged, but a reboot method
# that leaves the machine rebooting is not one, and on a board that cannot be reached over
# a serial console it is close to unrecoverable.
#
# Waiting for "weston is active" rather than for ssh: ssh answers seconds after boot,
# while what a GL run needs is a compositor holding a display.
#
# Usage: arm_reboot.sh <ip> [graceful|force|sysrq] [user] [ssh-opts...]

set -uo pipefail

ip=${1:?usage: arm_reboot.sh <ip> [graceful|force|sysrq] [user] [ssh-opts...]}
method=${2:-graceful}
user=${3:-root}
shift 3 2>/dev/null || shift $#
ssh_opts=("$@")

remote="$user@$ip"
ssh_cmd=(ssh "${ssh_opts[@]}" -o ConnectTimeout=6 -o BatchMode=yes)

case "$method" in
    graceful) trigger='sync; (sleep 1; systemctl reboot) >/dev/null 2>&1 &' ;;
    force)    trigger='sync; (sleep 1; systemctl reboot --force) >/dev/null 2>&1 &' ;;
    sysrq)    trigger='(sleep 1; echo 1 > /proc/sys/kernel/sysrq; echo s > /proc/sysrq-trigger; sleep 2; echo u > /proc/sysrq-trigger; sleep 1; echo b > /proc/sysrq-trigger) >/dev/null 2>&1 &' ;;
    *) echo "arm_reboot.sh: method is graceful, force or sysrq - not '$method'" >&2; exit 64 ;;
esac

# The kernel's own id for this boot. Without it there is no way to tell "came back" from
# "never went away", and a method that quietly does nothing looks like the fastest one of
# all - which is exactly what the watchdog path did the first time it was tried.
was=$("${ssh_cmd[@]}" "$remote" 'cat /proc/sys/kernel/random/boot_id' 2>/dev/null)
if [ -z "$was" ]; then
    echo "cannot reach $remote to reboot it" >&2
    exit 1
fi

started=$SECONDS
echo "rebooting $remote ($method)"
"${ssh_cmd[@]}" "$remote" "$trigger" >/dev/null 2>&1

sleep 20
for _ in $(seq 1 110); do
    sleep 10
    now=$("${ssh_cmd[@]}" "$remote" 'cat /proc/sys/kernel/random/boot_id' 2>/dev/null)
    [ -n "$now" ] && [ "$now" = "$was" ] && continue   # still the same boot: it has not restarted
    if "${ssh_cmd[@]}" "$remote" 'systemctl is-active weston' 2>/dev/null | grep -q active; then
        # "active" is not the same as a compositor ready to hand out a display.
        sleep 15
        echo "back after $((SECONDS - started))s ($method)"
        exit 0
    fi
done

echo "did not come back within $((SECONDS - started))s ($method) - it may never have restarted" >&2
exit 1
