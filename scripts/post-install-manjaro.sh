#!/bin/bash

lookandfeeltool -a org.kde.breezedark.desktop # applies the dark theme of KDE

echo "

Want to select the PACMAN packages or install all recommended? (S for selection menu / A for all): ";
read PACINST

echo "

Want to select the PIP packages or install all recommended? (S for selection menu / A for all): ";
read PIPINST

echo "

Want to install NVIDA GRAPHIC DRIVERS? (N for NVIDIA/ O for others [skip graphic driver installation]): ";
read GRPHDRI

echo "

After installtion, wanna reboot? Y/N: ";
read RB

echo "

Enter your password for SYSTEM UPDATE AND SYNC "
yes | sudo pacman -Syyu

if [[ $PACINST == "A" || $PACINST == "a" || $PACINST == "All" || $PACINST == "all" ]]; then
yes | sudo pacman -S $(for i in $(cat ../packages/pacman-packages.txt); do echo $i; done)
else
bash pacman-selection.sh && yes | sudo pacman -S $(for i in $(cat ../packages/to-install-pacman.txt); do echo $i; done)
fi

if [[ $PIPINST == "A" || $PIPINST == "a" || $PIPINST == "All" || $PIPINST == "all" ]]; then
yes | sudo pip install $(for i in $(cat ../packages/pip-packages.txt); do echo $i; done)
else
bash pip-selection.sh && yes | sudo pip install $(for i in $(cat ../packages/to-install-pip.txt); do echo $i; done)
fi

feh --bg-fill ../images/blur/wp4.png

if [[ $GRPHDRI == "N" || $GRPHDRI == "n" || $GRPHDRI == "NVIDIA" || $GRPHDRI == "nvidia" ]]; then
sudo mhwd -a pci nonfree 0300
else
:
fi

mv ../packages/to-install-pip.txt ../packages/pip-already-installed.txt

mv ../packages/to-install-pacman.txt ../packages/pacman-already-installed.txt

if [[ $RB == Y || $RB == y ]]; then
reboot
else
echo "

Installation Done!!!

"
fi
