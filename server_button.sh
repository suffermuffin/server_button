#!/bin/bash

SB_ICON_PATH="/home/cass/Pictures/applications-science-symbolic.svg"

status_dlna=$(systemctl status minidlna | grep 'Active:' | awk '{print $2}')
status_smbd=$(systemctl status smbd | grep 'Active:' | awk '{print $2}')
ans=None

if [[ $status_dlna == "active" ]]; then
	
	ans=$(notify-send -a "Server Button" \
	-i $SB_ICON_PATH \
	-t 2000 "Mini DLNA is ACTIVE" "Deactivate?" \
	-A "Deactivate" \
	-A "Leave Running")
	
	if [[ $ans == 0 ]]; then
		systemctl stop minidlna
	fi
	
elif [[ $status_dlna == "inactive" ]]; then
	
	ans=$(notify-send -a "Server Button" \
	-i $SB_ICON_PATH  \
	-t 2000 "Mini DLNA is NOT ACTIVE" "Activate?" \
	-A "Activate" \
	-A "Leave Inactive")
	
	if [[ $ans == 0 ]]; then
		systemctl start minidlna
	fi
else
	notify-send -a "Server Button" -i $SB_ICON_PATH  -t 2000 "status_dlna unreachabla"
	exit 1
fi

ans=None

if [[ $status_smbd == "active" ]]; then
	
	ans=$(notify-send -a "Server Button" \
	-i $SB_ICON_PATH \
	-t 2000 "SAMBA is ACTIVE" "Deactivate?" \
	-A "Deactivate" \
	-A "Leave Running")
	
	if [[ $ans == 0 ]]; then
		systemctl stop smbd
	fi
	
elif [[ $status_smbd == "inactive" ]]; then

	ans=$(notify-send -a "Server Button" \
	-i $SB_ICON_PATH  \
	-t 2000 "SAMBA is NOT ACTIVE" "Activate?" \
	-A "Activate" \
	-A "Leave Inactive")
	
	if [[ $ans == 0 ]]; then
		systemctl start smbd
	fi
	
else
	notify-send -a "Server Button" -i $SB_ICON_PATH  -t 2000 "status_smbd unreachabla"
	exit 1
fi

sleep 1

status_dlna=$(systemctl status minidlna | grep 'Active:' | awk '{print $2}')
status_smbd=$(systemctl status smbd | grep 'Active:' | awk '{print $2}')

notify-send -a "Server Button" -i $SB_ICON_PATH  "New Status:" "DLNA is $status_dlna | SAMBA is $status_smbd"
