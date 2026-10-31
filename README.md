# Donatium

Give your devices a j*b

## Supported operating systems

- Bluefin Dakotaraptor(or any other atomic distro)
- Homelab Docker UIs, manually use the compose file and self supply env
- macOS

## Services

These only include services that are meaningfully contributive to a network by

- distributed compute
- automated scraping
- bandwidth sharing
- AI inference

but not by

- displaying ads
- hijacking user credentials
- destructive actions
- artificial product inflation

UpRock
EarnApp
EarnFM
SurveySavvy
Pawns.App
Honeygain
DATS Project
KOII Node
Snowflake Proxy
Tor Relays
Traffmonetizer
PacketShare
PacketStream
Repocket
Cash4Minutes
McMoney
Money SMS
Acurast

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
