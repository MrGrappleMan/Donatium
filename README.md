# Donatium

Give your devices a j*b

## Recommended operating systems

- Bluefin Dakota, or any other modern atomic distro
- macOS
- Homelab OCI management UIs, manually use the compose file and self supply env

## Services

These only include services that are meaningfully contributive to a network by

- distributed compute
- automated scraping
- bandwidth sharing
- AI inference
- Displaying ads that are not too intrusive

but not by

- hijacking user credentials
- unethical destructive actions
- artificial product inflation

## Containerization tools

### Podman

Pros
- Resource efficiency
- Systemd integration
- Daemonless architect
- Rootless and Rootfull support

Cons
- Breaks with apps that communicate directly with Docker
- Niche macOS issues

Enable units podman.socket podman-auto-update.timer
podman.service not required

### Docker

Pros
- macOS maturity
- Guaranteed proprietary app dependency
- Homelab standard

Cons
- Legacy architecture
- Propreitary source
- Daemon overhead
- Manual complexity like watchtower
