#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.1.1
############################################################################

## CONFIGURATION
source $PWD/apparatus.conf

echo $'\n''Script starting...'$
###########
echo $'\n''The Wordpress directory is '$local_path
echo $'\n''Your Uploads/Assets are stored in '$local_assets_path'.'$'\n'
###########
if [ ! -d $local_assets_path ]
then
	sudo mkdir $local_assets_path
fi
###########
if [ ! -d $local_path/wp-content/cache/ ]
then
	sudo mkdir $local_path/wp-content/cache/
fi
###########
if [ -d $local_path/wp-content/upgrade/ ]
then
	sudo rm -r $local_path/wp-content/upgrade/
fi
###########
if [ -d $local_path/wp-content/upgrades/ ]
then
	sudo rm -r $local_path/wp-content/upgrades/
fi
###########
if [ ! -d $local_path/wp-content/plugins/ ]
then
	sudo mkdir $local_path/wp-content/plugins/
fi
###########
sudo chown -R www-data:webmasters ./*
sudo find $local_path/* -type f -exec chmod 664 {} \; 
sudo find $local_path/* -type d -exec chmod 775 {} \;
sudo find $local_path/wp-content/cache/ -exec chmod 777 {} \;  
sudo find $local_path/* -type d -exec chmod g+s {} \;
#
echo $'\n''All went well. Thanks for using!'$'\n'
#
exit
