#!/bin/bash

#find all sh files in home DIR
#
for each in $(ls -laR /home/); do
	#Check file extensions
	ext="${each##*\.}" #set to search through ALL

	###CASE SET ONLY TO SHOW .sh FILES
	case "$ext" in
	txt) echo [ SHELL SCRIPT ] "$each##\.";;
	*) ;;
	esac
done
