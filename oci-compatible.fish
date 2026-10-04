#!/usr/bin/env fish

# Prefer podman on Linux, as it is
# resource efficient
# integrated into systemd
# daemonless
# rootless 
# less prone to breakages
# Enable units podman.service podman.socket podman-auto-update.timer
# Install podman-docker for better universal compatibility

# Docker is better on macOS and for compatibility
# with most other enterprise applications
# including cases like umbrelOS

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

# Create containers
    # Format for each
        # Runner(always active, auto update label)
            # Docker
                alias drun=""
            # Podman
                alias prun=""
        # Container identity(container name, image used)
        # Arguments

    # Honeygain
        docker run --rm honeygain/honeygain -tou-get
        docker run -d --restart always --label "io.containers.autoupdate=image" \
            --name honeygain docker.io/honeygain/honeygain \
            -email $HONEYGAIN_MAIL -pass $HONEYGAIN_PW -device $DEVICE_ID -tou-accept

    # Pawns.app
        docker run -d --restart always --label "io.containers.autoupdate=image" \
            --name pawns-cli docker.io/iproyal/pawns-cli:latest \
            -email=$PAWNS_MAIL -password=$PAWNS_PW -device-name=$DEVICE_ID -device-id=$DEVICE_ID -accept-tos

    # EarnFM
        docker run -d --restart always --label "io.containers.autoupdate=image" \
            --name earnfm docker.io/earnfm/earnfm-client:latest \
            -e EARNFM_TOKEN="$EARNFM_TK"

    # PacketStream
        docker run -d --restart always --label "io.containers.autoupdate=image" \
            --name psclient docker.io/packetstream/psclient:latest \
            -e CID="$PACKSTRM_TK"

    # Tor Snowflake proxy
        docker run -d --restart always --label "io.containers.autoupdate=image" \
            --name snowflake-proxy docker.io/thetorproject/snowflake-proxy:nightly \
            -ephemeral-ports-range "30000:60000" -allow-non-tls-relay -allow-proxying-to-private-addresses -summary-interval 1h -metrics --net host
    # Watchtower

# Emergency actions
#docker rm -af # Remove all containers
#docker pod rm -af # Remove all pods
