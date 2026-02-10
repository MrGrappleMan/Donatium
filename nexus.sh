curl -sSf https://cli.nexus.xyz/ -o install.sh
chmod +x install.sh
NONINTERACTIVE=1 ./install.sh
nexus-cli register-user --wallet-address 0xC66c5848E54F24bB15c97975C12e280Cea220b55 
nexus-cli register-node
clear
nohup nice -n 19 nexus-cli start --headless --check-memory --max-threads 65536 &
