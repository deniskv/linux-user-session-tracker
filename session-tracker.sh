#!/bin/bash

# Slack webhook url
WEBHOOK_URL="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
#slack user and channel
CHANNEL="#server-sessions"
USERNAME="Server Watchdog"

# Server messages come from
SERVER_NAME=$(hostname)
SERVER_IP=$(hostname -I | awk '{print $1}') # Берем первый IP

# Json template
PAYLOAD=$(cat <<EOF
{
  "channel": "${CHANNEL}",
  "username": "${USERNAME}",
  "text": "$1",
  "icon_emoji": ":ssh:"
}
EOF
)

# Send to slack
curl -s -X POST -H 'Content-type: application/json' --data "$PAYLOAD" "$WEBHOOK_URL" > /dev/null 2>&1 &