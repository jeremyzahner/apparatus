Apparatus
======

*THIS PROJECT IS NO LONGER MAINTAINED*

"Apparatus" is latin and means "Machine".

Collection of web developer automation tools.

Right now im developing on Linux. So my coding will be very much targeted at unix-based systems for now.

For now, this is built for Developers familiar with using CLI for kickstarting their workflow.

Notice: For using all functions in this framework, you will need to be in the sudoers file for now. As this is intended to be used on local dev environments, this should not be a problem.

Tested and Working on following Plattforms
---
- Ubuntu 12 - Apache2 - PHP5
- Ubuntu 13 - Apache2 - PHP5

Short term goals
---
- Finishing half-automated DB-Sync Tools in matters of Wordpress
- Finishing half-automated Wordpress Directory Permissions (ReadWrite/Ownership)

Long term goals
---
- Build an automation framework for web-developers, maybe add a GUI for Developers not familiar with CLI someday.
- Port this to NodeJS.

Setup General
---
- Pull this repository anywhere.
  - ```git pull git@github.com:jeremyzahner/Apparatus.git```
- Enter the "Config" directory.
  - ```cd Config```
- Edit .bash_aliases so it points to the right direction. Here you need to replace "APPARATUS_LOCATION" by the absolute path where you pulled Apparatus to.
  - ```gedit .bash_aliases``` or ```vim .bash_aliases``` or any other editor you'd like to use.
- Make a copy of .bash_aliases and put it into your home directory. There it gets caught by the default bash profile script.
  - ```cp -v .bash_aliases $HOME```

Setup Wordpress
---
- Make a copy of devconfig.txt and put it into your wordpress root directory.
  - ```cp -v devconfig.txt /var/www/WORDPRESS_ROOT``` or ```cp -v devconfig.txt ~/public_html/WORDPRESS_ROOT``` or ```cp -v devconfig.txt ~/www/WORDPRESS_ROOT``` depending on your setup.
  - Make sure to replace "WORDPRESS_ROOT" by the directory your wordpress stays in.

Usage General
---
- TBA

Usage Wordpress
---
- TBA
