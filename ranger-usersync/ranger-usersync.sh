#!/usr/bin/env bash

if [ -f "${RANGER_SCRIPTS}/ranger-usersync-install.properties" ]; then
  cp -f ${RANGER_SCRIPTS}/ranger-usersync-install.properties ${RANGER_HOME}/usersync/install.properties
fi

if [ -d "/tmp/conf.dist" ]; then
  cp -r /tmp/conf.dist/* ${RANGER_HOME}/usersync/conf.dist/
fi

if [ ! -e ${RANGER_HOME}/.setupDone ]
then
  SETUP_RANGER=true
else
  SETUP_RANGER=false
fi

if [ "${SETUP_RANGER}" == "true" ]
then
  cd "${RANGER_HOME}"/usersync || exit
  if ./setup.sh;
  then
    touch "${RANGER_HOME}"/.setupDone
  else
    echo "Ranger UserSync Setup Script didn't complete proper execution."
  fi
fi


/usr/bin/ranger-usersync start

RANGER_USERSYNC_PID=`ps -ef  | grep -v grep | grep -i "org.apache.ranger.authentication.UnixAuthenticationService" | awk '{print $2}'`

# prevent the container from exiting
if [ -z "$RANGER_USERSYNC_PID" ]
then
  echo "The UserSync process probably exited, no process id found!"
else
  # tail --pid=$RANGER_USERSYNC_PID -f /dev/null
  tail -f ${RANGER_HOME}/usersync/logs/* /var/log/ranger/usersync/*
fi
