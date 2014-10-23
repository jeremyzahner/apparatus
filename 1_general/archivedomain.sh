#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.2.1
############################################################################

echo $'\n'"This Script was designed for use on a local Ubuntu (or similar Linux) Development Platform, DO NOT use it else where as it may break your system."

echo $'\n'"Enter full domain (for Example testdrive.local.dev, without www)"$'\n'

read domain

domaindir="$HOME/public_html/$domain"
archivedir="$HOME/public_html/x_archive"
logdir="$HOME/public_html/log/$domain"
logarchivedir="$HOME/public_html/log/x_archive"
apachesa="/etc/apache2/sites-available"
vhost="/etc/apache2/sites-available/$domain.conf"
apachearchive="$apachesa/x_archive"

# Disable the site
sudo a2dissite $domain

# Reload Apache2
echo $'\n'"RELOADING APACHE......."$'\n'

sudo service apache2 reload

# Remove DIR For Sub Domain
echo $'\n'"MOVING SUB DIRECTORY FOR '$domain' DEV SITE TO ARCHIVE"$'\n'

mv $logdir $logarchivedir

cd $logarchivedir
zip -v -r $domain.zip $domain
echo $'\n'

rm -v -r $logarchivedir/$domain
echo $'\n'

mv $domaindir $archivedir

cd $archivedir
zip -v -r $domain.zip $domain
echo $'\n'

rm -v -r $archivedir/$domain
echo $'\n'

# Move Vhost to Archive
mv $vhost $apachearchive

echo $'\n'"All done, thanks for using."$'\n'