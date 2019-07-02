#!/bin/bash


# @ param 1 - base or desktop
# @ param 2 - crystal or melodic

install_ubuntu_ros () {
  echo "Installing Ros $2 $1 for Ubuntu"
  if [[ $1 == 'base' ]]; then
    sudo apt install ros-$2-base
  fi
  if [[ $1 == 'desktop' ]]; then
    sudo apt install ros-$2-desktop
  fi
  sudo apt install python3-colcon-common-extensions
}
