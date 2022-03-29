#!/bin/bash

mkdir ~/Downloads/scripted-downloads/

wget -nc 'https://github.com/obsidianmd/obsidian-releases/releases/download/v0.13.31/Obsidian-0.13.31.AppImage' -P ~/Downloads/scripted-downloads/

echo "Want to open the directory?: Y/N";
read RB

if [[ $RB == Y || $RB == y ]]; then
dolphin ~/Downloads/scripted-downloads/
else
echo "

Installation Done!!!

"
fi
