#!/bin/sh

#######################################
# Bash script to install Apache, MySQL and PHP 7.1
# For Debian based systems.
# Based on @AamnahAkram from http://aamnah.com


# In case of any errors (e.g. MySQL) just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Update packages and Upgrade system
echo -e "$Cyan \n Updating System.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

#Installing Apache
echo -e "$Cyan \n Installing Apache2 $Color_Off"
sudo apt-get install apache2 -y

#Installing PHP
echo -e "$Cyan \n Adding Support for PHP7.1, Installing & Requirements $Color_Off"
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y
sudo apt-get install php7.1 libapache2-mod-php7.1 php7.1-mcrypt php7.1-mysql -y

#Installing MySQL
echo -e "$Cyan \n Installing MySQL $Color_Off."
sudo apt-get -y install mysql-server mysql-client
sudo mysql_secure_installation

## TWEAKS and Settings
# Permissions
echo -e "$Cyan \n Permissions for /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo -e "$Green \n Permissions have been set $Color_Off"

# Enabling Mod Rewrite, required for WordPress permalinks and .htaccess files
echo -e "$Cyan \n Enabling Modules $Color_Off"
sudo a2enmod rewrite
sudo php7.1enmod mcrypt

# Restart Apache
echo -e "$Cyan \n Restarting Apache $Color_Off"
sudo service apache2 restart

