#!/bin/bash

LAST_INDEX=$1
if [ -z "$LAST_INDEX" ]; then
  LAST_INDEX=9
fi

FILE_NAME="inputFile"
if [ -f "$FILE_NAME" ]; then
  rm "inputFile"
fi

RANDOM=$$
for i in $( seq 0 $LAST_INDEX)
do
  echo "$i,$RANDOM" >> "$FILE_NAME"
done
