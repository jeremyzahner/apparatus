#!/bin/bash

############################################################################
# Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
# Alpha Release
#
#	Version: 0.1.0
############################################################################

## CONFIGURATION
source $PWD/apparatus.conf
source ~/apparatus/my_apparatus.conf

if [ ! -f $PWD/apparatus.conf ]
then
	echo $'\n''Cant find your current projects apparatus.conf. Check wether you are in your projects root and the apparatus.conf file exists.'
	#
	exit
fi

if [ ! -f ~/apparatus/my_apparatus.conf ]
then
	echo $'\n''Cant find your global my_apparatus.conf. Check wether your my_apparatus.conf file exists in your home directory in the apparatus directory.'
	#
	exit
fi

#
echo $'\n''Script starting...'
#
echo $'\n''Take Composer action to Dev / Stage / Live (dev/stage/live)?'$'\n'
#
read TARGET

if [ "$TARGET" = dev ] || [ "$TARGET" = Dev ] || [ "$TARGET" = DEV ]
then
###

	ssh -t $dev_ssh_user@$dev_ssh_host "cd $dev_path && composer update"

	echo $'\n''DB fully synced!'$'\n'

###
fi
##
if [ "$TARGET" = stage ] || [ "$TARGET" = Stage ] || [ "$TARGET" = STAGE ]
then
###

	ssh -t $stage_ssh_user@$stage_ssh_host "cd $stage_path && composer update"

	echo $'\n''DB fully synced!'$'\n'

###
fi
##
if [ "$TARGET" = live ] || [ "$TARGET" = Live ] || [ "$TARGET" = LIVE ]
then
###

	ssh -t $live_ssh_user@$live_ssh_host "cd $live_path && composer update"

	echo $'\n''DB fully synced!'$'\n'

###
fi
