#!/bin/bash

############################################################################
# Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
# Alpha Release
#
#	Version: 0.2.1
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
echo $'\n''Push State to Dev / Stage / Live (dev/stage/live)?'$'\n'
#
read TARGET

if [ "$TARGET" = dev ] || [ "$TARGET" = Dev ] || [ "$TARGET" = DEV ]
then
###
	#
	echo $'\n''Propagate Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pushing Assets to Dev now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/* $dev_ssh_user@$dev_ssh_host:$dev_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Dev now...'$'\n'
		mysqldump --defaults-extra-file=~/apparatus/apparatus.my.cnf $local_db_name > $my_webroot/$local_rel_assets_path/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/dbsync.sql $dev_ssh_user@$dev_ssh_host:$dev_assets_path/dbsync.sql && \

		ssh $dev_ssh_user@$dev_ssh_host "mysql --defaults-extra-file=/home/$dev_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$dev_db_name -h $dev_db_host $dev_db_name < $dev_assets_path/dbsync.sql" && \

		ssh $dev_ssh_user@$dev_ssh_host "cd $dev_path && wp search-replace '$local_domain' '$dev_domain'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Dev now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/* $dev_ssh_user@$dev_ssh_host:$dev_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to Dev now...'$'\n'
		mysqldump --defaults-extra-file=~/apparatus/apparatus.my.cnf --defaults-group-suffix=$dev_db_name $local_db_name > $my_webroot/$local_rel_assets_path/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/dbsync.sql $dev_ssh_user@$dev_ssh_host:$dev_assets_path/dbsync.sql && \

		ssh $dev_ssh_user@$dev_ssh_host "mysql --defaults-extra-file=/home/$dev_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$dev_db_name -h $dev_db_host $dev_db_name < $dev_assets_path/dbsync.sql" && \
		
		ssh -t $dev_ssh_user@$dev_ssh_host "cd $dev_path && wp search-replace '$local_domain' '$dev_domain'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi
fi
##
if [ "$TARGET" = stage ] || [ "$TARGET" = Stage ] || [ "$TARGET" = STAGE ]
then
###
	#
	echo $'\n''Propagate Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pushing Assets to Stage now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/* $stage_ssh_user@$stage_ssh_host:$stage_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Stage now...'$'\n'
		mysqldump --defaults-extra-file=~/apparatus/apparatus.my.cnf $local_db_name > $my_webroot/$local_rel_assets_path/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/dbsync.sql $stage_ssh_user@$stage_ssh_host:$stage_assets_path/dbsync.sql && \

		ssh $stage_ssh_user@$stage_ssh_host "mysql --defaults-extra-file=/home/$stage_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$stage_db_name -h $stage_db_host $stage_db_name < $stage_assets_path/dbsync.sql"
		
		ssh $stage_ssh_user@$stage_ssh_host "cd $stage_path && wp search-replace '$local_domain' '$stage_domain'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Stage now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/* $stage_ssh_user@$stage_ssh_host:$stage_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to Stage now...'$'\n'
		mysqldump --defaults-extra-file=~/apparatus/apparatus.my.cnf --defaults-group-suffix=$stage_db_name $local_db_name > $my_webroot/$local_rel_assets_path/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/dbsync.sql $stage_ssh_user@$stage_ssh_host:$stage_assets_path/dbsync.sql && \

		ssh $stage_ssh_user@$stage_ssh_host "mysql --defaults-extra-file=/home/$stage_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$stage_db_name -h $stage_db_host $stage_db_name < $stage_assets_path/dbsync.sql"
		
		ssh $stage_ssh_user@$stage_ssh_host "cd $stage_path && wp search-replace '$local_domain' '$stage_domain'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi
fi
##
if [ "$TARGET" = live ] || [ "$TARGET" = Live ] || [ "$TARGET" = LIVE ]
then
###
	#
	echo $'\n''Propagate Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE
	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pushing Assets to Live now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/* $live_ssh_user@$live_ssh_host:$live_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Live now...'$'\n'
		mysqldump --defaults-extra-file=~/apparatus/apparatus.my.cnf $local_db_name > $my_webroot/$local_rel_assets_path/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/dbsync.sql $live_ssh_user@$live_ssh_host:$live_assets_path/dbsync.sql && \

		ssh $live_ssh_user@$live_ssh_host "mysql --defaults-extra-file=/home/$live_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$live_db_name -h $live_db_host $live_db_name < $live_assets_path/dbsync.sql"
		
		ssh $live_ssh_user@$live_ssh_host "cd $live_path && wp search-replace '$local_domain' '$live_domain'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Live now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/* $live_ssh_user@$live_ssh_host:$live_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to live now...'$'\n'
		mysqldump --defaults-extra-file=~/apparatus/apparatus.my.cnf --defaults-group-suffix=$live_db_name $local_db_name > $my_webroot/$local_rel_assets_path/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $my_webroot/$local_rel_assets_path/dbsync.sql $live_ssh_user@$live_ssh_host:$live_assets_path/dbsync.sql && \

		ssh $live_ssh_user@$live_ssh_host "mysql --defaults-extra-file=/home/$live_ssh_user/apparatus/apparatus.my.cnf --defaults-group-suffix=$live_db_name -h $live_db_host $live_db_name < $live_assets_path/dbsync.sql"
		
		ssh $live_ssh_user@$live_ssh_host "cd $live_path && wp search-replace '$local_domain' '$live_domain'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi
fi
