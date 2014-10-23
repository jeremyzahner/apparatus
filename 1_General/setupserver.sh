#!/bin/bash

############################################################################
#	Created by Jeremy "Jay" Zahner (@jeremyzahner)
#  
#	Alpha Release
#
#	Version: 0.3.0
############################################################################

echo $'\n'"This Script was designed for use on a local Ubuntu (or similar Linux) Development Platform, DO NOT use it else where as it may break your system."

echo $'\n'"Setting up deployment user."$'\n'

adduser deploy

passwd -l deploy

su - deploy

cd ~

mkdir .ssh

chmod 700 .ssh

touch .ssh/authorized_keys

exit

cp /root/.ssh/authorized_keys /home/deploy/.ssh/authorized_keys

chmod 600 /home/deploy/.ssh/authorized_keys

deploy_to=/var/www
mkdir -p /var/www
chown deploy:www-data /var/www
umask 0002
chmod g+s /var/www
mkdir /var/www/{releases,shared}
chown deploy:www-data /var/www/{releases,shared}

echo $'\n'"All done, thanks for using."$'\n'
