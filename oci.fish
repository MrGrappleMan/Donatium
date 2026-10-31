#!/usr/bin/env fish

# Podman
#
# Prefer for
# resource efficient, systemd, daemonless, rootless
# Enable units podman.socket podman-auto-update.timer
# podman.service not required

# Docker
#
# Avoid for
# old, propreitary, daemon overhead
# manual complexity like watchtower
#
# Prefer for
# umbrelOS, certain macOS maturity, app compatibility