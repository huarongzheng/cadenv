#!/usr/bin/expect -f

#autossh.sh oxterm-81 username new4rit
if { $argc < 3 } {
puts stderr "Usage: $argv0 IPAdress Login OldPasswd"
exit
}

set IPADDR [lindex $argv 0]
set LOGIN [lindex $argv 1]
set OLD_PW [lindex $argv 2]

set timeout 30

stty -echo

spawn ssh $IPADDR -l $LOGIN
expect {
    "*assword:*"  {
        send "$OLD_PW\r"
        exp_continue
    } "*Last login:*" {
        interact
        exit 0
    } timeout {
        send_user "connection to $IPADDR timeout!\n"
        exit 1
    } "*incorrect*" {
        send_user "password incorrect!\n"
        exit 2
    } "*Permission*" {  #for LINUX ssh
        send_user "password Error!\n"
        exit 2
    } eof {
        exit 3
    }
}
