#!/usr/bin/env zsh

tpl="./org.nixos.nix-daemon.plist"
plist="/Library/LaunchDaemons/org.nixos.nix-daemon.plist"

cat $tpl | sed -e "s#PROXY_HOLDER#$ALL_PROXY#" | sudo tee $plist > /dev/null

echo 'content of plist'
cat $plist

sudo launchctl unload $plist
sudo launchctl load $plist
