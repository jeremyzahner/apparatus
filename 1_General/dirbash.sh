#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.1.0
############################################################################

echo $'\n''Script starting...'
#
echo $'\n''Making sure the permissions are right. The applications root directory is '$PWD$'\n'
#
sudo chown -R www-data:webmasters ./*
sudo find ./* -type f -exec chmod 664 {} \; 
sudo find ./* -type d -exec chmod 775 {} \;
sudo find ./* -type d -exec chmod g+s {} \;
#
echo $'\n''Permissions all fixed.'$'\n'