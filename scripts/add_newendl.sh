#!/bin/sh 
for i in $*
do 
  if diff /dev/null "$i" | tail -1 | grep '^\\ No newline' > /dev/null; then  
    echo >> "$i" 
  fi 
done
