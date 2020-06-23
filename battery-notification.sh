#!/usr/bin/env bash

##########
## Name: battery-notification.sh
## Author: Nicholas Neal (nwneal@kisoki.com)
## Description: 
## 			This is a small script that will install itself to cron
##			and run every minute, check your battery level, and send an alert to your desktop if over 80% or below 40%.
##
## Dependencies: acpi, send-notify
## 
## Tested on Ubuntu Desktop 16.04.2 LTS and Ubuntu Desktop 18.04.4 LTS
##########

eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)";

# check if acpi and send-notify are installed.
if [ `dpkg -l | grep acpi | grep -v acpi-support | grep -v acpid | grep -c acpi` -ne 1 ]; then
	echo "run 'sudo apt install acpi' then run '$0' again."
	exit
fi

if [ $# -eq 1 ] && [ "$1" == "--install" ]; then
	echo "installing battery notifier..."
	
	if [ ! -e "$HOME/bin" ]; then
		mkdir $HOME/bin
	fi	
	
	cp $0 $HOME/bin/bn.sh
	(crontab -l 2>/dev/null; echo "*/2 * * * * $HOME/bin/bn.sh") | crontab -

else
	# check battery status.
	batlvl=`acpi -b | grep -P -o '[0-9]+(?=%)'`

	# if adapter is not plugged in, give warnings below 40% battery
	if [ -z "`acpi -a | grep on-line`" ]; then
		
    if [ $batlvl -le 40 ] && [ $batlvl -ge 21 ]; then
			notify-send "Battery is at $batlvl%. Plug your computer in to preserve battery life."
		elif [ $batlvl -le 20 ]; then
			notify-send "Battery critically low! Plug your computer in now to preserve battery life "
		fi
	
  # else if adapter is plugged in, give warning above 80% battery 
	elif [ -z "`acpi -a | grep off-line`" ]; then
		
    if [ $batlvl -le 100 ] && [ $batlvl -ge 81 ]; then
			notify-send "Battery is at $batlvl%. Unplug your computer to preserve battery life."
		fi
	fi	
fi
