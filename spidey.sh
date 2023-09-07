#!/usr/bin/env bash
#Inital shebang

## ANSI colors (FG)
RED="$(printf '\033[31m')"  GREEN="\e[1;32m"  ORANGE="\e[1;33m"  BLUE="\e[1;34m"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="\e[1;37m" BLACK="$(printf '\033[30m')"
purple="\e[1;35m" darkgray="\e[1;30m"
# Automation Function
# banner display
menuprincipal () {
clear
TIME=1
echo -e "${purple}"
echo '

  _________        .__     .___               
 /   _____/______  |__|  __| _/ ____  ___.__. 
 \_____  \ \____ \ |  | / __ |_/ __ \<   |  | 
 /        \|  |_> >|  |/ /_/ |\  ___/ \___  |           
/_______  /|   __/ |__|\____ | \___  >/ ___ _| 
        \/ |__|             \/     \/ \/        / _ \
                                              \_\(_)/_/
                                               _//"\\_  d4rkd3v1l..
                                                /   \
                 Linked with https://github.com/d4rkd3v1l1702
                           Tool Created by GOBINATH
                       [!] This Tool Must Run As ROOT [!]
                                Version : 1.0                                          
# ---------------------------------------------------------------------------------------#   
# Script Name:   spidey.sh                                                               |
# Description:   Basic Universal linux setup for beginners.                                       |   
# Written by:    GOBINATH                                                                |
# Maintenance:   GOBINATH                                                                |
# ---------------------------------------------------------------------------------------#
# Usage:                                                                                 |
#       $ ./spidey.sh                                                                    |
# ---------------------------------------------------------------------------------------#
# Bash Version:                                                                          |
#          GNU bash, version 5.1.16(1)-release (x86_64-pc-linux-gnu)                     |
#          Copyright (C) 2020 Free Software Foundation, Inc.                             |
#          License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html> |
# ---------------------------------------------------------------------------------------#
'
echo -e "\e[31mSystem Information\e[0m"
# Hostname
hostname=$(hostname)
echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Hostname : "${GREEN}$hostname${WHITE}""

# Username
Whoami=$(whoami)
echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Whoami : "${GREEN}$Whoami${WHITE}""

# Kernel version
kernel=$(uname -r)
echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Kernel Version : "${GREEN}$kernel${WHITE}""

# Internet Connection
check_status() {
    echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Internet Status : "
    timeout 3s curl -fIs "https://api.github.com" > /dev/null
    [ $? -eq 0 ] && echo -e "${GREEN}Online${WHITE}" || echo -e "${BLACK}Offline--->Please Connect your System with Internet${WHITE}"
}
check_status

#Serial Number
SERIAL_NUMBER=`sudo dmidecode -t 1 | grep -i serial`
echo -ne "${RED}[${ORANGE}+${RED}]${MAGENTA}"$SERIAL_NUMBER${WHITE}" "

sleep $TIME
echo ''
#Main Script logic
echo -e "\e[1;91m <--------------------------Tool Categories---------------------------------> \e[0m"
echo -e "${darkgray}Choose an option below! ${WHITE}"
echo -e "\e[1;32m\t\t\t 1) Check Distro \e[0m"
echo -e "\e[1;32m\t\t\t 2) Universal Updater\e[0m"
echo -e "\e[1;32m\t\t\t 3) Universal Installer\e[0m"
echo -e "\e[1;32m\t\t\t 4) Flatpak & repo \e[0m"
echo -e "\e[1;32m\t\t\t 5) BatteryCheck\e[0m"
echo -e "\e[1;32m\t\t\t 6) Trash Unwanted \e[0m"
echo -e "\e[1;32m\t\t\t 7) Credits \e[0m"
echo -e "\e[1;32m\t\t\t 0) Exit \e[0m"
echo -e "\e[1;91m <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~> \e[0m"
read -p "Enter your choice: " choice 

case $choice in
1) # check DNS
        detect_distribution(){
        # Check if /etc/os-release file exists
        if [ -e /etc/os-release ]; then
                source /etc/os-release
        # Extract distribution name and package manager
        distribution_name="$ID_LIKE"
        package_manager=""

        # Detect the package manager
                if [ "$distribution_name" == "ubuntu" ] || [ "$distribution_name" == "debian" ]; then
                        package_manager="apt"
                elif [ "$distribution_name" == "fedora" ]; then
                        package_manager="dnf"
                elif [ "$distribution_name" == "arch" ]; then
                        package_manager="pacman"
                fi

                if [ -n "$package_manager" ]; then
                       echo -e "${GREEN}[${WHITE}-->${GREEN}]${CYAN} Detected distribution: "${GREEN}$distribution_name${WHITE}""
                       echo -e "${GREEN}[${WHITE}-->${GREEN}]${CYAN} Package manager: "${GREEN}$package_manager${WHITE}""
                else
                        echo "Distribution not supported or package manager not detected."
                fi
        else
                echo "The /etc/os-release file does not exist. Unable to detect distribution."
        fi
        }
        detect_distribution
        read -n 1 -p "<Enter> for main menu"
	menuprincipal
        ;;
