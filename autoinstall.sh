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

# Enable dark mode and show themes list
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
ls -d /usr/share/themes/* |xargs -L 1 basename

# Show themes list indicator
echo -e "\033[1;35m Themes list"
# Other options and colors 
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux#:~:text=some%20variables%20that%20you%20can%20use%3A
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux#:~:text=4.-,background%20mode,-This%20mode%20is

sleep 9

# Install figlet
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y figlet

# Display Banner              
#                _       _____           _        _ _ 
#     /\        | |     |_   _|         | |      | | |
#    /  \  _   _| |_ ___  | |  _ __  ___| |_ __ _| | |
#   / /\ \| | | | __/ _ \ | | | '_ \/ __| __/ _` | | |
#  / ____ \ |_| | || (_) || |_| | | \__ \ || (_| | | |
# /_/    \_\__,_|\__\___/_____|_| |_|___/\__\__,_|_|_|
#                                                     
                                                      
if [[ ! -z $(which figlet) ]]; then
    figlet AutoInstall
fi

# Multi option 
figlet choose any option 

# Site https://serverfault.com/questions/144939/multi-select-menu-in-bash-script#:~:text=I%20used%20the%20example%20from%20MestreLion%20and%20drafted%20the%20code%20below.%20All%20you%20need%20to%20do%20is%20update%20the%20options%20and%20actions%20in%20the%20first%20two%20sections.
# Menu options
options[0]="Sign in my account"
options[1]="All my files and folers"
options[2]="Set my home screen wallpaper"
options[3]="Start tmux session"

# Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        # Option 1 selected (Sign in my account)
        echo "Please enter your username and password"
        echo "Username"
        read username
        echo "Password"
        read password
        curl -u $username:$password --silent "https://mail.google.com/mail/feed/atom" |  grep -oPm1 "(?<=<title>)[^<]+" | sed '1d'
    fi
    if [[ ${choices[1]} ]]; then
        # Option 2 selected (Get my data)
        # Site1 https://www.howtogeek.com/414082/how-to-zip-or-unzip-files-from-the-linux-terminal/
        cd ~/Downloads                          # Move to Downloads folder as defaul place 
        wget                                    # Link here 
        unzip                                   # Unzip file and file name here
    fi
    if [[ ${choices[2]} ]]; then
        # Option 3 selected (set wallpaper if i dont like the default one)
        # Site1 https://connectwww.com/change-ubuntu-background-to-solid-colour-set-wallpaper-to-solid-color-in-ubuntu/62142/ 
        gsettings set org.gnome.desktop.background primary-color '#000b18'
        gsettings set org.gnome.desktop.background secondary-color '#1d1d1f'
        gsettings set org.gnome.desktop.background color-shading-type 'horizontal'
    fi
    if [[ ${choices[3]} ]]; then
        #Option 4 selected (this will start a tmux session and save it) 

       # Add tmux session
       # Site1 https://askubuntu.com/questions/830484/how-to-start-tmux-with-several-panes-open-at-the-same-time
       # Site2 https://stackoverflow.com/questions/31902929/how-to-write-a-shell-script-that-starts-tmux-session-and-then-runs-a-ruby-scrip
       # Site3 https://unix.stackexchange.com/questions/171488/why-is-my-second-tmux-session-not-shown-in-ps-aux-or-htop-but-in-tmux-list-sessi
       # Site4 https://stackoverflow.com/questions/5609192/how-to-set-up-tmux-so-that-it-starts-up-with-specified-windows-opened
             tmux new-session -d -s enor 'htop';          # start new detached tmux session, run htop
             tmux split-window -h;                        # split the detached tmux session
             tmux send 'ncdu' ENTER;                      # send 2nd command 'ncdu' to 2nd pane.
             tmux split-window -v ;                       # split vertically
             tmux send 'neofetch' ENTER;                  # start neofetch (neofetch is like pfetch)
             tmux a;                                      # open (attach) tmux session.
    fi
}

# Variables
ERROR=" "

#Menu function
function MENU {
    echo "Menu Options"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}

# Menu loop
while MENU && read -e -p "Select the desired options using their number (again to uncheck, ENTER when done): " -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

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

# indicates tlp status
echo -e "\033[1;35m tlp list"

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
gnome-terminal --tab --title="taskmanager" --command="htop"

# Install neofetch show system info system info (there is also pfetch)
sudo apt install -y neofetch 
 
# Install Stacer GUI-based Linux system optimizer (better task manager) 
# site https://www.ubuntupit.com/best-linux-task-managers-reviewed-for-linux-nerds/
# site2 https://linuxhint.com/best_system_monitoring_tools_for_ubuntu/
# site3 https://medium.com/@alex285/get-powerlevel9k-the-most-cool-linux-shell-ever-1c38516b0caa
sudo apt install stacer -y
if ! command -v stacer
then
     sudo add-apt-repository ppa:oguzhaninan/stacer -y
     sudo apt-get -y update
     sudo apt-get install stacer -y
fi
if ! command -v stacer
then
 # site https://dev.to/strotgen/download-latest-release-file-from-github-2jjc
 # site2 https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
     cd ~/Downloads
     curl  https://api.github.com/repos/oguzhaninan/Stacer/releases/latest \
     | grep "browser_download_url.*deb" \
     | cut -d : -f 2,3 \
     | tr -d \" \
     | wget -cqi - -O stacer.deb
     sudo dpkg -i stacer.deb
     apt install stacer -y
     sudo apt --fix-broken install -y
     rm stacer.deb
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
     sudo apt install stacer -y
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
curl  https://api.github.com/repos/GitSquared/edex-ui/releases/latest \
| grep "browser_download_url.*AppImage" \
| grep x86_64 \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -cqi - -O edex.AppImage
chmod +x edex.AppImage

# Install tmux (windows manager like i3)
# There will be a sesion name enor
# Site https://phoenixnap.com/kb/tmux-tutorial-install-commands
sudo apt install -y tmux

# Download all AppImages
cd ~
mkdir AppImage
cd AppImage
# stacer
     curl  https://api.github.com/repos/oguzhaninan/Stacer/releases/latest \
     | grep "browser_download_url.*AppImage" \
     | cut -d : -f 2,3 \
     | tr -d \" \
     | wget -cqi - -O stacer.AppImage
     chmod +x stacer.AppImage
#eDEX UI
     curl  https://api.github.com/repos/GitSquared/edex-ui/releases/latest \
     | grep "browser_download_url.*AppImage" \
     | grep i386 \
     | cut -d : -f 2,3 \
     | tr -d \" \
     | wget -cqi - -O edex-i386.AppImage
     chmod +x edex-i386.AppImage
# Final Upgrade and Update Command
echo -e "${c}Updating and upgrading to finish auto-setup script."; $r
sudo apt update -y && sudo apt upgrade -y
sudo apt --fix-broken install -y

# Thing i was not able to add
# Taskbar pin shortcut i searched a lot but could not do
# Auto use tmux hmmm maby could do 
# Multi chose option i wanted it to be like ( 1,3) and not be like 1 then 3 
# I could not set the background because it requires a specific username so i am not able to add it
# site https://www.google.com/search?q=how+to+setup+linux+taskbar+in+ubuntu+using+bash+script&safe=active&rlz=1C1CHNY_enIN915IN915&biw=1422&bih=677&sxsrf=ALeKk03OmXbIqrMWXUAsNJ74_2pwdikLPw%3A1623262166484&ei=1gPBYNyOHZHfz7sPtK2huAU&oq=how+to+setup+linux+taskbar+in+ubuntu+using+bash+&gs_lcp=Cgdnd3Mtd2l6EAEYADIFCCEQoAEyBQghEKABMgUIIRCgAToHCAAQRxCwAzoICCEQFhAdEB5QkxFY5zRguz5oAXACeACAAeEBiAH5EJIBBjAuMTIuMZgBAKABAaoBB2d3cy13aXrIAQjAAQE&sclient=gws-wiz
# Maby other things i want to add

# Installation done
figlet autoinstall is done
figlet _________________

# Things need to do after autoinstall
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

sleep 15

# This will act upon the menu options
ACTIONS

# Exit 
cd ~
exit
