#!/bin/bash

restart_after_seconds=3600
sleep_for_seconds=600


if [ -z "$1" ]
  then
    echo "Usage: first argument must be the key"
    echo "found in your Youtube Classic Studio"
    exit 0
fi

pid=0
while true
do
  if [[ pid -eq 0 ]];
    then
      ./initiate_stream.sh $1 1&>2 >> nohup.out &
      pid=$!
    else
      sleep 60
      if [[ $SECONDS -gt $restart_after_seconds ]];
        then
          kill -15 $pid
          sleep $sleep_for_seconds
          pid=0
          SECONDS=0
      fi
  fi
done