2) # Universal Installer
        if command -v apt-get &> /dev/null; then
                echo -e "\e[1;36m Updating using APT...\e[0m"
                sudo apt-get update
                sudo apt-get -y upgrade
        fi
        if command -v dnf &> /dev/null; then
                echo -e "\e[1;36m Updating using DNF...\e[0m"
                sudo dnf check-update
                sudo dnf -y upgrade
        fi
        if command -v yay &> /dev/null; then
                echo -e "\e[1;36m Updating using Yay...\e[0m"
                yay -Syu --noconfirm
        fi
        if command -v pacman &> /dev/null; then
                echo -e "\e[1;36m Updating using Pacman...\e[0m"
                sudo pacman -Syu --noconfirm
        fi
        echo -e "${BLUE}Update completed.${WHITE}"
        read -n 1 -p "<Enter> for main menu"
	menuprincipal
        ;;
4) #Flatpak & repo

        if command -v apt-get &> /dev/null; then
                echo "Using APT package manager..."
                sudo apt-get update
                sudo apt-get install -y flatpak
                sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        elif command -v dnf &> /dev/null; then
                echo "Using DNF package manager..."
                sudo dnf install -y flatpak
                flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        elif command -v pacman &> /dev/null; then
                echo "Using Pacman package manager..."
                sudo pacman -Syu --noconfirm flatpak
                flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
                
        else
                echo "Unsupported package manager. Please install Flatpak manually."
                exit 1
        fi
        echo -e "${BLUE}Installation and Flathub repository setup complete.${WHITE}"
        read -n 1 -p "<Enter> for main menu"
	menuprincipal        
        ;;

3) #Univeresal Installer (Software or hacking tool)

        packages=(
                    htop
                    stacer
                    gnome-tweak
                    )
        if command -v apt-get &> /dev/null; then
                echo -e "\e[1;33m Using APT package manager...\e[0m"
                sudo apt-get update
                sudo apt-get -y install "${packages[@]}"
        elif command -v dnf &> /dev/null; then
                echo -e "\e[1;33m Using Fedora package manager...\e[0m"
                sudo dnf -y install "${packages[@]}"
        elif command -v pacman &> /dev/null; then
                echo -e "\e[1;33m Using Pacman package manager...\e[0m"
                sudo pacman -Syu --noconfirm "${packages[@]}"
        elif command -v yay &> /dev/null; then
                echo -e "\e[1;33m Using Yay AUR helper...\e[0m"
                yay -Syu --noconfirm "${packages[@]}"
        else
                echo "Unsupported package manager. Please install software manually."
                exit 1
        fi
        echo -e "${RED}Installation complete.${WHITE}"
        read -n 1 -p "<Enter> for main menu"
	menuprincipal
        ;;
5) #batterycheck
        echo -e "\e[1;36m Battery Manufacturer:\e[0m"
        battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1)
        echo "$battery_info" | grep -E "vendor|model|serial"
        echo ' '
        echo -e "\e[1;36m Battery Information:\e[0m"
        battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1)
        if ! type "upower" &>/dev/null; then
                echo "No battery found or 'upower' command not available."
                exit 1
        fi
        echo  "$battery_info" | grep -E "state|time to empty|percentage|capacity|voltage|energy-rate"
        read -n 1 -p "<Enter> for main menu"
	menuprincipal
        ;;
6) # Trash
        if command -v apt-get &> /dev/null; then
                echo -e "\e[1;33m Using APT package manager...\e[0m"
                sudo apt-get autoremove --purge -y
                sudo apt-get clean
        elif command -v dnf &> /dev/null; then
                echo -e "\e[1;33m Using Fedora package manager...\e[0m"
                sudo dnf clean all
        elif command -v pacman &> /dev/null; then
                echo -e "\e[1;33m Using Pacman package manager...\e[0m"
                sudo pacman -Sc --noconfirm
        else
                echo "Unsupported package manager. Please clean up manually."
        exit 1
        fi
        echo -e "${CYAN}Auto remove and auto clean complete.${WHITE}"
        read -n 1 -p "<Enter> for main menu"
	menuprincipal
        ;;
7) # Credit
        echo
        echo -e "${BLUE}Made by ${GREEN}GOBINATH ${BLUE}with <3"
        echo 
        echo -e "${ORANGE}Wants to Connect with me:"
	echo
	echo -e "${GREEN}Search ${BLUE}d4rkd3v1l1702 ${GREEN}on Github and support. ${RED}<3"
	echo
        read -n 1 -p "<Enter> for main menu"
	menuprincipal
        ;;
0) 
	echo Exiting the system...
       	sleep $TIME
	exit 0
	;;        

*) # Terminate
        echo "Invalid choice. Please Choose From Option"
        exit 1
        ;;
esac 
}
menuprincipal
