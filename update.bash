#!/bin/bash
# Update from remotes:

REMOTE="https://github.com/curmc/sentinet_ros.git"

CATKIN_PREFIX="`pwd`/catkin_ws"
PREFIX="$CATKIN_PREFIX/src/sentinet_ros"
ROS_VERSION="melodic"

if [ -d "/opt/ros" ]; then
	# Assume one version for now
	ROS_VERSION=$(ls "/opt/ros")
else
	echo "You don't have ros installed"
	exit
fi

echo "Updating for Ros version: $ROS_VERSION"

# Check for up to date dot file
ROS_COMMAND="source /opt/ros/melodic/setup.bash"
if grep -Fxq "$ROS_COMMAND" "$HOME/.bashrc"
then
	echo "All set up in rc"
else
	echo $ROS_COMMAND >> "$HOME/.bashrc"
	echo "Updated bashrc, please start a new shell and run again"
        exit
fi

# Pull from remotes etc.
git_update () {
	if [ -d $PREFIX ]; then
		echo "good"
	else
		git clone $REMOTE $PREFIX
	fi
	pushd $PREFIX
	git remote update
	git pull origin master
	popd
}

catkin_ws_update () {
	if [ -d $CATKIN_PREFIX ]; then
		pushd $CATKIN_PREFIX
		catkin_make
		popd
	else
		mkdir -p "$CATKIN_PREFIX/src"
		pushd $CATKIN_PREFIX
		catkin_make
		popd
	fi
}



git_update
catkin_ws_update
