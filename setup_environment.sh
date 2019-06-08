#!/bin/bash


setupEnvironment () {
  if [[ $1 == "Ubuntu" ]]; then
    if [ $2 == "18.05" ]; then
      sudo apt install python3-argcomplete
    elif [ $2 == "16.04" ]; then
      sudo apt install python3-pip
      sudo pip3 install argcomplete
    else
      errout "Allowable Ubuntu 18.04 and 16.04 not $2"
    fi
  else
    ROS_PATH_CACHE=$HOME/.cache/
    mkdir -p $ROS_PATH_CACHE/ros2_install/src
    cp ros2.repos $ROS_PATH_CACHE/ros2_install

    pushd $ROS_PATH_CACHE/ros2_install
    vcs import src < ros2.repos
    popd

    ROS_TEMP_WS=$HOME
    mkdir -p $ROS_TEMP_WS/ros2_ws/src
    cp -r ./ros-basic-example ./pynodes $ROS_TEMP_WS/ros2_ws/src
  fi
}
