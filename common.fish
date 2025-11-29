#!/bin/env fish

# Nexus OS
nexus-network register-user --wallet-address 0xC66c5848E54F24bB15c97975C12e280Cea220b55 
nexus-network register-node
nexus-network start --headless --check-memory --max-threads 16 --max-difficulty medium

# Docker
# !`Setup----------
for cpkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker container runc; do sudo apt-fast remove $cpkg; done
cd /tmp/
curl -fsSL https://test.docker.com -o dck.sh
sudo sh dck.sh

podman run -d --name fyn-psclient -e CID=69eg packetstream/psclient:latest
podman run -d --name fyn-earnfm-client -e EARNFM_TOKEN="a0d3ff10-5d3c-4c24-a80a-d0c0120ddf76" earnfm/earnfm-client:latest

# Packetstream----------
set APIKEY=
podman run -d --name psclient -e CID=$APIKEY packetstream/psclient:latest
# EarnFM----------
set APIKEY=
podman run -d --name earnfm-client -e EARNFM_TOKEN=$APIKEY earnfm/earnfm-client:latest
# Honeygain----------
set EMAIL=
set PASSWORD=
set DEVICENAME=
podman run -d --name honeygain honeygain/honeygain -tou-accept -email $EMAIL -pass $PASSWORD -device $DEVICENAME
# PawnsApp----------
set EMAIL=
set PASSWORD=
set DEVICENAME=
set DEVICEID=
podman run -d --name pawns-cli iproyal/pawns-cli:latest -email=$EMAIL -password=$PASSWORD -device-name=$DEVICENAME -device-id=$DEVICEID -accept-tos
# Repocket----------
set EMAIL=
set APIKEY=
podman run -d --name repocket -e RP_EMAIL=$EMAIL -e RP_API_KEY=$APIKEY repocket/repocket
# !`Final----------
CONTAINERS='fyn-psclient fyn-earnfm-client honeygain repocket pawns-cli earnfm-client psclient'
podman run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --cleanup --include-stopped --include-restarting --revive-stopped --interval 300 $CONTAINERS
podman update --restart=always --memory-swap=-1 --cpus=0.000 --cpu-quota=0 --pids-limit=-1 --cpu-rt-period=2000000 $(podman ps -q -a)
# !`Remove all----------
# podman rm $(podman ps -q -a) -f
