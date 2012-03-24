#! /bin/sh
if [ -n "$(php public_html/hacku.php)" ] ; then
 notify-send -t 5000000 -i /home/aditya/sadd.jpg "Moodle Notification" "$(echo "$(php public_html/hacku.php)")"
 echo "\a"
fi



