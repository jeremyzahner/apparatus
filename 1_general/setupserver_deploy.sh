#!/bin/bash

###################################################################################################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.1.0
#
#	Description: Server deployment setup script designed specially for Capistrano deployment workflow on Digital Ocean Droplets.
#
###################################################################################################################################################

echo $'\n'"This Script was designed for use on a local Ubuntu (or similar Linux) Development Platform, DO NOT use it else where as it may break your system."
#
echo $'\n''Please enter your login credentials (user@domain.com)?'$'\n'
#
read TARGET

echo $'\n'"Checking if deployment user exists."$'\n'

ssh -T $TARGET /bin/bash << EOF
#----

if [ ! -z "$(getent passwd deploy)" ]
then

	echo $'\n'"Deployment user does not exist, setting up right now..."$'\n'

	useradd -p '*' -G www-data --user-group deploy
	
	passwd -l deploy

else

	echo $'\n'"Deployment user already exists."$'\n'

fi

#----
EOF

echo $'\n'"Checking if authorized_keys file is already set up."$'\n'

ssh -T $TARGET /bin/bash << EOF
#----

	if [ ! -d /home/deploy/.ssh ] && [ ! -f /home/deploy/.ssh/authorized_keys ]
	then

		echo $'\n'"Authorized keys for deployment user not set up. Setting up right now..."$'\n'
		
		cd /home/deploy
		
		mkdir .ssh
		
		sudo chmod 700 .ssh
		sudo chown -R deploy:deploy .ssh

		touch .ssh/authorized_keys

		sudo chown deploy:deploy .ssh/authorized_keys

		sudo cp /root/.ssh/authorized_keys /home/deploy/.ssh/authorized_keys

		sudo chmod 600 .ssh/authorized_keys
		sudo chown -R deploy:deploy .ssh

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

echo $'\n'"Setting up important dependencies..."$'\n'

ssh -T $TARGET /bin/bash << EOF
#----

	sudo apt-get update

	sudo apt-get -y install git

	sudo apt-get -y install nodejs

	sudo apt-get -y install npm

	sudo \curl -sSL https://get.rvm.io | bash -s stable --rails

	sudo npm install -g bower

	sudo npm install -g grunt-cli

	sudo gem install bundler

	#sudo sh -c 'echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list'
	#sudo wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
	#sudo apt-get update
	#sudo apt-get install newrelic-sysmond
	#sudo nrsysmond-config --set license_key=YOUR_LICENSE_KEY
	#sudo /etc/init.d/newrelic-sysmond start

	#sudo apt-get update
	#sudo apt-get install newrelic-php5
	#sudo echo newrelic-php5 newrelic-php5/application-name string "My Application Name" | debconf-set-selections
	#sudo echo newrelic-php5 newrelic-php5/license-key string "0123456789abcdef0123456789abcdef01234567" | debconf-set-selections

#----
EOF

echo $'\n'"All done, thanks for using."$'\n'
