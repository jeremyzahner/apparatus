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
echo $'\n''The Wordpress directory is '$my_webroot/$local_rel_path
echo $'\n''Your Uploads/Assets are stored in '$my_webroot/$local_rel_assets_path'.'$'\n'
###########
if [ ! -d $my_webroot/$local_rel_assets_path ]
then
	sudo mkdir $my_webroot/$local_rel_assets_path
fi
###########
if [ ! -d $my_webroot/$local_rel_path/wp-content/cache/ ]
then
	sudo mkdir $my_webroot/$local_rel_path/wp-content/cache/
fi
###########
if [ ! -d $my_webroot/$local_rel_path/wp-content/plugins/ ]
then
	sudo mkdir $my_webroot/$local_rel_path/wp-content/plugins/
fi
###########
sudo chown -R www-data:webmasters ./*
sudo find $my_webroot/$local_rel_path/* -type f -exec chmod 664 {} \; 
sudo find $my_webroot/$local_rel_path/* -type d -exec chmod 755 {} \;
sudo find $my_webroot/$local_rel_path/wp-content/cache/ -exec chmod 775 {} \;  
sudo find $my_webroot/$local_rel_path/* -type d -exec chmod g+rwxs {} \;
#
echo $'\n''All went well. Thanks for using!'$'\n'
#
exit
