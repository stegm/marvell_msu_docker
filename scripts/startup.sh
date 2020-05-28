#!/bin/dash

# set root password if given 
if [ -n "$MSU_ROOT_PASSWD" ]
then
	echo "root:$MSU_ROOT_PASSWD" | chpasswd
fi

if [ "$1" = "cli" ]
then
	shift
	exec /opt/marvell/storage/cli/mvcli "$@"
fi


# start storage agent in background
/opt/marvell/storage/svc/MarvellStorageAgent start

# start web server in foreground
export LD_LIBRARY_PATH=/opt/marvell/storage/apache2/lib64:/opt/marvell/storage/expat/lib64:/opt/marvell/storage/libxml2/lib64:/opt/marvell/storage/openssl/lib64:/opt/marvell/storage/php/lib64
exec /opt/marvell/storage/apache2/bin/apachectl -D FOREGROUND

