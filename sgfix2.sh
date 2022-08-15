#!/usr/bin/env bash

clear
echo "###############################################################################"

# Show an error and exit
abort() {
  echo "$1"
  exit 1
}

for PV in $(grep -e php[1234]_release /usr/local/directadmin/custombuild/options.conf | cut -d "=" -f "2")
do
    PHP_VERTION=$PV

    #dot vertion to no dot version (7.4 => 74) 
    A=(${PHP_VERTION//\./})
    PHP_VERTION_NO_DOT="${A[@]}"

    PHP_INI=/usr/local/php$PHP_VERTION_NO_DOT/lib/php.ini
    DIRECTADMIN_INI=/usr/local/php$PHP_VERTION_NO_DOT/lib/php.conf.d/10-directadmin.ini

    #remove extension from ini files
    sed -i -r '/extension=ixed/d' $PHP_INI 
    sed -i -r '/extension=ixed/d' $DIRECTADMIN_INI

    #check extension in ini file
    if [[ ! "$(grep -P "ixed.\d+\.\d+.lin"  $PHP_INI)" ]] || [[ ! "$(grep -P "ixed.\d+\.\d+.lin"  $DIRECTADMIN_INI)" ]]; then
      #echo "add extension=ixed.$PHP_VERTION_NO_DOT.lin to php.ini"
      echo extension=ixed.$PHP_VERTION.lin >> $DIRECTADMIN_INI
    fi
done

/usr/local/directadmin/directadmin set set_php_ini_scan_dir_in_crons 0
service directadmin restart

killall -9 lsphp
systemctl restart php-fpm*
systemctl restart httpd
systemctl restart lsws

echo "done"
