#!/bin/bash

    service apache2 start


if [ ! -e /var/www/html/moodle/config-dist.php ]; then
   cp /var/www/html/moodle/config-dist.php /var/www/html/moodle/config.php

    sed -i "s/\$CFG->dbtype\s*=\s*'[^']*'/\$CFG->dbtype = 'pgsql'/" /var/www/html/moodle/config-dist.php
    sed -i "s/\$CFG->dblibrary\s*=\s*'[^']*'/\$CFG->dblibrary = 'native'/" /var/www/html/moodle/config-dist.php
    sed -i "s/\$CFG->dbhost\s*=\s*'[^']*'/\$CFG->dbhost = 'db'/" /var/www/html/moodle/config-dist.php
    sed -i "s/\$CFG->dbname\s*=\s*'[^']*'/\$CFG->dbname = 'moodle'/" /var/www/html/moodle/config-dist.php
    sed -i "s/\$CFG->dbuser\s*=\s*'[^']*'/\$CFG->dbuser = 'moodle'/" /var/www/html/moodle/config-dist.php
    sed -i "s/\$CFG->dbpass\s*=\s*'[^']*'/\$CFG->dbpass = 'senha'/" /var/www/html/moodle/config-dist.php
    sed -i "s/\$CFG->dboptions\s*=\s*\[[^\]]*\]/\$CFG->dboptions = ['dbpersist' => 0, 'dbport' => '5432', 'dbsocket' => '']/" /var/www/html/moodle/config-dist.php

    chown www-data:www-data /var/www/html/moodle/config-dist.php
fi

service cron start

tail -f /dev/null
