#!/bin/bash

########################################
#	GENERATE VARIABLES FROM        #
#	  AVAILABLE LOG FILES	       #
########################################
#
# ls /var/log/*.log
#   \__put all it finds into a list
#      \__put each item in list into individual vars
#
# echo all vars created
#  \__check logs for particulars
#
# generate reports
#
###
###################################
# COLOR FORMATTING
BLK=$(tput setaf 0)
RED=$(tput setaf 1)
GRN=$(tput setaf 2)
YLW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MGTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
NC=$(tput sgr0)
BLINK=$(tput blink)
HIGHLIGHT=$(tput smso)
UNDERLINE=$(tput smul)
RED1='\033[01;31m'
GRN1='\033[01;32m'
YLW1='\033[01;33m'
BLUE1='\033[01;34m'
nc='\033[0m'
######################################

PS3="[LOGVIEWER]> Log select:"
loglist="loglist.l"
nine="$9"
#################################################
a=($(ls -la /var/log/*.log | awk '{print $9}'))
b=($(ls -la /var/log/*.log.1 | awk '{print $9}'))
#################################################
#THIS GENERATES newlog#=/dir/to/logs.log
#################################################
#while (( n <= num )); do
#	for each in ${a[*]}; do
#	num=${#a[*]}
#	((++n))
#	printf "$each $n \n"
#	newlog=newlog$n
#	printf "$newlog \n\n"
#	newlog+="=$each"
#	printf "$newlog \n"
#	lsvars+=("$newlog")
#	done
#	echo $each
#done
#################################################

#################################################
for each in ${a[@]}; do
        lsvars+=("$each")
done
for each in ${b[@]}; do
	lsvars+=("$each")
done
################################################


if [ -f $loglist ]; then
printf "\t->Updating loglist..\n"
	for each in ${lsvars[*]}; do
		echo $each >> $loglist
#		export $each
	done
else
	echo "X]No varlist file."
	read -p "Do you want to create it?(y/n)" answer
		if [ "$answer" == "y" ]; then
			for each in ${lsvars[*]}; do
				echo $each >> $loglist
#				export $each
			done
		fi
fi
###########################
### ANNOUNCE VAR AMOUNT
##########################
printf """
        THERE ARE ${#lsvars[*]} IN THE LOGS LIST
"""
##############################
# ASSIGN VARS AND USE THEM
###############################

#for all in ${lsvars[*]}; do
#	printf "\n[\t $all \t]\n"
#done

menuselect() {

select sel in ${lsvars[@]}; do
	num+=$sel
	if [[ $sel == $# ]] || [[ $sel > ${#loglist[@]} ]]; then
	echo "$sel"
	echo "Word count in log: " $(cat $sel | wc -l)
	echo
	#cat grep typicals
	cat $sel | awk -v b=$BLUE1 -v r=$RED1 -v y=$YLW1 -v g=$GRN1 -v c=$CYAN -v n=$nc '{print $1$2,$3,y"["n c$5 y"]"n">>",$4,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21}'
########THIS BELOW CAN ONLY BE USED FOR ufw.log & kern.log --complete
	if [ $(echo $sel | grep "kern") ] || [ $(echo $sel | grep "ufw") ]; then
	cat $sel | awk -v b=$BLUE1 -v r=$RED1 -v y=$YLW1 -v g=$GRN1 -v c=$CYAN -v n=$nc '{print y$1$2,$3n,$4,"[",c $12 n,"]","[",r $13 n,"]",$14,$15 }'
	fi
################
	if [ $(echo $sel | grep "auth") ]; then
		sublist=(CRON SysD-LoginD SUDOers SSHD VNC)
		select sub in ${sublist[@]}; do
		if [[ $sub > ${#sublist[@]} ]]; then
			if [ $sub == "CRON" ]; then
				c=$(cat $sel | grep "CRON")
				echo $c > $?
				x=$?
				if [[ $x != $# ]]; then
				echo "No CRON services detected"
				fi
				#cat grep CRON -complete
				cat $sel | grep "CRON" | awk -v b=$BLUE1 -v r=$RED1 -v y=$YLW1 -v g=$GRN1 -v c=$CYAN -v n=$nc '{print $1$2,$3,y"["n c$5 y"]"n">>",$4,$6,$7,$8,$9,$10,$11,$12,$13}'
			elif [ $sub == "SysD-LoginD" ]; then
				s=$(cat $sel | grep "systemd-logind")
				echo $s > $?
				x=$?
				if [[ $x != $# ]]; then
				echo "No systemd-logind detected"
				fi
				#cat grep systemd -complete?
				cat $sel | grep "systemd-logind" | awk -v b=$BLUE1 -v r=$RED1 -v y=$YLW1 -v g=$GRN1 -v c=$CYAN -v n=$nc '{print $1$2,$3,y"["n c$5 y"]"n">>",$4,$6,$7,$8,$9,$10,$11,$12,$13}'
			elif [ $sub == "SUDOers" ]; then
				s=$(cat $sel | grep "sudo")
				echo $s > $?
				x=$?
				if [[ $x != $# ]]; then
				echo "No sudoers detected"
				fi
				#cat grep sudoers -complete?
				cat $sel | grep "sudo" | awk -v b=$BLUE1 -v r=$RED1 -v y=$YLW1 -v g=$GRN1 -v c=$CYAN -v n=$nc '{print $1$2,$3,y"["n c$5 y"]"n">>",$4,$6,$7,$8,$9,$10,$11,$12,$13}'
			elif [ $sub == "SSHD" ]; then
				s=$(cat $sel | grep "sshd")
				echo $s > $?
				x=$?
				if [[ $x != $# ]]; then
				echo "No SSH detected"
				fi
				#cat grep ssh -complete?
				cat $sel | grep "ssh" | awk -v b=$BLUE1 -v r=$RED1 -v y=$YLW1 -v g=$GRN1 -v c=$CYAN -v n=$nc '{print $1$2,$3,y"["n c$5 y"]"n">>",$4,$6,$7,$8,$9,$10,$11,$12,$13}'
#			elif [ $sub == "VNC" ]; then
#				x=$(cat $sel | grep "vnc")
#				if [[ $x != $# ]]; then
#				echo "No VNC detected"
#				fi
#				#cat grep vnc -complete?
#				cat $sel | grep "vnc" | awk -v b=$BLUE1 -v r=$RED1 -v y=$YLW1 -v g=$GRN1 -v c=$CYAN -v n=$nc '{print $1$2,$3,y"["n c$5 y"]"n">>",$4,$6,$7,$8,$9,$10,$11,$12,$13}'
			fi

		else
			break
		fi
		done

#        cat $sel | awk -v b=$BLUE1 -v r=$RED1 -v y=$YLW1 -v g=$GRN1 -v c=$CYAN -v n=$nc '{print y$1$2,$3n,$4,"[",c $12 n,"]"}'
        else
        echo 
	fi


	else
	echo "Quit"
	break
	fi
done

}

#awk '{print $1 $2 $3 $4 $5 $6 $7 $8 $9}'
menuselect

echo
