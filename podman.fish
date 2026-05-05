#!/usr/bin/env fish

# Docker is not used because Podman has built in provisions that work better from the ground up,
# Resource efficient, integrated into systemd, daemonless, rootless and less prone to breakages
# Only podman-docker package is present for compatibility
# Podman is built such that that utilities like watchtower are not needed

# Units podman.service podman.socket podman-auto-update.timer should be enabled

# ===================
# Pull images 
# ===================
echo "📦 Pulling latest images..."
podman pull docker.io/thetorproject/snowflake-proxy:nightly \
            \
            docker.io/honeygain/honeygain \
            docker.io/iproyal/pawns-cli:latest \
            docker.io/earnfm/earnfm-client:latest \
            docker.io/packetstream/psclient:latest \
          

# Parameters
## PW - Password
## UID - Token/Auth phrase
## MAIL - Email address
set -gx HONEYGAIN_MAIL ""
set -gx HONEYGAIN_PW ""

set -gx PAWNS_MAIL ""
set -gx PAWNS_PW ""

set -gx EARNFM_TK ""

set -gx PACKSTRM_TK ""

set -gx UNIV_MAIL "" # Use same mail for all services, if this variable has any value all other will use it
set -gx DEVICE_ID (hostname) # Use native hostname

# MAIL override
if test -n "$UNIV_MAIL"
    # MAIL set universally
    set -l targets HONEYGAIN_MAIL PAWNS_MAIL
    for var in $targets
        set -gx $var "$UNIV_MAIL"
    end
end

# ===========================
# Create containers
# ===========================
# Format for each is,
# 1. Runner(always active, auto update label)
# 2. Container identity(container name, image used)
# 3. Arguments

# --- Honeygain ---
podman run --rm honeygain/honeygain -tou-get
podman run -d --restart always --label "io.containers.autoupdate=image" \
  --name honeygain docker.io/honeygain/honeygain \
  -email $HONEYGAIN_MAIL -pass $HONEYGAIN_PW -device $DEVICE_ID -tou-accept

# --- Pawns.app ---
podman run -d --restart always --label "io.containers.autoupdate=image" \
  --name pawns-cli docker.io/iproyal/pawns-cli:latest \
  -email=$PAWNS_MAIL -password=$PAWNS_PW -device-name=$DEVICE_ID -device-id=$DEVICE_ID -accept-tos

# --- EarnFM ---
podman run -d --restart always --label "io.containers.autoupdate=image" \
  --name earnfm docker.io/earnfm/earnfm-client:latest \
  -e EARNFM_TOKEN="$EARNFM_TK"

# --- PacketStream ---
podman run -d --restart always --label "io.containers.autoupdate=image" \
  --name psclient docker.io/packetstream/psclient:latest \
  -e CID="$PACKSTRM_TK"

# --- Tor Snowflake Bridge Hoster ---
podman run -d --restart always --label "io.containers.autoupdate=image" \
  --name snowflake-proxy docker.io/thetorproject/snowflake-proxy:nightly \
  -ephemeral-ports-range "30000:60000" -allow-non-tls-relay -allow-proxying-to-private-addresses -summary-interval 1h -metrics --net host

# Emergency actions
#podman rm -af # Remove all containers
#podman pod rm -af # Remove all pods
