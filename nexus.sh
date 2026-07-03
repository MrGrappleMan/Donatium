#!/bin/env sh

# nexus-cli and nexus-compute cli are the same binaries
# nexus-ntwork is different from the ones above, it is the main frontend you should interact with

curl -sSf https://cli.nexus.xyz/ | NONINTERACTIVE=1 sh # Get nexus first
source ~/.bashrc # Refresh shell, recognize installation
nexus-network register-user --wallet-address 0xC66c5848E54F24bB15c97975C12e280Cea220b55 # Register wallet ID
nexus-network register-node # Register node onto the network
nohup nice -n 19 nexus-network start --headless --check-memory --max-threads 65536 & # Parallel compute
