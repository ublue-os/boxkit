#!/bin/sh
# Tag files with package component names for chunkah content-based layering
# Supports: apk (Alpine), rpm (Fedora/RHEL), dpkg (Debian/Ubuntu), pacman (Arch)

set -euo pipefail

tag_files() {
    pkgname="$1"
    shift
    for filepath in "$@"; do
        if [ -f "$filepath" ]; then
            setfattr -n user.component -v "$pkgname" "$filepath" 2>/dev/null || true
        fi
    done
}

if command -v apk >/dev/null 2>&1; then
    echo "==> Detected Alpine (apk) - tagging files for chunkah"
    apk add --no-cache attr
    apk info -q | while read pkgname; do
        tag_files "$pkgname" $(apk info -L "$pkgname" 2>/dev/null | sed 's|^|/|')
    done
    apk del attr
    echo "✓ Alpine file tagging complete"

elif command -v rpm >/dev/null 2>&1; then
    echo "==> Detected RPM-based (dnf/yum) - tagging files for chunkah"
    if command -v dnf5 >/dev/null 2>&1; then
        dnf5 install -y attr
    elif command -v dnf >/dev/null 2>&1; then
        dnf install -y attr
    else
        yum install -y attr
    fi
    
    rpm -qa --qf '%{NAME}\n' | while read pkgname; do
        tag_files "$pkgname" $(rpm -ql "$pkgname" 2>/dev/null)
    done
    
    if command -v dnf5 >/dev/null 2>&1; then
        dnf5 remove -y attr
    elif command -v dnf >/dev/null 2>&1; then
        dnf remove -y attr
    else
        yum remove -y attr
    fi
    echo "✓ RPM file tagging complete"

elif command -v dpkg >/dev/null 2>&1; then
    echo "==> Detected Debian-based (dpkg/apt) - tagging files for chunkah"
    apt-get update && apt-get install -y attr
    dpkg-query -W -f='${Package}\n' | while read pkgname; do
        tag_files "$pkgname" $(dpkg -L "$pkgname" 2>/dev/null)
    done
    apt-get remove -y attr
    echo "✓ Debian file tagging complete"

elif command -v pacman >/dev/null 2>&1; then
    echo "==> Detected Arch (pacman) - tagging files for chunkah"
    pacman -Sy --noconfirm attr
    pacman -Qq | while read pkgname; do
        tag_files "$pkgname" $(pacman -Ql "$pkgname" 2>/dev/null | awk '{print $2}')
    done
    pacman -R --noconfirm attr
    echo "✓ Arch file tagging complete"

else
    echo "WARNING: Unknown package manager detected"
    echo "Chunkah will still work but layer splitting may be less optimal"
    exit 0
fi
