#!/bin/bash

vpipe=/tmp/videopipe
apipe=/tmp/audiopipe
fps=15
vw=1280
vh=720
rot=180
key=$1

if [ -z "$1" ]
  then
    echo "Usage: first argument must be the key"
    echo "found in your Youtube Classic Studio"
   exit 0
fi

cancelled(){
  if [ -e $apipe ];
    then
      echo "Removing audiopipe..."
      rm $apipe
  fi
  if [ -e $vpipe ];
    then
      echo "Removing videopipe..."
      rm $vpipe
  fi
  echo "\nBye!"
}

trap cancelled EXIT


if [[ ! -p $vpipe ]]; then
    mkfifo $vpipe
fi

if [[ ! -p $apipe ]]; then
    mkfifo $apipe
fi

raspivid -t 0 -w $vw -h $vh -fps $fps -rot $rot -o - > $vpipe &

arecord -D plughw:1,0 -r 44100 -c 4 > $apipe &

ffmpeg \
    -y \
    -r $fps \
    -fflags nobuffer \
    -thread_queue_size 10240 \
    -i $vpipe \
    -fflags nobuffer \
    -analyzeduration 0 \
    -thread_queue_size 10240 \
    -r $fps \
    -i $apipe \
    -map 0:0 \
    -map 1:0 \
    -filter:a aresample=async=1 \
    -c:a aac \
    -c:v copy \
    -f flv rtmp://a.rtmp.youtube.com/live2/$key 
