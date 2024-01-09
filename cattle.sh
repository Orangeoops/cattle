#!/bin/bash

# Prompt user if running script as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# Prompt user if file is executable
if [[ ! -x "$0" ]]; then
    echo "This script must be executable. Please run 'chmod +x $0' and try again."
    exit 1
fi

# Define initial app lists
aptapps=("yt-dlp" "neofetch" "btop" "htop" "cifs-utils" "curl" "wget" "nomacs" "nmap" "notepadqq" "python3" "pip" "vlc" "mpv" "gimp" "glimpse" "qbittorrent" "telegram-desktop")
snapapps=("brave" "irfanview" "kdenlive")
removeapps=("firefox" "thunderbird" "ktorrent")

# Show current app lists
echo "Current apt apps: ${aptapps[*]}"
echo "Current snap apps: ${snapapps[*]}"
echo "Current remove apps: ${removeapps[*]}"

# Allow user to add new apps to each list
#read -p "Enter new apt apps (separated by spaces): " -a new_aptapps
#aptapps+=("${new_aptapps[@]}")
#
#read -p "Enter new snap apps (separated by spaces): " -a new_snapapps
#snapapps+=("${new_snapapps[@]}")
#
#read -p "Enter new remove apps (separated by spaces): " -a new_removeapps
#removeapps+=("${new_removeapps[@]}")

# Update the system package list and upgrade the installed packages
sudo apt update && sudo apt upgrade -y

# Uninstall unwanted packages
sudo apt remove -y "${removeapps[@]}"
sudo snap remove --purge "${removeapps[@]}"

# Snap Install apps...
sudo snap install "${snapapps[@]}"

# Apt Install apps...
sudo apt install -y "${aptapps[@]}"

# Automatically agree to additional space needed
sudo apt-get autoremove -y && sudo apt-get autoclean -y
