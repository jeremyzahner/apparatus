#!/bin/bash

###################################################################################################################################################
# 	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
# 	Alpha Release
#
#	Version: 0.3.0 - Relying on .env files now for variables.
#
###################################################################################################################################################

## CONFIGURATION
source .env
#
if [ ! -f .env ]
then
	echo $'\n''Cant find your current projects .env file. Check wether you are in your projects root and the .env file exists.'
	#
	exit
fi
#
echo $'\n''Script starting...'
#
echo $'\n''Push State to Staging / Production (staging/production)?'$'\n'
#
read TARGET
#
if [ "$TARGET" = staging ] || [ "$TARGET" = Staging ] || [ "$TARGET" = STAGING ]
then
###
	#
	echo $'\n''Propagate Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pushing Assets to Staging-Environment now...'$'\n'

		rsync -e ssh -rvzPc --update --stats $DEVELOPMENT_UPLOADS_PATH/* $STAGING_USER@$STAGING_HOST:$STAGING_UPLOADS_PATH/ && \

		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Staging-Environment now...'$'\n'

		mysqldump -u "$DEVELOPMENT_DB_USER" "-p$DEVELOPMENT_DB_PASSWORD" $DEVELOPMENT_DB_NAME > $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $DEVELOPMENT_UPLOADS_PATH/dbsync.sql $STAGING_USER@$STAGING_HOST:$STAGING_PATH/dbsync.sql && \

		ssh $STAGING_USER@$STAGING_HOST "mysql "$STAGING_DB_USER" "-p$STAGING_DB_PASSWORD" -h $STAGING_DB_HOST $STAGING_DB_NAME < $STAGING_PATH/dbsync.sql"
		
		ssh $STAGING_USER@$STAGING_HOST "cd $STAGING_WP_PATH && wp search-replace '$DEVELOPMENT_URL' '$STAGING_URL'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Staging-Environment now...'$'\n'

		rsync -e ssh -rvzPc --update --stats $DEVELOPMENT_UPLOADS_PATH/* $STAGING_USER@$STAGING_HOST:$STAGING_UPLOADS_PATH/ && \

		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to Staging-Environment now...'$'\n'

		mysqldump -u "$DEVELOPMENT_DB_USER" "-p$DEVELOPMENT_DB_PASSWORD" $DEVELOPMENT_DB_NAME > $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $DEVELOPMENT_UPLOADS_PATH/dbsync.sql $STAGING_USER@$STAGING_HOST:$STAGING_PATH/dbsync.sql && \

		ssh $STAGING_USER@$STAGING_HOST "mysql "$STAGING_DB_USER" "-p$STAGING_DB_PASSWORD" -h $STAGING_DB_HOST $STAGING_DB_NAME < $STAGING_PATH/dbsync.sql"
		
		ssh $STAGING_USER@$STAGING_HOST "cd $STAGING_WP_PATH && wp search-replace '$DEVELOPMENT_URL' '$STAGING_URL'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi
###
fi
##
if [ "$TARGET" = production ] || [ "$TARGET" = Production ] || [ "$TARGET" = PRODUCTION ]
then
###
	#
	echo $'\n''Propagate Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pushing Assets to Production-Environment now...'$'\n'

		rsync -e ssh -rvzPc --update --stats $DEVELOPMENT_UPLOADS_PATH/* $PRODUCTION_USER@$PRODUCTION_HOST:$PRODUCTION_UPLOADS_PATH/ && \

		echo $'\n''All Assets pushed!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pushing DB to Production-Environment now...'$'\n'

		mysqldump -u "$DEVELOPMENT_DB_USER" "-p$DEVELOPMENT_DB_PASSWORD" $DEVELOPMENT_DB_NAME > $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $DEVELOPMENT_UPLOADS_PATH/dbsync.sql $PRODUCTION_USER@$PRODUCTION_HOST:$PRODUCTION_PATH/dbsync.sql && \

		ssh $PRODUCTION_USER@$PRODUCTION_HOST "mysql "$PRODUCTION_DB_USER" "-p$PRODUCTION_DB_PASSWORD" -h $PRODUCTION_DB_HOST $PRODUCTION_DB_NAME < $PRODUCTION_PATH/dbsync.sql"
		
		ssh $PRODUCTION_USER@$PRODUCTION_HOST "cd $PRODUCTION_WP_PATH && wp search-replace '$DEVELOPMENT_URL' '$PRODUCTION_URL'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pushing Assets to Production-Environment now...'$'\n'

		rsync -e ssh -rvzPc --update --stats $DEVELOPMENT_UPLOADS_PATH/* $PRODUCTION_USER@$PRODUCTION_HOST:$PRODUCTION_UPLOADS_PATH/ && \

		echo $'\n''All Assets pushed!'$'\n'
		##
		echo $'\n''Pushing DB to Production-Environment now...'$'\n'
		
		mysqldump -u "$DEVELOPMENT_DB_USER" "-p$DEVELOPMENT_DB_PASSWORD" $DEVELOPMENT_DB_NAME > $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		rsync -e ssh -rvzPc --update --stats $DEVELOPMENT_UPLOADS_PATH/dbsync.sql $PRODUCTION_USER@$PRODUCTION_HOST:$PRODUCTION_PATH/dbsync.sql && \

		ssh $PRODUCTION_USER@$PRODUCTION_HOST "mysql "$PRODUCTION_DB_USER" "-p$PRODUCTION_DB_PASSWORD" -h $PRODUCTION_DB_HOST $PRODUCTION_DB_NAME < $PRODUCTION_PATH/dbsync.sql"
		
		ssh $PRODUCTION_USER@$PRODUCTION_HOST "cd $PRODUCTION_WP_PATH && wp search-replace '$DEVELOPMENT_URL' '$PRODUCTION_URL'"

		echo $'\n''DB fully synced!'$'\n'
		##
	fi
###
fi
