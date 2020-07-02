#!/bin/bash
apt-get autoremove --purge apache* -y
apt-get autoremove --purge mysql* -y
apt-get update
apt-get install nano screen -y
wget --no-check-certificate -O autodl-setup http://sourceforge.net/projects/autodl-irssi/files/autodl-setup/download
sh autodl-setup
sed -e '7s/30/5/g' /var/rutorrent/rutorrent/plugins/rss/conf.php