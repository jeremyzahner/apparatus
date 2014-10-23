#!/bin/bash

############################################################################
# Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
# Alpha Release
#
#	Version: 0.2.0
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
echo $'\n''Pull State from Dev / Stage / Live (dev/stage/live)?'$'\n'
#
read TARGET

if [ "$TARGET" = dev ] || [ "$TARGET" = Dev ] || [ "$TARGET" = DEV ]
then
###
	#
	echo $'\n''Pull Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pulling Assets from Dev now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $dev_ssh_user@$dev_ssh_host:$dev_assets_path/*  $my_webroot/$local_rel_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pulling DB from Dev now...'$'\n'

		ssh $dev_ssh_user@$dev_ssh_host "mysqldump --defaults-extra-file=/home/$dev_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$dev_db_name -h $dev_db_host $dev_db_name > $dev_assets_path/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $dev_ssh_user@$dev_ssh_host:$dev_assets_path/dbsync.sql $my_webroot/$local_rel_assets_path/dbsync.sql && \

		mysql --defaults-extra-file=~/apparatus/apparatus.my.cnf -h $my_db_host $local_db_name < $my_webroot/$local_rel_assets_path/dbsync.sql && \

		cd $my_webroot/$local_rel_path/ && wp search-replace $dev_domain $local_domain

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pulling Assets from Dev now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $dev_ssh_user@$dev_ssh_host:$dev_assets_path/*  $my_webroot/$local_rel_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pulling DB from Dev now...'$'\n'

		ssh $dev_ssh_user@$dev_ssh_host "mysqldump --defaults-extra-file=/home/$dev_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$dev_db_name -h $dev_db_host $dev_db_name > $dev_assets_path/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $dev_ssh_user@$dev_ssh_host:$dev_assets_path/dbsync.sql $my_webroot/$local_rel_assets_path/dbsync.sql && \

		mysql --defaults-extra-file=~/apparatus/apparatus.my.cnf -h $my_db_host $local_db_name < $my_webroot/$local_rel_assets_path/dbsync.sql && \

		cd $my_webroot/$local_rel_path/ && wp search-replace $dev_domain $local_domain

		echo $'\n''DB fully synced!'$'\n'
		##
	fi
fi
##
if [ "$TARGET" = stage ] || [ "$TARGET" = Stage ] || [ "$TARGET" = STAGE ]
then
###
	#
	echo $'\n''Pull Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pulling Assets from Stage now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $stage_ssh_user@$stage_ssh_host:$stage_assets_path/* $my_webroot/$local_rel_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pulling DB from Stage now...'$'\n'

		ssh $stage_ssh_user@$stage_ssh_host "mysqldump --defaults-extra-file=/home/$stage_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$stage_db_name -h $stage_db_host $stage_db_name > $stage_assets_path/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $stage_ssh_user@$stage_ssh_host:$stage_assets_path/dbsync.sql $my_webroot/$local_rel_assets_path/dbsync.sql && \

		mysql --defaults-extra-file=~/apparatus/apparatus.my.cnf -h $my_db_host $local_db_name < $my_webroot/$local_rel_assets_path/dbsync.sql && \

		cd $my_webroot/$local_rel_path/ && wp search-replace $stage_domain $local_domain

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pulling Assets from Stage now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $stage_ssh_user@$stage_ssh_host:$stage_assets_path/* $my_webroot/$local_rel_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pulling DB from Stage now...'$'\n'

		ssh $stage_ssh_user@$stage_ssh_host "mysqldump --defaults-extra-file=/home/$stage_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$stage_db_name -h $stage_db_host $stage_db_name > $stage_assets_path/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $stage_ssh_user@$stage_ssh_host:$stage_assets_path/dbsync.sql $my_webroot/$local_rel_assets_path/dbsync.sql && \

		mysql --defaults-extra-file=~/apparatus/apparatus.my.cnf -h $my_db_host $local_db_name < $my_webroot/$local_rel_assets_path/dbsync.sql && \

		cd $my_webroot/$local_rel_path/ && wp search-replace $stage_domain $local_domain

		echo $'\n''DB fully synced!'$'\n'
		##
	fi
fi
##
if [ "$TARGET" = live ] || [ "$TARGET" = Live ] || [ "$TARGET" = LIVE ]
then
###
	#
	echo $'\n''Pull Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE
	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pulling Assets from Live now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $live_ssh_user@$live_ssh_host:$live_assets_path/* $my_webroot/$local_rel_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pulling DB from Live now...'$'\n'

		ssh $live_ssh_user@$live_ssh_host "mysqldump --defaults-extra-file=/home/$live_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$live_db_name -h $live_db_host $live_db_name > $live_assets_path/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $live_ssh_user@$live_ssh_host:$live_assets_path/dbsync.sql $my_webroot/$local_rel_assets_path/dbsync.sql && \

		mysql --defaults-extra-file=~/apparatus/apparatus.my.cnf -h $my_db_host $local_db_name < $my_webroot/$local_rel_assets_path/dbsync.sql && \

		cd $my_webroot/$local_rel_path/ && wp search-replace $live_domain $local_domain

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pulling Assets from Live now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $live_ssh_user@$live_ssh_host:$live_assets_path/* $my_webroot/$local_rel_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pulling DB from Live now...'$'\n'

		ssh $live_ssh_user@$live_ssh_host "mysqldump --defaults-extra-file=/home/$live_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$live_db_name -h $live_db_host $live_db_name > $live_assets_path/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $live_ssh_user@$live_ssh_host:$live_assets_path/dbsync.sql $my_webroot/$local_rel_assets_path/dbsync.sql && \

		mysql --defaults-extra-file=~/apparatus/apparatus.my.cnf -h $my_db_host $local_db_name < $my_webroot/$local_rel_assets_path/dbsync.sql && \

		cd $my_webroot/$local_rel_path/ && wp search-replace $live_domain $local_domain

		echo $'\n''DB fully synced!'$'\n'
		##
	fi
fi
