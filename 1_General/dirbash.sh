#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.2.0
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

echo $'\n''Script starting...'
###########
echo $'\n''The applications root directory is '$my_webroot/$local_rel_path'.'$'\n'
echo $'\n''Your Uploads/Assets are stored in '$my_webroot/$local_rel_assets_path'.'$'\n'
###########
if [ ! -d $my_webroot/$local_rel_assets_path ]
then
	echo $'\n''Your Uploads/Assets directory does not exist here: '$my_webroot/$local_rel_assets_path'.'$'\n'
	echo $'\n''Do you want to create it? (Yes/No).'$'\n'

	read makeassetsdir

	if [ "$makeassetsdir" = Yes ] || [ "$makeassetsdir" = yes ] || [ "$makeassetsdir" = Y ] || [ "$makeassetsdir" = y ]
	then
	###
		sudo mkdir $my_webroot/$local_rel_assets_path
	fi
fi
###########
sudo chown -R www-data:webmasters ./*
sudo find $my_webroot/$local_rel_path/* -type f -exec chmod 664 {} \; 
sudo find $my_webroot/$local_rel_path/* -type d -exec chmod 775 {} \;
sudo find $my_webroot/$local_rel_path/* -type d -exec chmod g+s {} \;
#
echo $'\n''Permissions all fixed.'$'\n'
#
exit
