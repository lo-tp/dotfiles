#!/bin/bash

SERVER="192.168.200.139"          # Your NAS IP/hostname
SHARE="Tmp"                  # Share name
MOUNT_POINT="/Volumes/$SHARE"
ALLOWED_SSIDS=("kkk" "kkk_5G")   # <-- Replace with your real SSIDs

# --- Get current Wi‑Fi SSID (if any) using system_profiler (interface‑independent) ---
CURRENT_SSID=$(system_profiler SPAirPortDataType 2>/dev/null | awk '/^ +Current Network Information:/ { getline; sub(/^ +/,""); sub(/:$/,""); print; exit }')

# --- Check if allowed Wi‑Fi SSID ---
SSID_OK=false
if [ -n "$CURRENT_SSID" ]; then
    for ssid in "${ALLOWED_SSIDS[@]}"; do
        if [ "$CURRENT_SSID" == "$ssid" ]; then
            SSID_OK=true
            break
        fi
    done
fi

# --- Check if any Ethernet interface has an IP address ---
ETH_ACTIVE=false
for eth in $(ifconfig -l); do
    if [[ "$eth" == en* ]] && ifconfig "$eth" | grep -q "inet "; then
        ETH_ACTIVE=true
        break
    fi
done

# --- Allow mount if Wi‑Fi allowed *or* Ethernet active ---
if ! $SSID_OK && ! $ETH_ACTIVE; then
    echo "Not on an allowed network (Wi‑Fi: ${CURRENT_SSID:-none}, Ethernet: $ETH_ACTIVE). Exiting."
    exit 0
fi

# --- Wait for server reachability (TCP 445, Surge‑friendly) ---
echo "Waiting for $SERVER (TCP 445)..."
while ! nc -z -w1 "$SERVER" 445 &>/dev/null; do
    sleep 5
done

# --- Mount if not already mounted ---
if [ ! -d "$MOUNT_POINT" ]; then
    osascript -e "mount volume \"smb://admin@${SERVER}/${SHARE}\""
    echo "Mounted $SHARE"
else
    echo "$SHARE already mounted"
fi
