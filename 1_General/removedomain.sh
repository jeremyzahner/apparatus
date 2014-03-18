#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	First Release
#
#	Version: 1.0.0
############################################################################

echo $'\n'"This Script was designed for use on a local Ubuntu (or similar Linux) Development Platform, DO NOT use it else where as it may break your system."

echo $'\n'"Enter full domain (for Example testdrive.local.dev, without www)"$'\n'

read domain

domaindir="$HOME/public_html/$domain"
vhost="/etc/apache2/sites-available/$domain.conf"

# Disable the site
sudo a2dissite $domain

# Reload Apache2
echo $'\n'"RELOADING APACHE......."$'\n'

sudo service apache2 reload

# Remove DIR For Sub Domain
echo $'\n'"DELETEING SUB DIRECTORY FOR '$domain' DEV SITE"$'\n'
rm -r $domaindir

# Delete VHost
rm $vhost

echo $'\n'"All done, thanks for using."$'\n'