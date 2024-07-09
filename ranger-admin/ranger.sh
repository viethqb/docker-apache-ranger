#!/bin/bash

if [ ! -e ${RANGER_HOME}/.setupDone ]
then
  SETUP_RANGER=true
else
  SETUP_RANGER=false
fi

if [ "${SETUP_RANGER}" == "true" ]
then
  cd "${RANGER_HOME}"/admin || exit
  if ./setup.sh;
  then
    touch "${RANGER_HOME}"/.setupDone
  else
    echo "Ranger Admin Setup Script didn't complete proper execution."
  fi
fi

cd ${RANGER_HOME}/admin && ./ews/ranger-admin-services.sh start

sleep 30

RANGER_ADMIN_PID=`ps -ef  | grep -v grep | grep -i "org.apache.ranger.server.tomcat.EmbeddedServer" | awk '{print $2}'`

# prevent the container from exiting
if [ -z "$RANGER_ADMIN_PID" ]
then
  echo "Ranger Admin process probably exited, no process id found!"
else
  tail --pid=$RANGER_ADMIN_PID -f /dev/null
fi
