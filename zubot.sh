#!/usr/bin/env bash

started=""
times=1
botfile=botttttt

if [ -f config ]; then
  source config
else
  echo "need config file: config"
  exit 1
fi

echo server: $server
echo channel: $channel
rm $botfile
mkfifo $botfile
tail -f $botfile | openssl s_client -connect $server:6697 | while true ; do
    if [ -z $started ] ; then
        echo "USER zubot 9 zubot zubot :" > $botfile
        echo "NICK zubot" > $botfile
        echo "JOIN $channel" > $botfile
        started="yes"
    fi
    read irc
    case `echo $irc | cut -d " " -f 1` in
         "PING") echo "PONG `hostname`" > $botfile
            ;;
    esac

    chan=`echo $irc | cut -d ' ' -f 3`
    barf=`echo $irc | cut -d ' ' -f 1-3`
    cmd=`echo ${irc##$barf :}|cut -d ' ' -f 1|tr -d "\r\n"`
    args=`echo ${irc##$barf :$cmd}|tr -d "\r\n"`
    nick="${irc%%!*}";nick="${nick#:}"
    if [ "`echo $cmd | cut -c1`" == "/" ] ; then
    echo "Got command $cmd from channel $chan with arguments $args"
    fi

case $cmd in
        "!help") echo "PRIVMSG $chan :!status !uptime !source !help" >> $botfile ;;
        "!source") echo "PRIVMSG $chan :https://github.com/nibalizer/zubot" >> $botfile ;;
        "!number") 
          data=$(python python by_number.py $args)
          echo "PRIVMSG $chan :$data" >> $botfile 
          ;;
        "!uptime") 
          percent=$(python uptime_percent.py)
          echo "PRIVMSG $chan :Pokemon server uptime percent over 4 hours is $percent" >> $botfile 
          ;;
        "!status") 
          status=$(python status.py)
          echo "PRIVMSG $chan :Pokemon server status is $status" >> $botfile 
          ;;
    esac
    echo $irc
done
