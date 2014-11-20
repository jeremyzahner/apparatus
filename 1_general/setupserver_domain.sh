#!/bin/bash

###################################################################################################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.1.0
#
#	Description: Server domain setup script designed specially for Capistrano deployment workflow on Digital Ocean Droplets.
#
###################################################################################################################################################

echo $'\n'"This Script was designed for use on a local Ubuntu (or similar Linux) Development Platform, DO NOT use it else where as it may break your system."

echo $'\n'"Enter full domain (for Example testdrive.local.dev, without www)"$'\n'

read domain

domaindir="/var/www/$domain"
apachesa="/etc/apache2/sites-available"

echo $'\n''Please enter your login credentials (user@domain.com)?'$'\n'
#
read TARGET
#
echo $'\n'"Checking if directory for '$domain' site exists..."$'\n'

ssh -T $TARGET /bin/bash << EOF
#----

if [ ! -d $domaindir ] || [ ! -d $domaindir/shared ] || [ ! -d $domaindir/shared/logs ] || [ ! -d $domaindir/current ] || [ ! -d $domaindir/current/web ]
then

	echo $'\n'"Directory for '$domain' site does not exist, setting up right now..."$'\n'

	if [ ! -d $domaindir ]
		then 
		mkdir $domaindir
	fi
	if [ ! -d $domaindir/shared ]
		then
		mkdir $domaindir/shared
	fi
	if [ ! -d $domaindir/shared/logs ]
		then 
		mkdir $domaindir/shared/logs
	fi
	if [ ! -d $domaindir/current ]
		then 
		mkdir $domaindir/current
	fi
	if [ ! -d $domaindir/current/web ]
		then 
		mkdir $domaindir/current/web
	fi

	sudo chown -R www-data:www-data $domaindir
	sudo find $domaindir -type f -exec chmod 664 {} \; 
	sudo find $domaindir -type d -exec chmod 755 {} \;
	sudo find $domaindir -type d -exec chmod g+rwxs {} \;

	echo $'\n'"Directory for '$domain' site successfully created."$'\n'

else

	echo $'\n'"Directory for '$domain' site already exists."$'\n'

fi

#----
EOF


echo $'\n'"Checking if vhost file for '$domain' site exists..."$'\n'

ssh -T $TARGET /bin/bash << EOF
#----

if  [ ! -f /etc/apache2/sites-available/$domain.conf ]
then

	echo $'\n'"Vhost file for '$domain' site does not exist, setting up right now..."$'\n'

	# Create Vhost
	sudo cat <<- EOF > $apachesa/$domain.conf
	<VirtualHost *:80>

		ServerAdmin me@jeremyzahner.com
		ServerName $domain
		ServerAlias www.$domain
		DocumentRoot $domaindir/current/web

		<Directory $domaindir/current/web>
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

		ErrorLog $domaindir/shared/logs/error.log

		# Possible values include: debug, info, notice, warn, error, crit,
		# alert, emerg.
		LogLevel warn

		CustomLog $domaindir/shared/logs/access.log combined

	</VirtualHost>
	EOF

	sudo chown -R www-data:www-data $apachesa
	sudo find $apachesa -type f -exec chmod 664 {} \; 
	sudo find $apachesa -type d -exec chmod 755 {} \;
	sudo find $apachesa -type d -exec chmod g+s {} \;

	# Add to Hosts File
	sudo cat <<- EOF > /etc/hosts
	#############################
	## Added by setupserver_domain.sh ##
	#############################
	127.0.0.1 	$domain
	127.0.0.1 	www.$domain
	#############################
	EOF

	# Enable the site
	sudo a2ensite $domain

	# Reload Apache2
	echo $'\n'"Reloading Apache......."$'\n'

	sudo service apache2 reload


else

	echo $'\n'"Vhost file for '$domain' site already exists."$'\n'

fi

#----
EOF

echo $'\n'"All done, thanks for using."$'\n'
