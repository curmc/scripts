#!/bin/bash



COMMON_USER="common"
COMMON_IP="10.241.5.12"
COMMON_CONFIG="~/.ssh/config"
SSH="no"


USER=$COMMON_USER
IP=$COMMON_IP
CONFIG=$COMMON_CONFIG

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "ssh client for ralphie robot"
      echo " "
      echo "ssh client [OPTIONS] "
      echo " "
      echo "OPTIONS"
      echo "-h  --help        show this help menu"
      echo "-i  --ip          ip address of host"
      echo "-u  --user        username of host"
      echo "-s  --genssh      generate ssh keys (will fail if you have not done this yet"
      echo "-c  --config      config file name (default ~/.ssh/config"
      exit 0
      ;;
    -i|--ip)
      shift
      if test $# -gt 0; then
        IP=$1
        shift
      else
        echo "no ip address specified | -i/--ip"
        exit 1
      fi
      ;;
    -u|--user)
      shift
      if test $# -gt 0; then
        USER=$1
        shift
      else
        echo "no username specified | -u/--user"
        exit 1
      fi
      ;;
     -s|--genssh)
      SSH="yes"
      shift
      ;;
     -c|--config)
     shift
        if test $# -gt 0; then
          CONFIG=$1
          shift
        else
          echo "no file path specified | -c/--config"
          exit 1
        fi
        shift
     ;;
     *)
      break
      ;;
  esac
done




setup () {
  echo "Using IP address:   $IP"
  echo " "
  echo "Using User:         $USER"
  echo " "
  echo "Using config path:  $CONFIG"
  echo " "
  echo "Generating SSH?     $SSH"
  echo " "
  read -p "Are you sure? [Y/n]" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]];
  then 
    echo " "
    echo "======================================================"
    echo "Adding the following to $CONFIG"
    echo " "
    echo "------------------------------------"
    echo "User $USER

    Host ralphie
      HostName  $IP
      Port      22" 
    echo "------------------------------------"
    echo " "
    echo "======================================================"
    echo " "
    
    echo "User $USER

Host ralphie
  HostName  $IP
  Port      22"  >> $CONFIG

    echo "The following two commands are now equivalent:"
    echo " "
    echo "> ssh $USER@$IP"
    echo " "
    echo "> ssh ralphie"
    echo " "
    echo "======================================================"

  else
    echo " "
    echo "Good Bye!"
    exit 1
  fi
  unset $REPLY

}

gen-ssh-keys () {
  ssh-keygen
}

grab-host-keys () {
    echo "Adding public key to host's authorized ssh keys ....... "
    echo " "
    ssh-copy-id -i ~/.ssh/id_rsa.pub $USER@$IP
}

setup
if [[ $SSH == "yes" ]]; then
  gen-ssh-keys
fi
grab-host-keys

