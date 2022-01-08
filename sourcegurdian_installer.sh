#!/bin/bash
PHP_VERTION=$1
A=(${PHP_VERTION//\./})
PHP_VERTION_NODOT="${A[@]}"
PHP_INI=/usr/local/php$PHP_VERTION_NODOT/lib/php.ini
SOURCE_GUARDIAN_FILE_NAME=SourceGuardian-loaders.linux-x86_64-12.1.2.zip

echo extension=ixed.$PHP_VERTION.lin >> /usr/local/php$PHP_VERTION_NODOT/lib/php.ini
echo "add extensions to php.ini"

cd /usr/local/php$PHP_VERTION_NODOT/lib/php/extensions/no-debug-non-zts-*/
echo "cd to extension_dir"

wget https://bash-files.s3.ir-thr-at1.arvanstorage.com/$SOURCE_GUARDIAN_FILE_NAME >/dev/null 2>&1
unzip -o $SOURCE_GUARDIAN_FILE_NAME >/dev/null 2>&1
echo "download and extraxt sourcegurdian files"

echo "done restart webserver"
