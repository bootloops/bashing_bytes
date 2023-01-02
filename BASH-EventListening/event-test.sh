#!/bin/bash

# attempt at event listening

exit=Q
space=$'\x20'
movement=( w s a d e q ) 
character="[o_o]"
x_pos=0
y_pos=0

function forward() {
	character+='.'
	echo -n "forward"
	
}
function backward() {
	echo -n "backward"
	character+=$space
}
function move_left() {
	echo -n "left"
}
function move_right() {
	echo -n "right"
}
function jump() {
	echo -n "jumping"
}
function use() {
	echo -n "use-item"
}
function change_item() {
	echo -n "change_item"
}
function quit() {
	echo -n "Quitting, see ya later."
	exit 0
}

clear
echo """
		Movement:
			forward: w, backward: s
			left: a, right: d, jump: space
			use-item: e, change-item: q

		Exit:
			F2 
			Capslock, then Q
			Shift+Q
"""

# MUST SET IFS='' FOR SPACEBAR EVENT TO BE CAUGHT -- causing issues elsewhere
IFS='' 

while true; do
	read -rsn1 input
	for key in ${movement[@]}; do
	if [[ ${input} == ${key} ]]; then
		case ${input} in
			${movement[0]}) forward;;
			${movement[1]}) backward;;
			${movement[2]}) move_left;;
			${movement[3]}) move_right;;
			${movement[4]}) use;;
			${movement[5]}) change_item;;
			*) echo;;
		esac
	fi

	done

	#LISTEN FOR SPACEBAR EVENT
	[[ $input == $'\x20' ]] && jump;


	#LISTEN FOR EXIT 
	if [[ $input == $exit ]]; then
		quit
	else 
		echo ''
	fi
done