ip = sys.argv[1]
name = sys.argv[2]
status = sys.argv[3]

color = 0xff0000 if status == "DOWN" else 0x00ff00
emoji = "⚠️" if status == "DOWN" else "✅"

requests.post(os.environ["WEBHOOK_URL"], json={
    "embeds": [{
        "title": f"{emoji} {name} is {status}!",
        "color": color,
        "fields": [
            {"name": "Server", "value": name, "inline": True},
            {"name": "IP", "value": ip, "inline": True},
            {"name": "Status", "value": status, "inline": True}
        ],
        "timestamp": datetime.now(timezone.utc).isoformat()
    }]
})