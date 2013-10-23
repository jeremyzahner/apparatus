#!/bin/bash

## apparatus WP-PUSH
## Coded with <3 by Jeremy J. Zahner
## Gihub-Repo: https://github.com/jeremyzahner/apparatus

## CONFIGURATION

#--Local
local_db_host='X_LOCALHOST_X'; # on most local dev machines this will be "localhost"
local_db_user='X_DBUSER_X'; # local mysql db user
local_db_pw='X_DBPASSWORD_X'; # local mysql db password
local_db_name='X_DBNAME_X'; # local mysql db name
local_path='/var/www/X_PROJECTNAME_X'; # local path to project
#--Stage
stage_ssh_host='X_SSHHOST_X';
stage_ssh_user='X_SSHUSER_X';
stage_ssh_pw='X_SSHPASSWORD_X';
stage_db_host='X_DBHOST_X';
stage_db_user='X_DBUSER_X';
stage_db_pw='X_DBPASSWORD_X';
stage_db_name='X_DBNAME_X';
stage_path='/home/www-data/stage/X_PROJECTNAME_X';
#--Live
live_ssh_host='X_SSHHOST_X.nine.ch';
live_ssh_user='X_SSHHOST_X';
live_ssh_pw='X_SSHPASSWORD_X';
live_db_host='X_DBHOST_X';
live_db_user='X_DBUSER_X';
live_db_pw='X_DBPASSWORD_X';
live_db_name='X_DBNAME_X';
live_path='/home/www-data/X_PROJECTNAME_X';

## END CONFIGURATION
#
echo 'Script starting...'
#
echo 'Propagate changes to Master / Master&Stage / Master&Stage&Live / DB Only (M/MS/MSL/DBO)?'
#
read CHOICE

if [ "$CHOICE" = M ]
then
	##
	echo 'Enter Commitment Message'
	read MESSAGE
	git checkout master && \
	git add . && \
	git add -u && \
	git commit -m "$MESSAGE" && \
	git push origin master
	##
fi

if [ "$CHOICE" = MS ]
then
	##
	echo 'Enter Commitment Message'
	read MESSAGE
	git checkout master && \
	git add . && \
	git add -u && \
	git commit -m "$MESSAGE" && \
	git push origin master && \
	git checkout stage && \
	git merge master && \
	git push origin stage && \
	git checkout master
	##
	echo 'Migrate Database to Stage? (You need to have sshpass installed in order for this to work as expected) (y/n)'
	#
	read DBCHOICE
	if [ "$DBCHOICE" = y ]
	then
		##
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw scp wp-content/dbsync.sql $stage_ssh_user@$stage_ssh_host:$stage_path/wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw ssh $stage_ssh_user@$stage_ssh_host "mysql -u $stage_db_user -p$stage_db_pw -h $stage_db_host $stage_db_name < $stage_path/wp-content/dbsync.sql"
		##
	fi
fi

if [ "$CHOICE" = MSL ]
then
	##
	echo 'Enter Commitment Message'
	read MESSAGE
	git checkout master && \
	git add . && \
	git add -u && \
	git commit -m "$MESSAGE" && \
	git push origin master && \
	git checkout stage && \
	git merge master && \
	git push origin stage && \
	git checkout live && \
	git merge master && \
	git push origin live && \
	git checkout master
	##
	echo 'Migrate Database to Live? (You need to have sshpass installed in order for this to work as expected) (y/n)'
	#
	read DBCHOICE
	if [ "$DBCHOICE" = y ]
	then
		##
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$live_ssh_pw scp wp-content/dbsync.sql $live_ssh_user@$live_ssh_host:$live_path/wp-content/dbsync.sql && \

		sshpass -p$live_ssh_pw ssh $live_ssh_user@$live_ssh_host "mysql -u $live_db_user -p$live_db_pw -h $live_db_host $live_db_name < $live_path/wp-content/dbsync.sql"
		##
	fi
fi
if [ "$CHOICE" = DBO ]
then
	##
	echo 'Migrate to Stage-DB / Live-DB / Both (sdb/ldb/bdb)'
	#
	read DBCHOICE
	if [ "$DBCHOICE" = sdb ]
	then
		##
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw scp wp-content/dbsync.sql $stage_ssh_user@$stage_ssh_host:$stage_path/wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw ssh $stage_ssh_user@$stage_ssh_host "mysql -u $stage_db_user -p$stage_db_pw -h $stage_db_host $stage_db_name < $stage_path/wp-content/dbsync.sql"
		##
	fi
	if [ "$DBCHOICE" = ldb ]
	then
		##
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$live_ssh_pw scp wp-content/dbsync.sql $live_ssh_user@$live_ssh_host:$live_path/wp-content/dbsync.sql && \

		sshpass -p$live_ssh_pw ssh $live_ssh_user@$live_ssh_host "mysql -u $live_db_user -p$live_db_pw -h $live_db_host $live_db_name < $live_path/wp-content/dbsync.sql"
		##
	fi
	if [ "$DBCHOICE" = bdb ]
	then
		##
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw scp wp-content/dbsync.sql $stage_ssh_user@$stage_ssh_host:$stage_path/wp-content/dbsync.sql && \

		sshpass -p$stage_ssh_pw ssh $stage_ssh_user@$stage_ssh_host "mysql -u $stage_db_user -p$stage_db_pw -h $stage_db_host $stage_db_name < $stage_path/wp-content/dbsync.sql" && \
		##
		##
		mysqldump -u $local_db_user -p$local_db_pw $local_db_name > wp-content/dbsync.sql && \

		sshpass -p$live_ssh_pw scp wp-content/dbsync.sql $live_ssh_user@$live_ssh_host:$live_path/wp-content/dbsync.sql && \

		sshpass -p$live_ssh_pw ssh $live_ssh_user@$live_ssh_host "mysql -u $live_db_user -p$live_db_pw -h $live_db_host $live_db_name < $live_path/wp-content/dbsync.sql"
		##
	fi
fi