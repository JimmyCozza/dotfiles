#!/bin/bash

# Simple script to handle a DIY shutdown menu. When run you should see a bunch of options (shutdown, reboot etc.)
#
# Requirements:
# - rofi
# - systemd, but you can replace the commands for OpenRC or anything else
#
# Instructions:
# - Save this file as power.sh or anything
# - Give it exec priviledge, or chmod +x /path/to/power.sh
# - Run it

chosen=$(echo -e "[Cancel]\nLogout\nShutdown\nReboot\nSuspend\nHibernate\nHybrid-sleep\nSuspend-then-hibernate" | rofi -dmenu -i)
# Info about some states are available here:
# https://www.freedesktop.org/software/systemd/man/systemd-sleep.conf.html#Description

if [[ $chosen = "Logout" ]]; then
	xfce4-session-logout --logout
elif [[ $chosen = "Shutdown" ]]; then
	systemctl poweroff
elif [[ $chosen = "Reboot" ]]; then
	xfce4-session-logout --reboot
elif [[ $chosen = "Suspend" ]]; then
	xfce4-session-logout --suspend
elif [[ $chosen = "Hibernate" ]]; then
	xfce4-session-logout --hibernate
elif [[ $chosen = "Hybrid-sleep" ]]; then
	xfce4-session-logout --hybrid-sleep
elif [[ $chosen = "Suspend-then-hibernate" ]]; then
	systemctl suspend-then-hibernate
fi
