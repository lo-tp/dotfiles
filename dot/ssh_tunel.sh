#!/bin/bash
# Usage: ./ssh_param.sh -p <port> <server>
# Example: ./ssh_param.sh -p 46677 root@0a6dfc80176746b5aa67701aa19de962.region2.waas.aigate.cc

PORT=""
SERVER=""

while getopts "p:" opt; do
    case $opt in
        p) PORT="$OPTARG" ;;
        *) echo "Usage: $0 -p <port> <server>"; exit 1 ;;
    esac
done
shift $((OPTIND - 1))
SERVER="$1"

if [ -z "$PORT" ] || [ -z "$SERVER" ]; then
    echo "Usage: $0 -p <port> <server>"
    echo "Example: $0 -p 46677 root@example.com"
    exit 1
fi

autossh -M 0 -N -v \
    -o "ServerAliveInterval=30" \
    -o "ServerAliveCountMax=3" \
    -o "ExitOnForwardFailure=yes" \
    -L 8081:127.0.0.1:1919 \
    -p "$PORT" "$SERVER"
