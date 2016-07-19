Zubot
-----

This bot runs the 'zubot' user in irc

It pulls uptime data from datadog: https://p.datadoghq.com/sb/1xfifX-a17f211ecb

You can extend it to have more uptime data, or more features. Make a pull request!


Usage
-----


Create a config file:


```
export channel=#mypokemonchannel
export server=myircserver.net
```


Run the bot(probably in screen):

```
./zubot.sh
```
