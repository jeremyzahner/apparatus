#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.3.0
############################################################################

echo $'\n'"This Script was designed for use on a local Ubuntu (or similar Linux) Development Platform, DO NOT use it else where as it may break your system."
#
echo $'\n''Please enter your login credentials (user@domain.com)?'$'\n'
#
read TARGET

echo $'\n'"Checking if deployment user exists."$'\n'

ssh -T $TARGET /bin/bash << EOF
#----

if [ ! id -u deploy > /dev/null 2>&1  ]
then

	echo $'\n'"Deployment user does not exist, setting up right now..."$'\n'

	adduser deploy

	useradd -g www-data deploy
	
	passwd -l deploy

else

	echo $'\n'"Deployment user already exists."$'\n'

fi

#----
EOF

echo $'\n'"Checking if authorized_keys file is already set up."$'\n'

ssh -T $TARGET /bin/bash << EOF
#----

	if [ -d /home/deploy/.ssh ] && [ ! -f /home/deploy/.ssh/authorized_keys ]
	then

		echo $'\n'"Authorized keys for deployment user not set up. Setting up right now..."$'\n'
		
		cd /home/deploy
		
		mkdir .ssh
		
		chmod 700 .ssh
		chown -R deploy:deploy .ssh

		touch .ssh/authorized_keys

		chown deploy:deploy .ssh/authorized_keys

		cp /root/.ssh/authorized_keys /home/deploy/.ssh/authorized_keys

		chmod 600 /home/deploy/.ssh/authorized_keys

		echo $'\n'"Authorized keys for deployment user created."$'\n'

	else

		echo $'\n'"Authorized keys for deployment user already exists."$'\n'

	fi

#----
EOF

echo $'\n'"Setting up apache directories..."$'\n'

ssh -T $TARGET /bin/bash << EOF
#----
	sudo mkdir -p /var/www

	sudo chown -R www-data:www-data /var/www

	umask 0002 /var/www
	
	sudo chmod -R g+s /var/www
#----
EOF

echo $'\n'"Apache directories set up."$'\n'

echo $'\n'"All done, thanks for using."$'\n'
