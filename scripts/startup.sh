#!/bin/bash

# set root password if given 
if [ -n "$MSU_ROOT_PASSWD" ]
then
	echo "root:$MSU_ROOT_PASSWD" | chpasswd
fi

if [ "$1" = "cli" ]
then
	shift
	/opt/marvell/storage/cli/mvcli "$@"
	exit
fi


# start storage agent in background
/opt/marvell/storage/svc/MarvellStorageAgent start


# start web server in background
/opt/marvell/storage/svc/MSUWebService start

# output logs and wait for container stop
tail -f /opt/marvell/storage/apache2/logs/access_log /opt/marvell/storage/apache2/logs/error_log

/opt/marvell/storage/svc/MSUWebService stop
/opt/marvell/storage/svc/MarvellStorageAgent stop
