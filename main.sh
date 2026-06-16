#!/bin/bash
import requests
import os
import sys
from datetime import datetime, timezone

STATUS_FILE="/opt/automation/discordWatchdog/status.txt"

declare -A HOSTS=(
    ["100.70.211.32"]="Manager"
    ["100.75.86.71"]="Server1"
    ["100.110.40.44"]="Server2"
)

for ip in "${!HOSTS[@]}"; do
    name="${HOSTS[$ip]}"
    prev_status=$(grep "^$ip=" "$STATUS_FILE" 2>/dev/null | cut -d= -f2)

    if ! ping -c 1 -W 1 "$ip" &>/dev/null; then
        current_status="DOWN"
    else
        current_status="UP"
    fi

    if [ "$current_status" != "$prev_status" ]; then
        python3 /opt/automation/discordWatchdog/alert.py "$ip" "$name" "$current_status"
    fi

    grep -v "^$ip=" "$STATUS_FILE" 2>/dev/null > /tmp/status_tmp
    echo "$ip=$current_status" >> /tmp/status_tmp
    mv /tmp/status_tmp "$STATUS_FILE"
done