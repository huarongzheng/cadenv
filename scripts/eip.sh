#!/bin/bash

if [ "$1" == "" ]; then
  ip_name="caffe"
else
  ip_name=$1
fi

#echo $ip_name
export ROT=/proot

if [ "$ip_name" == "caffe" ]; then
    export WORKAREA=$ROT/$ip_name
    export CMOD_TOP=$WORKAREA
    #echo $WORKAREA
fi

cd $WORKAREA

