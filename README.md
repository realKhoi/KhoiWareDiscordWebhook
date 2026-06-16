# KhoiWare Discord Webhook

A lightweight server monitoring tool that pings devices on a private Tailscale VPN and sends Discord alerts when a server goes down or comes back up.

## How it works
- Runs on a **Raspberry Pi 3 Model B** as a cron job every minute
- Pings all servers within the Tailscale VPN network
- Sends a Discord embed notification when a server status changes

## Setup

**1. Clone the repo**
```bash
git clone https://github.com/realKhoi/KhoiWareDiscordWebhook.git
cd KhoiWareDiscordWebhook
```

**2. Install dependencies**
```bash
pip3 install requests --break-system-packages
```

**3. Create a `.env` file**
```bash
WEBHOOK_URL=https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN
```

**4. Make the script executable**
```bash
chmod +x main.sh
```

**5. Add to crontab**
```bash
crontab -e
# Add this line:
* * * * * bash /opt/automation/discordWatchdog/main.sh
```

## Configuration
Edit the `HOSTS` array in `main.sh` to add your own servers:
```bash
declare -A HOSTS=(
    ["100.x.x.x"]="Server1"
    ["100.x.x.x"]="Server2"
)
```
Use Tailscale IPs (100.x.x.x range) for VPN-connected devices.



