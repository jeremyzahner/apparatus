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
apachesa="/etc/apache2/sites-available"

# Create New DIR For Sub Domain
echo $'\n'"CREATING SUB DIRECTORY FOR '$domain' DEV SITE"$'\n'
mkdir $domaindir
mkdir $domaindir/log

sudo chown -R www-data:webmasters $domaindir
sudo find $domaindir -type f -exec chmod 664 {} \; 
sudo find $domaindir -type d -exec chmod 775 {} \;
sudo find $domaindir -type d -exec chmod g+s {} \;

# Go There
cd $domaindir
# Create Test File In New Sub Domain Folder
echo $'\n'"CREATING TEST FILE index.php"$'\n'

cat > $domaindir/index.php << ENDCAT
<?php
    echo '<h1>Hello World</h1>';
?>
ENDCAT

# Create Vhost
sudo bash -c "cat >> $apachesa/$domain.conf" << ENDCAT
<VirtualHost *:80>

	ServerAdmin j.zahner@ammarkt.ch
	ServerName $domain
	ServerAlias www.$domain
	DocumentRoot $domaindir

	<Directory $domaindir>
		Options +Indexes +FollowSymLinks +MultiViews
		AllowOverride ALL
		Require all granted
	</Directory>

	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
	<Directory "/usr/lib/cgi-bin">
		AllowOverride None
		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
		Require all granted
	</Directory>

	ErrorLog $domaindir/log/error.log

	# Possible values include: debug, info, notice, warn, error, crit,
	# alert, emerg.
	LogLevel warn

	CustomLog $domaindir/log/access.log combined

</VirtualHost>

ENDCAT

sudo chown -R www-data:webmasters $apachesa
sudo find $apachesa -type f -exec chmod 664 {} \; 
sudo find $apachesa -type d -exec chmod 775 {} \;
sudo find $apachesa -type d -exec chmod g+s {} \;

# Add to Hosts File
sudo bash -c "cat >> /etc/hosts" << ENDCAT
#############################
## Added by setupdomain.sh ##
#############################
127.0.0.1 	$domain
127.0.0.1 	www.$domain
#############################
ENDCAT

# Enable the site
sudo a2ensite $domain

# Reload Apache2
echo $'\n'"RELOADING APACHE......."$'\n'

sudo service apache2 reload

echo $'\n'"All done, thanks for using."$'\n'
