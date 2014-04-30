#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.1.0
############################################################################

## CONFIGURATION
source $PWD/apparatus.conf

echo $'\n''Script starting...'
#
echo $'\n''Making sure the permissions are right. The applications root directory is '$local_path'.'$'\n'
###########
if [ ! -d $local_assets_path ]
then
	sudo mkdir $local_assets_path
fi
###########
sudo chown -R www-data:webmasters ./*
sudo find $local_path/* -type f -exec chmod 664 {} \; 
sudo find $local_path/* -type d -exec chmod 775 {} \;
sudo find $local_path/* -type d -exec chmod g+s {} \;
#
echo $'\n''Permissions all fixed.'$'\n'