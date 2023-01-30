#!/bin/bash
for i in $(seq 1 20)
do
  port_state=$(vncconfig -display :$i -get SendCutText 2> /dev/null)
  if [ "$port_state"x == "1"x ]; then
    echo 'port:' $i 'SendCutText=' $port_state '-> 0'
    vncconfig -display :$i -set SendCutText=0
  fi
done
