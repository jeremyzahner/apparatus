#!/bin/bash

############################################################################
# Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
# Alpha Release
#
#	Version: 0.1.1
############################################################################

## CONFIGURATION
source $PWD/devconfig.txt

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
	echo $'\n''Propagate Assets / Database / Assets & Database (a/d/ad)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pushing Assets to Dev now...'$'\n'
		sshpass -p$dev_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/* $dev_ssh_user@$dev_ssh_host:$dev_assets_path && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Dev now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > $local_assets_path/dbsync.sql && \

		sshpass -p$dev_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/dbsync.sql $dev_ssh_user@$dev_ssh_host:$dev_assets_path/dbsync.sql && \

		sshpass -p$dev_ssh_pw ssh $dev_ssh_user@$dev_ssh_host "mysql -u $dev_db_user -p$dev_db_pw -h $dev_db_host $dev_db_name < $dev_assets_path/dbsync.sql"
		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Dev now...'$'\n'
		sshpass -p$dev_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/* $dev_ssh_user@$dev_ssh_host:$dev_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to Dev now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > $local_assets_path/dbsync.sql && \

		sshpass -p$dev_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/dbsync.sql $dev_ssh_user@$dev_ssh_host:$dev_assets_path/dbsync.sql && \

		sshpass -p$dev_ssh_pw ssh $dev_ssh_user@$dev_ssh_host "mysql -u $dev_db_user -p$dev_db_pw -h $dev_db_host $dev_db_name < $dev_assets_path/dbsync.sql"
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
		sshpass -p$stage_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/* $stage_ssh_user@$stage_ssh_host:$stage_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Stage now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > $local_assets_path/dbsync.sql && \

		sshpass -p$stage_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/dbsync.sql $stage_ssh_user@$stage_ssh_host:$stage_assets_path/dbsync.sql && \

		sshpass -p$stage_ssh_pw ssh $stage_ssh_user@$stage_ssh_host "mysql -u $stage_db_user -p$stage_db_pw -h $stage_db_host $stage_db_name < $stage_assets_path/dbsync.sql"
		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Stage now...'$'\n'
		sshpass -p$stage_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/* $stage_ssh_user@$stage_ssh_host:$stage_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to Stage now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > $local_assets_path/dbsync.sql && \

		sshpass -p$stage_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/dbsync.sql $stage_ssh_user@$stage_ssh_host:$stage_assets_path/dbsync.sql && \

		sshpass -p$stage_ssh_pw ssh $stage_ssh_user@$stage_ssh_host "mysql -u $stage_db_user -p$stage_db_pw -h $stage_db_host $stage_db_name < $stage_assets_path/dbsync.sql"
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
		sshpass -p$live_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/* $live_ssh_user@$live_ssh_host:$live_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Live now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > $local_assets_path/dbsync.sql && \

		sshpass -p$live_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/dbsync.sql $live_ssh_user@$live_ssh_host:$live_assets_path/dbsync.sql && \

		sshpass -p$live_ssh_pw ssh $live_ssh_user@$live_ssh_host "mysql -u $live_db_user -p$live_db_pw -h $live_db_host $live_db_name < $live_assets_path/dbsync.sql"
		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Live now...'$'\n'
		sshpass -p$live_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/* $live_ssh_user@$live_ssh_host:$live_assets_path/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to Live now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > $local_assets_path/dbsync.sql && \

		sshpass -p$live_ssh_pw rsync -r -v --progress --update -e "ssh" $local_assets_path/dbsync.sql $live_ssh_user@$live_ssh_host:$live_assets_path/dbsync.sql && \

		sshpass -p$live_ssh_pw ssh $live_ssh_user@$live_ssh_host "mysql -u $live_db_user -p$live_db_pw -h $live_db_host $live_db_name < $live_assets_path/dbsync.sql"
		echo $'\n''DB fully synced!'$'\n'
		##
	fi
fi
