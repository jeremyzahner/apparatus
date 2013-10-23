#!/bin/bash
echo 'Script starting...'
#
echo 'The Wordpress directory is '$PWD
#
sudo mkdir assets/ 
sudo mkdir wp-content/cache/
sudo mkdir wp-content/uploads/
sudo mkdir wp-content/upgrade/
sudo mkdir wp-content/plugins/
sudo chown -R www-data:webmasters ./*
sudo find ./* -type f -exec chmod 664 {} \; 
sudo find ./* -type d -exec chmod 775 {} \;
sudo find wp-content/cache/ -exec chmod 777 {} \;  
sudo find ./* -type d -exec chmod g+s {} \;
#
echo 'All went well. Enter [Quit] to exit.'
read COMMANDE
if [ $COMMANDE = QUIT ]
	then exit
fi
