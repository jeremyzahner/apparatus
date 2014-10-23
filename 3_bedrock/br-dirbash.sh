#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.3.0 - Relying on .env files now for variables.
############################################################################

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
###########
echo $'\n''The Wordpress directory is '$DEVELOPMENT_WP_PATH
echo $'\n''Your Uploads/Assets are stored in '$DEVELOPMENT_UPLOADS_PATH'.'$'\n'
###########
if [ ! -d $DEVELOPMENT_UPLOADS_PATH ]
then
	sudo mkdir $DEVELOPMENT_UPLOADS_PATH
fi
###########
sudo chown -R $DEVELOPMENT_USER:$DEVELOPMENT_GROUP ./*
sudo find $DEVELOPMENT_WP_PATH/../* -type f -exec chmod 664 {} \; 
sudo find $DEVELOPMENT_WP_PATH/../* -type d -exec chmod 775 {} \;
sudo find $DEVELOPMENT_WP_PATH/../* -type d -exec chmod g+s {} \;
#
echo $'\n''All went well. Thanks for using!'$'\n'
#
exit
