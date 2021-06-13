#!/bin/bash

##################################################################################################
# Author: Jayesh Joshi                                                                           # 
# Description: Auto install bash script to setup required programs after doing fresh install.    # 
# Tested against Debian based distributions like Ubuntu 16.04/18.04 and zorin os.                #        
##################################################################################################

# Upgrade and Update Command
echo -e "${c}Updating and upgrading before performing further operations."; $r
sudo apt update -y && sudo apt upgrade -y
sudo apt --fix-broken install -y

# Enable dark mode and show theame list
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
ls -d /usr/share/themes/* |xargs -L 1 basename
sleep 9

# Install figlet
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y figlet

# Display Banner              
#                _        _____      _               
#     /\        | |      / ____|    | |              
#    /  \  _   _| |_ ___| (___   ___| |_ _   _ _ __  
#   / /\ \| | | | __/ _ \\___ \ / _ \ __| | | | '_ \ 
#  / ____ \ |_| | || (_) |___) |  __/ |_| |_| | |_) |
# /_/    \_\__,_|\__\___/_____/ \___|\__|\__,_| .__/ 
#                                             | |    
#                                             |_|       
if [[ ! -z $(which figlet) ]]; then
    figlet AutoSetup
fi

# Multi option 
figlet choose any option 

blanck

# Required dependencies for all softwares (important)
echo -e "${c}Installing complete dependencies pack."; $r
sudo apt install -y software-properties-common apt-transport-https build-essential checkinstall libreadline-gplv2-dev libxssl libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev autoconf automake libtool make g++ unzip flex bison gcc libssl-dev libyaml-dev libreadline6-dev zlib1g zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev libpq-dev libpcap-dev libmagickwand-dev libappindicator3-1 libindicator3-7 imagemagick xdg-utils

# Show Battery Percentage on Top Bar [Debian (gnome)]
if [ $XDG_CURRENT_DESKTOP == 'GNOME' ]; then
	gsettings set org.gnome.desktop.interface show-battery-percentage true
fi

# Install TLP battery optimization (Improve Battery Life)
sudo apt install -y tlp

# Start TLP & show status 
sudo tlp start
sudo tlp-stat -s
sleep 5

# Install Hardinfo (show hardware info) & timeshift (compleate backup of the os)
sudo apt install -y hardinfo
sudo apt install -y timeshift

# Install gnome terminal
if ! command -v gnome-terminal
then
    sudo apt-get install -y gnome-terminal
fi

# Install htop (task manger in terminal)
# site https://linuxhint.com/best_7_linux_terminals/
sudo apt install -y htop

# Start htop
gnome-terminal -e htop
gnome-terminal --tab --title="test" --command="htop"
 
# Install Stacer GUI-based Linux system optimizer (better task manager) 
# site https://www.ubuntupit.com/best-linux-task-managers-reviewed-for-linux-nerds/
# site2 https://linuxhint.com/best_system_monitoring_tools_for_ubuntu/
# site3 https://medium.com/@alex285/get-powerlevel9k-the-most-cool-linux-shell-ever-1c38516b0caa
# site4 https://linuxhint.com/best_system_monitoring_tools_for_ubuntu/
sudo apt install stacer -y
if ! command -v stacer
then
     sudo add-apt-repository ppa:oguzhaninan/stacer -y
     sudo apt-get update
     sudo apt-get install stacer -y
fi
if ! command -v stacer
then
     cd ~/Downloads
     wget https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb
     sudo dpkg -i stacer_1.1.0_amd64.deb
     apt install stacer
     sudo apt --fix-broken install -y
     rm stacer_1.1.0_amd64.deb
fi

# Check that stacer is there
if ! command -v stacer
then
    echo "stacer cannot be installed"
    figlet stacer cannot be installed
fi

# Try to run stacer and install again
     cd ~/Downloads
     wget https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb
     sudo dpkg -i stacer_1.1.0_amd64.deb
     sudo apt --fix-broken install -y
     apt install stacer
     rm stacer_1.1.0_amd64.deb

     stacer

# Install ncdu (show stroge usage)
sudo apt install ncdu -y

# start ncdu
gnome-terminal -e ncdu

# Install eDEX-UI (cool hackery type termianl)
# site https://github.com/GitSquared/edex-ui/releases
cd ~/Downloads
mkdir edex
cd edex
wget https://github.com/GitSquared/edex-ui/releases/download/v2.2.7/eDEX-UI-Linux-x86_64.AppImage
chmod +x eDEX-UI-Linux-x86_64.AppImage

# Install tmux (windows manager like i3)
# There wiil be a sesion name enor
# Site https://phoenixnap.com/kb/tmux-tutorial-install-commands
sudo apt install -y tmux



# Final Upgrade and Update Command
echo -e "${c}Updating and upgrading to finish auto-setup script."; $r
sudo apt update && sudo apt upgrade -y
sudo apt --fix-broken install -y

# Thing i was not able to add
# Taskbar pin shortcut i searched a lot but could not do
# Auto use tmux hmmm maby could do 
# Multi chose option i wanted it to be like ( 1,3) and not be like 1 then 3 
# site https://www.google.com/search?q=how+to+setup+linux+taskbar+in+ubuntu+using+bash+script&safe=active&rlz=1C1CHNY_enIN915IN915&biw=1422&bih=677&sxsrf=ALeKk03OmXbIqrMWXUAsNJ74_2pwdikLPw%3A1623262166484&ei=1gPBYNyOHZHfz7sPtK2huAU&oq=how+to+setup+linux+taskbar+in+ubuntu+using+bash+&gs_lcp=Cgdnd3Mtd2l6EAEYADIFCCEQoAEyBQghEKABMgUIIRCgAToHCAAQRxCwAzoICCEQFhAdEB5QkxFY5zRguz5oAXACeACAAeEBiAH5EJIBBjAuMTIuMZgBAKABAaoBB2d3cy13aXrIAQjAAQE&sclient=gws-wiz
# Maby other things i want to add

# Installation done
figlet autosetup is done
figlet _________________

# Things need to do after autosetup
# Maby need to do
figlet Maby need to do
figlet _______________
figlet dark mode
figlet _________
figlet taskbar
figlet _______
figlet other if needed
figlet _______________

# Need to do 
figlet extra services
figlet ______________
figlet remove software not needed
figlet __________________________
figlet other things
figlet ____________

# Exit 
cd ~
exit
