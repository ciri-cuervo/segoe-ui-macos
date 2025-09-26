#!/bin/bash

# Authors:
# - original Linux script: mrbvrz - https://hasansuryaman.com
# - MacOS script: ciri-cuervo

# Colours Variables
RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

# Destination directory
ROOT_UID=0
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/Library/Fonts/"
else
  DEST_DIR="$HOME/Library/Fonts/"
fi

# Check Internet Conection
function cekkoneksi(){
    echo -e "$BLUE [ * ] Checking for internet connection"
    sleep 1

    echo -e "GET http://www.google.com/ HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "$RED [ X ]$BLUE Internet Connection ➜$RED OFFLINE!\n";
        echo -e "$RED Sorry, you really need an internet connection...."
        exit 0
    else
        echo -e "$GREEN [ ✔ ]$BLUE Internet Connection ➜$GREEN CONNECTED!\n";
        sleep 1
    fi
}

function cekfc(){
    echo -e "$BLUE [ * ] Checking for fontconfig"
    sleep 1

    which fc-cache > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ ✔ ]$BLUE fontconfig ➜$GREEN INSTALLED\n"
        sleep 1
    else
        echo -e "$RED [ X ]$BLUE fontconfig ➜$RED NOT INSTALLED\n"
        continueFc
    fi
}

function cekfont(){
    echo -e "$BLUE [ * ] Checking for Segoe-UI Font"
    sleep 1

    fc-list | grep -i "Segoe UI" >/dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ ✔ ]$BLUE Segoe-UI Font ➜$GREEN INSTALLED\n"
        sleep 1
    else
        echo -e "$RED [ X ]$BLUE Segoe-UI Font ➜$RED NOT INSTALLED\n"
        continueFont
    fi
}

function continueFont(){
    echo -e "$LGREEN Do you want to install Segoe-UI Font? (y)es, (n)o :"
    read  -p ' ' INPUT
    case $INPUT in
    [Yy]* ) fontinstall;;
    [Nn]* ) end;;
    * ) echo -e "$RED\n Sorry, try again."; continueFont;;
  esac
}

function fontinstall(){
    mkdir -p "$DEST_DIR"
    curl -fsSL -o "$DEST_DIR/segoeui.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeui.ttf?raw=true"     # regular
    curl -fsSL -o "$DEST_DIR/segoeuib.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuib.ttf?raw=true"   # bold
    curl -fsSL -o "$DEST_DIR/segoeuii.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuii.ttf?raw=true"   # italic
    curl -fsSL -o "$DEST_DIR/segoeuiz.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuiz.ttf?raw=true"   # bold italic
    curl -fsSL -o "$DEST_DIR/segoeuil.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuil.ttf?raw=true"   # light
    curl -fsSL -o "$DEST_DIR/seguili.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/seguili.ttf?raw=true"     # light italic
    curl -fsSL -o "$DEST_DIR/segoeuisl.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuisl.ttf?raw=true" # semilight
    curl -fsSL -o "$DEST_DIR/seguisli.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisli.ttf?raw=true"   # semilight italic
    curl -fsSL -o "$DEST_DIR/seguisb.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisb.ttf?raw=true"     # semibold
    curl -fsSL -o "$DEST_DIR/seguisbi.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisbi.ttf?raw=true"   # semibold italic
    curl -fsSL -o "$DEST_DIR/seguibl.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/seguibl.ttf?raw=true"     # bold light
    curl -fsSL -o "$DEST_DIR/seguibli.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/seguibli.ttf?raw=true"   # bold light italic
    curl -fsSL -o "$DEST_DIR/seguiemj.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/seguiemj.ttf?raw=true"   # emoji
    curl -fsSL -o "$DEST_DIR/seguisym.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisym.ttf?raw=true"   # symbol
    curl -fsSL -o "$DEST_DIR/seguihis.ttf" "https://github.com/mrbvrz/segoe-ui/raw/master/font/seguihis.ttf?raw=true"   # historic

    fc-cache -f "$DEST_DIR"
    echo -e "$GREEN\n Font installed on $LBLUE'$DEST_DIR'"
}

function continueFc() {
  echo -e "$LGREEN Do you want to install fontconfig via Homebrew? (y)es, (n)o :"
  read  -p ' ' INPUT
  case $INPUT in
    [Yy]* ) fcinstall;;
    [Nn]* ) end;;
    * ) echo -e "$RED\n Sorry, try again."; continueFc;;
  esac
}

function fcinstall(){
    sleep 1
    which brew > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ 🍺  ]$BLUE Homebrew ➜$GREEN INSTALLED\n"
        sleep 1
    else
        echo -e "$RED [ X ]$BLUE Homebrew ➜$RED NOT INSTALLED\n"
        sleep 1
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install fontconfig
}

function end(){
    echo -e "$LPURPLE\n Bye..... ;)"
    exit 0
}

function banner(){
    echo -e "$LYELLOW" ""
    echo -e "                                         _    __            _   "
    echo -e "                                        (_)  / _|          | |  "
    echo -e "  ___  ___  __ _  ___   ___        _   _ _  | |_ ___  _ __ | |_ "
    echo -e " / __|/ _ \/ _  |/ _ \ / _ \  __  | | | | | |  _/ _ \|  _ \| __|"
    echo -e " \__ \  __/ (_| | (_) |  __/ (__) | |_| | | | || (_) | | | | |_ "
    echo -e " |___/\___|\__, |\___/ \___|       \__,_|_| |_| \___/|_| |_|\__|"
    echo -e "            __/ |                                               "
    echo -e "           |___/             $LPURPLE mrbvrz$LCYAN -$RED https://hasansuryaman.com        "
    echo -e "                             $LPURPLE ciri-cuervo"
    echo -e "$LYELLOW ---------------------------------------------------------------"
    echo ""
}

main(){
    clear
    banner
    cekkoneksi
    cekfc
    cekfont
}

main
