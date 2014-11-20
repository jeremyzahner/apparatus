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
echo $'\n''Pull State from Staging / Production (staging/production)?'$'\n'
#
read TARGET
#
if [ "$TARGET" = staging ] || [ "$TARGET" = Staging ] || [ "$TARGET" = STAGING ]
then
###
	#
	echo $'\n''Pull Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pulling Assets from Staging-Environment now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $STAGING_USER@$STAGING_HOST:$STAGING_UPLOADS_PATH/* $DEVELOPMENT_UPLOADS_PATH/ && \
		echo $'\n''All Assets pulled!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pulling DB from Staging-Environment now...'$'\n'

		ssh $STAGING_USER@$STAGING_HOST "mysqldump -u "$STAGING_DB_USER" "-p$STAGING_DB_PASSWORD" -h $STAGING_DB_HOST $STAGING_DB_NAME > $STAGING_PATH/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $STAGING_USER@$STAGING_HOST:$STAGING_PATH/dbsync.sql $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		mysql -u "$DEVELOPMENT_DB_USER" "-p$DEVELOPMENT_DB_PASSWORD" -h $DB_HOST $DB_NAME < $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		cd $DEVELOPMENT_WP_PATH && wp search-replace $STAGING_URL $DEVELOPMENT_URL

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pulling Assets from Staging-Environment now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $STAGING_USER@$STAGING_HOST:$STAGING_UPLOADS_PATH/* $DEVELOPMENT_UPLOADS_PATH/ && \
		echo $'\n''All Assets pulled!'$'\n'
		##
		echo $'\n''Pulling DB from Staging-Environment now...'$'\n'

		ssh $STAGING_USER@$STAGING_HOST "mysqldump -u "$STAGING_DB_USER" "-p$STAGING_DB_PASSWORD" -h $STAGING_DB_HOST $STAGING_DB_NAME > $STAGING_PATH/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $STAGING_USER@$STAGING_HOST:$STAGING_PATH/dbsync.sql $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		mysql -u "$DEVELOPMENT_DB_USER" "-p$DEVELOPMENT_DB_PASSWORD" -h $DB_HOST $DB_NAME < $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		cd $DEVELOPMENT_WP_PATH && wp search-replace $STAGING_URL $DEVELOPMENT_URL

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
	echo $'\n''Pull Assets / Database / Assets & Database (A/D/AD)?'$'\n'
	#
	read CHOICE

	if [ "$CHOICE" = a ] || [ "$CHOICE" = A ]
	then
		##
		echo $'\n''Pulling Assets from Production-Environment now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $PRODUCTION_USER@$PRODUCTION_HOST:$PRODUCTION_UPLOADS_PATH/* $DEVELOPMENT_UPLOADS_PATH/ && \
		echo $'\n''All Assets pulled!'$'\n'
		##
	fi

	if [ "$CHOICE" = d ] || [ "$CHOICE" = D ]
	then
		##
		echo $'\n''Pulling DB from Production-Environment now...'$'\n'

		ssh $PRODUCTION_USER@$PRODUCTION_HOST "mysqldump -u "$PRODUCTION_DB_USER" "-p$PRODUCTION_DB_PASSWORD" -h $PRODUCTION_DB_HOST $PRODUCTION_DB_NAME > $PRODUCTION_PATH/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $PRODUCTION_USER@$PRODUCTION_HOST:$PRODUCTION_PATH/dbsync.sql $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		mysql -u "$DEVELOPMENT_DB_USER" "-p$DEVELOPMENT_DB_PASSWORD" -h $DB_HOST $DB_NAME < $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		cd $DEVELOPMENT_WP_PATH && wp search-replace $PRODUCTION_URL $DEVELOPMENT_URL

		echo $'\n''DB fully synced!'$'\n'
		##
	fi

	if [ "$CHOICE" = ad ] || [ "$CHOICE" = AD ]
	then
		##
		echo $'\n''Pulling Assets from Production-Environment now...'$'\n'
		rsync -e ssh -rvzPc --update --stats $PRODUCTION_USER@$PRODUCTION_HOST:$PRODUCTION_UPLOADS_PATH/* $DEVELOPMENT_UPLOADS_PATH/ && \
		echo $'\n''All Assets pulled!'$'\n'
		##
		echo $'\n''Pulling DB from Production-Environment now...'$'\n'

		ssh $PRODUCTION_USER@$PRODUCTION_HOST "mysqldump -u "$PRODUCTION_DB_USER" "-p$PRODUCTION_DB_PASSWORD" -h $PRODUCTION_DB_HOST $PRODUCTION_DB_NAME > $PRODUCTION_PATH/dbsync.sql" && \

		rsync -e ssh -rvzPc --update --stats $PRODUCTION_USER@$PRODUCTION_HOST:$PRODUCTION_PATH/dbsync.sql $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		mysql -u "$DEVELOPMENT_DB_USER" "-p$DEVELOPMENT_DB_PASSWORD" -h $DB_HOST $DB_NAME < $DEVELOPMENT_UPLOADS_PATH/dbsync.sql && \

		cd $DEVELOPMENT_WP_PATH && wp search-replace $PRODUCTION_URL $DEVELOPMENT_URL

		echo $'\n''DB fully synced!'$'\n'
		##
	fi
###
fi
