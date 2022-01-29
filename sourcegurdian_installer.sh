#!/usr/bin/env bash

clear
echo "###############################################################################"
echo "start sourcegurdian installation"

# Show an error and exit
abort() {
  echo "$1"
  exit 1
}

PHP_VERTION=$1

#dot vertion to no dot version (7.4 => 74) 
A=(${PHP_VERTION//\./})
PHP_VERTION_NO_DOT="${A[@]}"

PHP_INI=/usr/local/php$PHP_VERTION_NO_DOT/lib/php.ini

SOURCE_GUARDIAN_FILE_NAME=SourceGuardian-loaders.linux-x86_64-12.1.2.zip

#check extension in php.ini file
if [[ ! "$(grep -P "ixed.\d+\.\d+.lin"  /usr/local/php$PHP_VERTION/lib/php.ini)" ]]; then
  echo "add extension=ixed.$PHP_VERTION.lin to php.ini"
  echo extension=ixed.$PHP_VERTION.lin >> /usr/local/php$PHP_VERTION_NO_DOT/lib/php.ini
else
  echo "update sourcegurdian"
fi

cd /usr/local/php$PHP_VERTION_NO_DOT/lib/php/extensions/no-debug-non-zts-*/

#download sourcegurdian file and extraxt it
echo "download and extraxt sourcegurdian files"
wget https://bash-files.s3.ir-thr-at1.arvanstorage.com/$SOURCE_GUARDIAN_FILE_NAME >/dev/null 2>&1
unzip -o $SOURCE_GUARDIAN_FILE_NAME >/dev/null 2>&1

echo " "
echo "done, for complete installation please"
echo "restart php handler and webserver"
