#!/usr/bin/env bash

# needed tools / packages
# pkg_add -P / -r arping
# pkg_add -P / -r bash

fatal() {
  printf "%s\n" "$@"
  exit 1
}

print_prompt() {
  echo "--------------------------------------------------------------------"
  echo " SmartOS VM Guest Tools - Install (FreeBSD)"
  echo "--------------------------------------------------------------------"
  echo  
  echo "This script will install startup tools for SmartOS virtual machine"
  echo "guests. This includes an rc.local script which will be used to set"
  echo "root administrator ssh keys, as well as tools to automatically" 
  echo "format secondary disks, and other generic tools."
  echo "Tools will be located in /lib/smartdc, but will not be included in"
  echo "your \$PATH environment variable automatically"
  echo
  echo
}

install_tools() {
  echo "Installing SmartOS VM Guest Tools..."
  cp -r ./lib/smartdc /lib/
}

install_freebsd() {
  install_tools

  pkg_add -P / -r arping &>/dev/null
  pkg_add -P / -r bash &>/dev/null

  if [ $install_virtio == "Y" ]; then
    pkg_add -P / -r ftp://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/virtio-kmod.tbz
    cat >> /boot/loader.conf << EOF
virtio_load="YES"
virtio_pci_load="YES"
virtio_blk_load="YES"
if_vtnet_load="YES"
virtio_balloon_load="YES"
EOF

    sed -i.bak -Ee 's|/dev/ada?|/dev/vtbd|' /etc/fstab
    sed -i -e 's|em0|vtnet0|' /etc/rc.conf
  fi

  echo "Installing freebsd-flavour specific files..."
  cp ./etc/rc.d/smartdc /etc/rc.d/smartdc

  printf 'smartdc_enable="YES"' >> /etc/rc.conf
}

if [[ $EUID -ne 0 ]] ; then
  fatal "You must be root to run this command"
fi

## MAIN ##
clear
print_prompt
while true ; do
  yn=N
  read -p "Do you want to continue (y/N) " yn
  case $yn in
    [Yy]* )
      break
      ;;
    [Nn]* )
      exit
      ;;
    *)
      echo "Plese answer either 'y' or 'n'"
      ;;
    esac
done

while true ; do
  install_virtio=Y
  read -p "Do you want to install virtio drivers (Y/n) " install_virtio
  case $install_virtio in
    [Yy]* )
      install_virtio="Y"
      break
      ;;
    [Nn]* )
      break
      ;;
    *)
      echo "Plese answer either 'y' or 'n'"
      ;;
    esac
done

case `uname -s` in
  FreeBSD)
    install_freebsd
    ;;
  *)
    fatal "Sorry. Your OS is not supported by this installer"
    ;;
esac

echo 
echo "All done!"
echo 
