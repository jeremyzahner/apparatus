#!/bin/bash

############################################################################
# Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
# First Release
#
#	Version: 1.1.0
############################################################################

## CONFIGURATION
source $PWD/devconfig.txt

#
echo $'\n''Script starting...'
#
echo $'\n''Push State to Dev / Stage (dev/stage)?'$'\n'
#
read TARGET

if [ "$TARGET" = dev ]
then
###
	#
	echo $'\n''Propagate Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pushing Assets to Dev now...'$'\n'
		sshpass -p$dev_ssh_pw rsync -r -v --progress --update -e "ssh" $local_path/assets/ $dev_ssh_user@$dev_ssh_host:$dev_path/assets/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Dev now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$dev_ssh_pw rsync -r -v --progress --update -e "ssh" $local_path/wp-content/dbsync.sql $dev_ssh_user@$dev_ssh_host:$dev_path/wp-content/dbsync.sql && \

		sshpass -p$dev_ssh_pw ssh $dev_ssh_user@$dev_ssh_host "mysql -u $dev_db_user -p$dev_db_pw -h $dev_db_host $dev_db_name < $dev_path/wp-content/dbsync.sql"
		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Dev now...'$'\n'
		sshpass -p$dev_ssh_pw rsync -r -v --progress --update -e "ssh" $local_path/assets/ $dev_ssh_user@$dev_ssh_host:$dev_path/assets/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to Dev now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$dev_ssh_pw rsync -r -v --progress --update -e "ssh" $local_path/wp-content/dbsync.sql $dev_ssh_user@$dev_ssh_host:$dev_path/wp-content/dbsync.sql && \

		sshpass -p$dev_ssh_pw ssh $dev_ssh_user@$dev_ssh_host "mysql -u $dev_db_user -p$dev_db_pw -h $dev_db_host $dev_db_name < $dev_path/wp-content/dbsync.sql"
		echo $'\n''DB fully synced!'$'\n'
		##
	fi
fi
##
if [ "$TARGET" = stage ]
then
###
	#
	echo $'\n''Propagate Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pushing Assets to Stage now...'$'\n'
		sshpass -p$stage_ssh_pw rsync -r -v --progress --update -e "ssh" $local_path/assets/ $stage_ssh_user@$stage_ssh_host:$stage_path/assets/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Stage now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw rsync -r -v --progress --update -e "ssh" $local_path/wp-content/dbsync.sql $stage_ssh_user@$stage_ssh_host:$stage_path/wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw ssh $stage_ssh_user@$stage_ssh_host "mysql -u $stage_db_user -p$stage_db_pw -h $stage_db_host $stage_db_name < $stage_path/wp-content/dbsync.sql"
		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Stage now...'$'\n'
		sshpass -p$stage_ssh_pw rsync -r -v --progress --update -e "ssh" $local_path/assets/ $stage_ssh_user@$stage_ssh_host:$stage_path/assets/ && \
		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to Stage now...'$'\n'
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw rsync -r -v --progress --update -e "ssh" $local_path/wp-content/dbsync.sql $stage_ssh_user@$stage_ssh_host:$stage_path/wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw ssh $stage_ssh_user@$stage_ssh_host "mysql -u $stage_db_user -p$stage_db_pw -h $stage_db_host $stage_db_name < $stage_path/wp-content/dbsync.sql"
		echo $'\n''DB fully synced!'$'\n'
		##
	fi
fi
