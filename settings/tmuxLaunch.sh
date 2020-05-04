#!/bin/zsh
cmd=$(which tmux) # tmux path

sessions=(wa1 wa2 wa3 wa4) # sessions name

if [ -z $cmd ]; then
    echo "You need to install tmux."
    exit 1
fi

createSession ()
{
    if [ "$#" -ne 1 ]; then
        echo "Illegal number of parameters, needs 1 parameters"
        exit 1
    fi

    session=$1
    $cmd has -t $session
    
    if [ $? != 0 ]; then
        $cmd new -d -n src -s $session
        $cmd neww -n src -t $session
        $cmd neww -n src -t $session
        $cmd neww -n run -t $session
        #$cmd splitw -v -p 20 -t $session "pry"
    fi
}

for (( i = 1 ; i <= ${#sessions[@]} ; i++ ));
do
  echo "parameters" $i ${sessions[$i]}
  createSession ${sessions[$i]}
done

echo ${sessions[1]}
$cmd att -t ${sessions[1]}

