#!/bin/bash

sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat archlinux-keyring ebtables iptables libguestfs vim

sudo systemctl enable libvirtd.service

sudo systemctl start libvirtd.service

echo "
Set the UNIX domain socket group ownership to libvirt, (around line 85)

unix_sock_group = \"libvirt\"

Set the UNIX socket permissions for the R/W socket (around line 102)

unix_sock_rw_perms = \"0770\"";
read NOTHING

sudo vim /etc/libvirt/libvirtd.conf

sudo usermod -a -G libvirt $(whoami)

sudo systemctl restart libvirtd.service

sudo modprobe -r kvm_amd

sudo modprobe kvm_amd nested=1

echo "options kvm-amd nested=1" | sudo tee /etc/modprobe.d/kvm-amd.conf

systool -m kvm_amd -v | grep nested

cat /sys/module/kvm_amd/parameters/nested
