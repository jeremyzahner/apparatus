#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	First Release
#
#	Version: 1.1.0
############################################################################

echo $'\n''Script starting...'$
###########
echo $'\n''The Wordpress directory is '$PWD
echo $'\n''Are your uploads stored in a special place (i.e. ./assets)? Enter the Path like described (relative to the current location, which should be the WP-Root), leave empty if all is default.'$'\n'
###########
read CHOICE
###########
if [ -z "$CHOICE" ]
then
	echo $'\n''Your media is stored in its default location.'$'\n'
	if [ ! -d ./wp-content/uploads/ ]
	then
		sudo mkdir wp-content/uploads/
	fi
else
	echo $'\n''Your Media is stored in '$CHOICE'.'$'\n'
	if [ ! -d ./$CHOICE ]
	then
		sudo mkdir $CHOICE
	fi
fi
###########
if [ ! -d ./wp-content/cache/ ]
then
	sudo mkdir wp-content/cache/
fi
###########
if [ ! -d ./wp-content/upgrades/ ]
then
	sudo mkdir wp-content/upgrades/
fi
###########
if [ ! -d ./wp-content/plugins/ ]
then
	sudo mkdir wp-content/plugins/
fi
###########
sudo chown -R www-data:webmasters ./*
sudo find ./* -type f -exec chmod 664 {} \; 
sudo find ./* -type d -exec chmod 775 {} \;
sudo find wp-content/cache/ -exec chmod 777 {} \;  
sudo find ./* -type d -exec chmod g+s {} \;
#
echo $'\n''All went well. Thanks for using!'$'\n'
#
exit
