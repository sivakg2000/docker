#!/bin/bash

set -e

if [[ "$1" == apache2* ]] || [ "$1" == php-fpm ]; then
        if [ -n "$MYSQL_PORT_3306_TCP" ]; then
                if [ -z "$WORDPRESS_DB_HOST" ]; then
                        WORDPRESS_DB_HOST='mysql'
                else
                        echo >&2 "warning: both WORDPRESS_DB_HOST and MYSQL_PORT_3306_TCP found"
                        echo >&2 "  Connecting to WORDPRESS_DB_HOST ($WORDPRESS_DB_HOST)"
                        echo >&2 "  instead of the linked mysql container"
                fi
        fi

        if [ -z "$WORDPRESS_DB_HOST" ]; then
                echo >&2 "error: missing WORDPRESS_DB_HOST and MYSQL_PORT_3306_TCP environment variables"
                echo >&2 "  Did you forget to --link some_mysql_container:mysql or set an external db"
                echo >&2 "  with -e WORDPRESS_DB_HOST=hostname:port?"
                exit 1
        fi

        # If the DB user is 'root' then use the MySQL root password env var
        : ${WORDPRESS_DB_USER:=root}
        if [ "$WORDPRESS_DB_USER" = 'root' ]; then
                : ${WORDPRESS_DB_PASSWORD:=$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
        fi
        : ${WORDPRESS_DB_NAME:=joomla}

        if [ -z "$WORDPRESS_DB_PASSWORD" ] && [ "$WORDPRESS_DB_PASSWORD_ALLOW_EMPTY" != 'yes' ]; then
                echo >&2 "error: missing required WORDPRESS_DB_PASSWORD environment variable"
                echo >&2 "  Did you forget to -e WORDPRESS_DB_PASSWORD=... ?"
                echo >&2
                echo >&2 "  (Also of interest might be WORDPRESS_DB_USER and WORDPRESS_DB_NAME.)"
                exit 1
        fi

        if ! [ -e index.php -a \( -e libraries/cms/version/version.php -o -e libraries/src/Version.php \) ]; then
                echo >&2 "Joomla not found in $(pwd) - copying now..."

                if [ "$(ls -A)" ]; then
                        echo >&2 "WARNING: $(pwd) is not empty - press Ctrl+C now if this is an error!"
                        ( set -x; ls -A; sleep 10 )
                fi

                tar cf - --one-file-system -C /usr/src/joomla . | tar xf -

                if [ ! -e .htaccess ]; then
                        # NOTE: The "Indexes" option is disabled in the php:apache base image so remove it as we enable .htaccess
                        sed -r 's/^(Options -Indexes.*)$/#\1/' htaccess.txt > .htaccess
                        chown www-data:www-data .htaccess
                fi

                echo >&2 "Complete! Joomla has been successfully copied to $(pwd)"
        fi

        # Ensure the MySQL Database is created
        php /makedb.php "$WORDPRESS_DB_HOST" "$WORDPRESS_DB_USER" "$WORDPRESS_DB_PASSWORD" "$WORDPRESS_DB_NAME"

        echo >&2 "========================================================================"
        echo >&2
        echo >&2 "This server is now configured to run Joomla!"
        echo >&2
        echo >&2 "NOTE: You will need your database server address, database name,"
        echo >&2 "and database user credentials to install Joomla."
        echo >&2
        echo >&2 "========================================================================"
fi

exec "$@"
